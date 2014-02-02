; keep patterns 1 & 2 as below

[PATTERN.1]
TITLE = Select a Pattern File
; defaultRule is not needed. Taken from file.
defaultRule = none
game = 
altNeighbor =
prefFont = 2
; keep values as listed, as data comes from pattern file. 
height = 0
width = 0
optimumHeight = 0 
optimumWidth = 0
patternFrom = prompt

[PATTERN.2]
TITLE = C.A. development
; if default is blank, then prompt for all CA info
defaultRule = 
game = 
altNeighbor =
prefFont = 2
height = 1
width = 1
optimumHeight = 95 
optimumWidth = 95
; binary C.A.'s are 1d and have only one data line. 
; Multiple values in the line are allowed.
patternFrom = here
patData.1 = 1

[PATTERN.3]
TITLE = Random pattern (from Random.lif)
defaultRule = none
game = 
altNeighbor =
prefFont = 3
height = 10
width = 10
optimumHeight = 0 
optimumWidth = 0
patternFrom = random.lif

[PATTERN.4]
TITLE = Enter Life Pattern from Keyboard:
defaultRule = S23/B3/2
game = LIFE
altNeighbor = 
prefFont = 1
height = 15
width = 15
optimumHeight = 0 
optimumWidth = 0
patternFrom = keyboard

[PATTERN.5]
TITLE = Two Gliders
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 1
height = 3
width = 8
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 00100010
patData.2 = 10100011
patData.3 = 01100101

[PATTERN.6]
TITLE = unknown tetromino
defaultRule = S23/B3/2
game = LIFE
altNeighbor = 
prefFont = 1
height = 2
width = 3
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 010
patData.2 = 111

[PATTERN.7]
TITLE = 1 of 8 rule
defaultRule = S123456789/B1/2
game = LIFE
altNeighbor =
prefFont = 1
height = 1
width = 1
optimumHeight = 20 
optimumWidth = 20
patternFrom = here
patData.1 = 1

[PATTERN.8]
TITLE = Majority of live cells rule
defaultRule = S56789/B56789/2
game = LIFE
altNeighbor = M9
prefFont = 1
height = 3
width = 13
optimumHeight = 40 
optimumWidth = 40
patternFrom = here
patData.1 = 1111111111110
patData.2 = 1111111100011
patData.3 = 0111001111011
patData.4 = 1111111100011
patData.5 = 0111001111011

[PATTERN.9]
TITLE = R-pentomino
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 3
height = 3
width = 3
optimumHeight = 100
optimumWidth = 100
patternFrom = here
patData.1 = 011
patData.2 = 110
patData.3 = 010

[PATTERN.10]
TITLE = Queen Bee Shuttle
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 1
height = 7
width = 22
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 0000000000100000000000
patData.2 = 0000000000111100000000
patData.3 = 1100000000011110000011
patData.4 = 1100000000010010000011
patData.5 = 0000000000011110000000
patData.6 = 0000000000111100000000
patData.7 = 0000000000100000000000

[PATTERN.11]
TITLE = Three Light Weight Space Ships
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 1
height = 22
width = 9
optimumHeight = 40 
optimumWidth = 40
patternFrom = here
patData.1 = 001001000
patData.2 = 000000100
patData.3 = 001000100
patData.4 = 000111100
patData.5 = 000000000
patData.6 = 000000000
patData.7 = 000100100
patData.8 = 001000000
patData.9 = 001000100
patData.10 = 001111000
patData.11 = 000000000
patData.12 = 000000000
patData.13 = 000000000
patData.14 = 000000000
patData.15 = 000000000
patData.16 = 000000000
patData.17 = 000000000
patData.18 = 000000111
patData.19 = 000001001
patData.20 = 000000001
patData.21 = 000000001
patData.22 = 000001010

[PATTERN.12]
TITLE = Replicator for HighLife
defaultRule = S23/B36/2
game = LIFE
altNeighbor =
prefFont = 3
height = 4
width = 6
optimumHeight = 60 
optimumWidth = 60
patternFrom = here
patData.1 = 001110
patData.2 = 000001
patData.3 = 000001
patData.4 = 000001

[PATTERN.13]
TITLE = Heavy Weight Space Ship
defaultRule = S23/B3/2
game = LIFE
altNeighbor = 
prefFont = 1
height = 5
width = 7
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 0011000
patData.2 = 1000010
patData.3 = 0000001
patData.4 = 1000001
patData.5 = 0111111

[PATTERN.14]
TITLE = Pentadecathlon (period-15 oscill.)
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 1
height = 1
width = 10
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 1111111111

[PATTERN.15]
TITLE = Pulsar (period-3 oscill.)
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 1
height = 5
width = 4
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 0010
patData.2 = 0111
patData.3 = 0101
patData.4 = 0111
patData.5 = 0010

