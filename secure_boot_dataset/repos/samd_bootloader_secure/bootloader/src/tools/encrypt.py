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
def main():
  parser = optparse.OptionParser(usage = 'usage: %prog [options]')
  parser.add_option('-f', '--file', dest='file', help='input file', metavar='FILE')
  parser.add_option('-k', '--key', dest='key', help='encryption key (16 bytes separated with \':\')', metavar='KEY')
  parser.add_option('-o', '--offset', dest='offset', help='destination offset (default 0x800)', default='0x800', metavar='OFFS')
  (options, args) = parser.parse_args()

  if options.file is None:
    error('file name is required')

  if options.key is None:
    key_str = '0:1:2:3:4:5:6:7:8:9:a:b:c:d:e:f'
  else:
    key_str = options.key

  try:
    key = [int(s, 16) for s in key_str.split(':')]
  except ValueError, inst:
    error('malformed encryption key')

  if len(key) != 16:
    error('malformed encryption key')

  try:
    offset = int(options.offset, 0)
  except ValueError, inst:
    error('invalid offset value: %s' % options.offset)

  try:
    data = data = [ord(x) for x in open(options.file, 'rb').read()]
    out = open(options.file + '.enc', 'wb')
  except Exception, inst:
    error(inst)

  while len(data) % 256 > 0:
    data += [0xff]

  size = len(data)
  blocks = [data[i:i + 256] for i in xrange(0, len(data), 256)]

  nonce = [ord(z) for z in os.urandom(16)]
  unlock = uint32(0x78656c41) + uint32(offset) + uint32(size) + nonce

  out.write(''.join([chr(d) for d in unlock]))

  state = spritz.Spritz()
  state.absorb(key)
  state.absorb(unlock)
  session_key = state.squeeze(16)

  for idx, blk in enumerate(blocks):
    block = uint32(0x78656c41) + uint32(offset)

    encrypt_state = spritz.Spritz()
    encrypt_state.absorb(session_key)
    encrypt_state.absorb_byte(ord('E'))
    encrypt_state.absorb(block)

    block += encrypt_state.encrypt(blk)

    auth_state = spritz.Spritz()
    auth_state.absorb(session_key)
    auth_state.absorb_byte(ord('A'))
    auth_state.absorb(block)

    block += auth_state.squeeze(16)

    out.write(''.join([chr(d) for d in block]))
    offset += 256

  print 'Done'

#------------------------------------------------------------------------------
main()

