#------------------------------------------------------------------------------
class Spritz:
  N = 256

  #----------------------------------------------------------------------------
  def __init__(self):
    self.initialize_state()

  #----------------------------------------------------------------------------
  def initialize_state(self):
    self.i = 0
    self.j = 0
    self.k = 0
    self.z = 0
    self.a = 0
    self.w = 1
    self.s = range(self.N)

  #----------------------------------------------------------------------------
  def absorb(self, data):
    for b in data:
      self.absorb_byte(b)

  #----------------------------------------------------------------------------
  def absorb_byte(self, b):
    self.absorb_nibble(b & 0x0f)
    self.absorb_nibble(b >> 4)

  #----------------------------------------------------------------------------
  def absorb_nibble(self, x):
    if self.N / 2 == self.a:
      self.shuffle()

    t = self.s[self.a]
    self.s[self.a] = self.s[(self.N / 2 + x) % self.N]
    self.s[(self.N / 2 + x) % self.N] = t

    self.a = (self.a + 1) % self.N

  #----------------------------------------------------------------------------
  def absorb_stop(self):
    if self.N / 2 == self.a:
      self.shuffle()

    self.a = (self.a + 1) % self.N

  #----------------------------------------------------------------------------
  def shuffle(self):
    self.whip()
    self.crush()
    self.whip()
    self.crush()
    self.whip()

    self.a = 0

  #----------------------------------------------------------------------------
  def whip(self):
    for i in range(2 * self.N):
      self.update()

    self.w = (self.w + 2) % self.N

  #----------------------------------------------------------------------------
  def crush(self):
    for v in range(self.N / 2):
      i = self.N - 1 - v
      sv = self.s[v]
      si = self.s[i]

      if sv > si:
        self.s[v] = si
        self.s[i] = sv

  #----------------------------------------------------------------------------
  def squeeze(self, size):
    if self.a > 0:
      self.shuffle()

    return [self.drip() for i in range(size)]

  #----------------------------------------------------------------------------
  def drip(self):
    if self.a > 0:
      self.shuffle()

    self.update()

    return self.output()

  #----------------------------------------------------------------------------
  def update(self):
    self.i = (self.i + self.w) % self.N
    self.j = (self.k + self.s[(self.j + self.s[self.i]) % self.N]) % self.N
    self.k = (self.i + self.k + self.s[self.j]) % self.N

    t = self.s[self.i]
    self.s[self.i] = self.s[self.j]
    self.s[self.j] = t

  #----------------------------------------------------------------------------
  def output(self):
    self.z = self.s[(self.j + self.s[(self.i + self.s[(self.z + self.k) % self.N]) % self.N]) % self.N]
    return self.z

  #----------------------------------------------------------------------------
  def key_setup(self, k):
    self.initialize_state()
    self.absorb(k)

  #----------------------------------------------------------------------------
  def encrypt(self, data):
    return [(d + self.drip()) % self.N for d in data]

  #----------------------------------------------------------------------------
  def decrypt(self, data):
    return [(d - self.drip()) % self.N for d in data]