[PATTERN.16]
TITLE = Blinker (period-2 oscillator)
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 1
height = 1
width = 3
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 111

[PATTERN.17]
TITLE = Kickback Reaction
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 1
height = 7
width = 4
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 0100
patData.2 = 0101
patData.3 = 0110
patData.4 = 0000
patData.5 = 1000
patData.6 = 0110
patData.7 = 1100

[PATTERN.18]
TITLE = '5-5-5-5-5-5-5'
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 3
height = 42
width = 1
optimumHeight = 200 
optimumWidth = 100
patternFrom = here
patData.1 =  1
patData.2 =  1
patData.3 =  1
patData.4 =  1
patData.5 =  1
patData.6 =  0
patData.7 =  1
patData.8 =  1
patData.9 =  1
patData.10 = 1
patData.11 = 1
patData.12 = 0
patData.13 = 1
patData.14 = 1
patData.15 = 1
patData.16 = 1
patData.17 = 1
patData.18 = 0
patData.19 = 1
patData.20 = 1
patData.21 = 1
patData.22 = 1
patData.23 = 1
patData.24 = 0
patData.25 = 1
patData.26 = 1
patData.27 = 1
patData.28 = 1
patData.29 = 1
patData.30 = 0
patData.31 = 1
patData.32 = 1
patData.33 = 1
patData.34 = 1
patData.35 = 1
patData.36 = 0
patData.37 = 1
patData.38 = 1
patData.39 = 1
patData.40 = 1
patData.41 = 1
patData.42 = 0

[PATTERN.19]
TITLE = SpaceShip from File r002x.lif
defaultRule = none 
game = 
altNeighbor =
prefFont = 1
height = 0
width = 0
optimumHeight = 50 
optimumWidth = 75
patternFrom = life\r002x.lif

[PATTERN.20]
TITLE = A pattern for Fredkin's rule
defaultRule = S13/B13/2
game = LIFE
altNeighbor = V4
prefFont = 3
height = 4
width = 3
optimumHeight = 100 
optimumWidth = 100
patternFrom = here
patData.1 = 100
patData.2 = 111
patData.3 = 100
patData.4 = 000

[PATTERN.21]
TITLE = Glider gun
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 2
height = 9
width = 36
optimumHeight = 40 
optimumWidth = 55
patternFrom = here
patData.1 = 000000000000000000000000010000000000
patData.2 = 000000000000000000000011110000100000
patData.3 = 000000000000010000000111100000100000
patData.4 = 000000000000101000000100100000000011
patData.5 = 000000000001000110000111100000000011
patData.6 = 110000000001000110000011110000000000
patData.7 = 110000000001000110000000010000000000
patData.8 = 000000000000101000000000000000000000
patData.9 = 000000000000010000000000000000000000

[PATTERN.22]
TITLE = 3-4 Life: Bleeper, Y, T, Clock, Spaceship
defaultRule = S34/B34/2
game = LIFE
altNeighbor =
prefFont = 2
height = 11
width =  29
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1  = 00000000000000000000000000010
patData.2  = 00000000001000000000000001110
patData.3  = 00000000110000000100000000011
patData.4  = 10000000010000000111000000100
patData.5  = 11000000000000000100000000000
patData.6  = 01000000000000000000000000000
patData.7  = 00000000000000000000000000000
patData.8  = 00000000001000000000000000000
patData.9  = 00000000010110000000000000000
patData.10 = 00000000010110000000000000000
patData.11 = 00000000001000000000000000000

[PATTERN.23]
TITLE = SpaceShip from File r004x.lif
defaultRule = none
game = 
altNeighbor =
prefFont = 1
height = 0
width = 0
optimumHeight = 0 
optimumWidth = 0
patternFrom = life\r004x.lif

[PATTERN.24]
TITLE = A pattern for HighLife
defaultRule = S23/B36/2
game = LIFE
altNeighbor =
prefFont = 3
height = 4
width = 4
optimumHeight = 100 
optimumWidth = 100
patternFrom = here
patData.1 = 1110
patData.2 = 0001
patData.3 = 0001
patData.4 = 0001

[PATTERN.25]
TITLE = AK47 glider generator - File ak47.lif
defaultRule = none
game = 
altNeighbor =
prefFont = 2
height = 35
width = 30
optimumHeight = 0 
optimumWidth = 100
patternFrom = life\ak47.lif

[PATTERN.26]
TITLE = Garden of Eden
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 3
height = 14
width = 14
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 =  10111111111111
patData.2 =  11101010101101
patData.3 =  01110101010111
patData.4 =  11101111111110
patData.5 =  10110111110101
patData.6 =  11111101111110
patData.7 =  10111011010101
patData.8 =  01010111111110
patData.9 =  11111110111101
patData.10 = 01110101110110
patData.11 = 11101010101111
patData.12 = 11110111011010
patData.13 = 10111011101101
patData.14 = 11010101011010

