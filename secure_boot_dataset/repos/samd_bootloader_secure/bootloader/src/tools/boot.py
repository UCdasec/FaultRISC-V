#!/usr/bin/env python

import os
import sys
import time
import serial
import optparse

#------------------------------------------------------------------------------
BOOTLOADER_SIZE     = 4096
BAUDRATE            = 115200

#------------------------------------------------------------------------------
BL_CMD_UNLOCK       = 0xa0
BL_CMD_DATA         = 0xa1
BL_CMD_VERIFY       = 0xa2
BL_CMD_RESET        = 0xa3

BL_RESP_OK          = 0x50
BL_RESP_ERROR       = 0x51
BL_RESP_INVALID     = 0x52
BL_RESP_VERIFY_OK   = 0x53
BL_RESP_VERIFY_FAIL = 0x54


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
  if isinstance(v, list):
    return (v[3] << 24) | (v[2] << 16) | (v[1] << 8) | v[0]
  else:
    return [(v >> 0) & 0xff, (v >> 8) & 0xff, (v >> 16) & 0xff, (v >> 24) & 0xff]

#------------------------------------------------------------------------------
def check_block(block):
  if len(block) < 4 and block[0:3] != uint32(0x78656c41):
    error('malformed input file')

#------------------------------------------------------------------------------
def get_response(port):
  v = port.read()

  if len(v) == 0:
    return None
  elif len(v) > 1:
    error('invalid response received (size > 1)')

  return ord(v[0])

#------------------------------------------------------------------------------
def send_request(port, cmd, data = []):
  req = [cmd] + data

  for i in range(3):
    port.write(''.join(map(chr, req)))
    resp = get_response(port)

    if resp is None:      
      # do not show first warning      
      if i > 0 :
        warning('no response received, retrying %d' % (i+1))
      time.sleep(0.2)
    else:
      return resp

  error('no response received, giving up')

#------------------------------------------------------------------------------
def main():
  parser = optparse.OptionParser(usage = 'usage: %prog [options]')
  parser.add_option('-q', '--quiet', dest='quiet', help='disable verbose output', default=False, action='store_true')
  parser.add_option('-t', '--tune', dest='tune', help='auto-tune UART baudrate', default=False, action='store_true')
  parser.add_option('-i', '--interface', dest='port', help='communication interface', metavar='PATH')
  parser.add_option('-f', '--file', dest='file', help='binary file to program', metavar='FILE')
  parser.add_option('', '--boot', dest='boot', help='enable write to the bootloader area', default=False, action='store_true')
  (options, args) = parser.parse_args()

  if options.port is None:
    error('communication port is required (try -h option)')

  if options.file is None:
    error('file name is required')

  # default verbose
  options.verbose = not options.quiet

  try:
    port = serial.Serial(options.port, BAUDRATE, timeout=1)
  except serial.serialutil.SerialException, inst:
    error(inst)

  if options.tune:
    verbose(options.verbose, 'Auto-tuning UART baudrate')
    port.send_break(duration=0.01)
    port.write(chr(0x55))

  try:
    data = [ord(x) for x in open(options.file, 'rb').read()]
  except Exception, inst:
    error(inst)

  block_size = 4 + 4 + 256 + 16

  unlock = data[0:28]
  blocks = [data[28 + i:28 + i + block_size] for i in xrange(0, len(data)-28, block_size)]

  check_block(unlock)

  for blk in blocks:
    check_block(blk)

  offset = uint32(unlock[4:8])

  if offset < BOOTLOADER_SIZE and options.boot == False:
    error('offset is within the bootlaoder area, use --boot options to unlock writes')

  verbose(options.verbose, 'Unlocking')
  resp = send_request(port, BL_CMD_UNLOCK, unlock)

  if resp != BL_RESP_OK:
    error('invalid response code (0x%02x). Check that your file size and offset are correct.' % resp)

  verbose(options.verbose, 'Uploading %d blocks at offset %d (0x%x)' % (len(blocks), offset, offset))

  addr = offset

  for idx, blk in enumerate(blocks):
    verbose(options.verbose, '... block %d of %d' % (idx+1, len(blocks)))

    resp = send_request(port, BL_CMD_DATA, blk)

    if resp != BL_RESP_OK:
      error('invalid response code (0x%02x)' % resp)

  verbose(options.verbose, 'Verification')
  resp = send_request(port, BL_CMD_VERIFY, uint32(0x78656c41))

  if resp == BL_RESP_VERIFY_OK:
    verbose(options.verbose, '... success')
  else:
    error('... fail (status = 0x%02x)' % resp)

  verbose(options.verbose, 'Rebooting')

  send_request(port, BL_CMD_RESET, uint32(0x78656c41) + uint32(0) * 4)

  verbose(options.verbose, 'Done!')

  port.close()

#------------------------------------------------------------------------------
main()
