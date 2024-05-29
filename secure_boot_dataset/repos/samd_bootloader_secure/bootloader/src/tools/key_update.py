#!/usr/bin/env python
import os
import sys
import time
import optparse
import spritz

#------------------------------------------------------------------------------
def error(text):
  sys.stderr.write('Error: %s\n' % text)
  sys.exit(-1)

#------------------------------------------------------------------------------
def warning(text):
  sys.stderr.write('Warning: %s\n' % text)

#------------------------------------------------------------------------------
def verbose(verb, text):
  if verb:
    print text

#------------------------------------------------------------------------------
def uint32(v):
  return [(v >> 0) & 0xff, (v >> 8) & 0xff, (v >> 16) & 0xff, (v >> 24) & 0xff]

#------------------------------------------------------------------------------
def parse_key(v):
  try:
    key = [int(s, 16) for s in v.split(':')]
  except ValueError, inst:
    error('malformed encryption key')

  if len(key) != 16:
    error('malformed encryption key')

  return key

#------------------------------------------------------------------------------
def main():
  parser = optparse.OptionParser(usage = 'usage: %prog [options]')
  parser.add_option('-f', '--file', dest='file', help='output file', metavar='FILE')
  parser.add_option('-k', '--key', dest='key', help='old encryption key (16 bytes separated with \':\')', metavar='OLD_KEY')
  parser.add_option('-n', '--new', dest='new', help='new encryption key (16 bytes separated with \':\')', metavar='NEW_KEY')
  (options, args) = parser.parse_args()

  if options.file is None:
    error('file name is required')

  if options.new is None:
    error('new encryption key is required')
  else:
    new_key = parse_key(options.new)

  if options.key is None:
    error('old encryption key is required')
  else:
    key = parse_key(options.key)

  try:
    out = open(options.file, 'wb')
  except Exception, inst:
    error(inst)

  size = 256
  offset = 2048 - size
  data = new_key + [0xff] * (size - 16)
  nonce = [ord(z) for z in os.urandom(16)]
  unlock = uint32(0x78656c41) + uint32(offset) + uint32(size) + nonce

  out.write(''.join([chr(d) for d in unlock]))

  state = spritz.Spritz()
  state.absorb(key)
  state.absorb(unlock)
  session_key = state.squeeze(16)

  block = uint32(0x78656c41) + uint32(offset)

  encrypt_state = spritz.Spritz()
  encrypt_state.absorb(session_key)
  encrypt_state.absorb_byte(ord('E'))
  encrypt_state.absorb(block)

  block += encrypt_state.encrypt(data)

  auth_state = spritz.Spritz()
  auth_state.absorb(session_key)
  auth_state.absorb_byte(ord('A'))
  auth_state.absorb(block)

  block += auth_state.squeeze(16)

  out.write(''.join([chr(d) for d in block]))

  print 'Done'

#------------------------------------------------------------------------------
main()