[PATTERN.27]
; This pattern number is used for checkpoint/restart initialization
; if no pattern is currently active
TITLE = Dummy Pattern for CP/RS
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 1
height = 1
width = 1
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 1

[PATTERN.28]
TITLE = Example of embedded patterns
defaultRule = S23/B3/2
game = LIFE
altNeighbor =
prefFont = 2
height = 10
width = 20
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 00000000000000000000
patData.2 = 000#G000000000000000
patData.3 = 00000000000000000000
patData.4 = 00000000000000000000
patData.5 = 0000000000000000#G00
patData.6 = 00000000000000000000
patData.7 = 00000000000000000000

[PATTERN.29]
TITLE = Gas Diffusion Model. Turn wrap off first
defaultRule = MS,D0;8;4;12;2;10;9;14;1;6;5;13;3;11;7;15
game = MARGOLUS
altNeighbor =
prefFont = 1
height = 5
width = 5
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 11111
patData.2 = 11111
patData.3 = 11111
patData.4 = 11111
patData.5 = 11111

[PATTERN.30]
TITLE = Even
defaultRule = S12/B2/2
game = LIFE
altNeighbor =
prefFont = 1
height = 2
width = 4
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 0111
patData.2 = 1110

[PATTERN.31]
TITLE = Old Quilt
defaultRule = S12/B2/2
game = LIFE
altNeighbor =
prefFont = 1
height = 4
width = 4
optimumHeight = 0 
optimumWidth = 0
patternFrom = here
patData.1 = 1111
patData.2 = 1111
patData.3 = 1111
patData.4 = 1111

[PATTERN.32]
TITLE = Langton Self Replicating Loop CA - File langton.rep
defaultRule = none
game = 
altNeighbor =
prefFont = 2
height = 10
width = 15
optimumHeight = 100 
optimumWidth = 100
patternFrom = selfrepl\langton.rep

[PATTERN.33]
TITLE = Majority rules
defaultRule = none
game = 
altNeighbor =
prefFont = 1
height = 0
width = 0
optimumHeight = 50 
optimumWidth = 75
patternFrom = life\majority.lif

[PATTERN.34
TITLE = Light Speed Soliton
defaultRule = S/B2/2
game = LIFE
altNeighbor = U6
prefFont = 1
height = 0
width = 0
optimumHeight = 50 
optimumWidth = 75
patternFrom = HERE
patData.1 = 0010000
patData.2 = 0001000
patData.3 = 0000100
patData.4 = 0000010
patData.5 = 0000001
patData.6 = 0000001
patData.7 = 0000010
patData.8 = 0000100
patData.9 = 0001000
patData.10 =0010000
patData.11 =0000000
patData.12 =1000000
patData.13 =0100000
patData.14 =0010000
patData.15 =0001000
patData.16 =0001000
patData.17 =0010000
patData.18 =0100000
patData.19 =1000000

[PATTERN.35]
TITLE = Diffraction/Dispersion
defaultRule = S124/B4/2
game = LIFE
altNeighbor = U24
prefFont = 3
height = 5
width = 5
optimumHeight = 100 
optimumWidth = 100
patternFrom = HERE
patData.1 = 00100
patData.2 = 00000
patData.3 = 10101
patData.4 = 00000
patData.5 = 00100

[PATTERN.36]
TITLE = Wave front 
defaultRule = S/B2648A/2
game = LIFE
altNeighbor = U9
prefFont = 3
height = 1
width = 32
optimumHeight = 100 
optimumWidth = 100
patternFrom = HERE
patData.1 = 10000000000000000000000000000001

[PATTERN.37]
TITLE = Binary Rule 45 with multiple starting values
defaultRule = D45/2
game = Binary
altNeighbor =
prefFont = 2
height = 1
width = 1
optimumHeight = 195 
optimumWidth = 195
; binary C.A.'s are 1d and have only one data line. 
; Multiple values in the line are allowed.
patternFrom = here
patData.1 = 1010111001

[PATTERN.38]
TITLE = Enter Pattern for 2nd order CA:
defaultRule = S23/B3/2
game = SECOND ORDER
altNeighbor = 
prefFont = 1
height = 15
width = 15
optimumHeight = 0 
optimumWidth = 0
patternFrom = keyboard

[PATTERN.39]
TITLE = Brian's Brain
defaultRule = S/B2/3
game = Life
altNeighbor =
prefFont = 2
height = 1
width = 1
optimumHeight = 100 
optimumWidth = 100
patternFrom = here
patData.1 = 1
patData.2 = 1
; end Drlife.pat keep this comment
