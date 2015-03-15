# Lifelike

[![Build
Status](https://travis-ci.org/mxhold/lifelike.svg?branch=master)](https://travis-ci.org/mxhold/lifelike)
[![Code
Climate](https://codeclimate.com/github/mxhold/lifelike/badges/gpa.svg)](https://codeclimate.com/github/mxhold/lifelike)
[![Test
Coverage](https://codeclimate.com/github/mxhold/lifelike/badges/coverage.svg)](https://codeclimate.com/github/mxhold/lifelike)

Lifelike plays [Conway's Game of
Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) by default but it
can be used to simulate any [Life-like cellular
automata](https://en.wikipedia.org/wiki/Life-like_cellular_automaton).

## Rationale

This gem is inspired by the [Global Day of
Coderetreat](http://globalday.coderetreat.org/) where participants attempt to
implement Conway's Game of Life under various constraints.

The goal of this implementation is to make the code as well-factored as possible
rather than as efficient as possible.

## Installation

    $ gem install lifelike

## Usage

By default, Lifelike plays [Conway's Game of
Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

It gets it initial state from standard input or a file and then prints the next
generation:

```bash
$ echo "...\nooo\n..." > blinker
$ cat blinker
...
ooo
...
$ cat blinker | lifelike
.o.
.o.
.o.
$ lifelike blinker
.o.
.o.
.o.
```

### Multiple generations

You can also provide a number of generations to simulate before printing:

```bash
$ echo "..o..\no.o..\n.oo..\n....." > glider
$ cat glider
..o..
o.o..
.oo..
.....
$ cat glider | lifelike -c 4
.....
...o.
.o.o.
..oo.
```

### Alternate dead/alive characters

You don't have to use `o` and `.` to represent life and death.
Lifelike will be smart and try to guess based on the input provided:

```bash
$ echo "000\n111\n000" | lifelike
010
010
010
$ echo "   \nXXX\n   " | lifelike
 X
 X
 X
```

You can use any combination of two of the following characters (which are in
order here from what lifelike will consider more dead to more alive):

    <space> _ . , o O 0 1 x * X # @

### Game of Life variants

You can define the rules Lifelike will use with the `-r` flag.

By default, it uses the rules for Conway's Game of Life, which are `B3/S23`.

This format of specifying the rules means:

- It takes 3 live neighbors for a cell to be **b**orn
- It takes 2 or 3 live neighbors for a cell to **s**tay alive

One interesting variant is called
[Seeds](https://en.wikipedia.org/wiki/Seeds_(cellular_automaton)) which has the
rule `B2/S`, meaning:

- It takes 2 live neighbors for a cell to be born
- No cells ever survive

This is how you would make Lifelike play this variant:

```bash
$ echo ".......\n.......\n..oo..\n.......\n......." | lifelike -r "B2/S"
.......
..oo...
......
..oo...
.......
$ echo ".......\n.......\n..oo..\n.......\n......." | lifelike -r "B2/S" -c 2
..oo...
.......
.o..o.
.......
..oo...
```

## Contributing

1. Fork it ( https://github.com/mxhold/lifelike/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
