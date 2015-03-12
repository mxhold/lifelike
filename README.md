# Lifelike

Lifelike plays [Conway's Game of
Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) by default but it
can be used to simulate any [Life-like cellular
automata](https://en.wikipedia.org/wiki/Life-like_cellular_automaton).

## Rationale

This gem is inspired by the [Global Day of
Coderetreat](http://globalday.coderetreat.org/) where participants attempt to
implement Conway's Game of Life under various constraints.

### It's so slow!

Yes, for big worlds and/or large numbers of generations Lifelike can take several
seconds to finish. This is not surprising given that each generation requires
initializing as many objects as there are cells and Ruby in general is not super
fast.

The goal of this implementation is to make the code as well-factored as possible
rather than as efficient as possible.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lifelike'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lifelike

## Usage

### Default behavior

By default, Lifelike plays [Conway's Game of
Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

It gets it initial state from stdin and then prints the next generation:

```
$ echo "010\n010\n010" > blinker
$ cat blinker
010
010
010
$ cat blinker | lifelike
000
111
000
```

You can also provide a number of generations to simulate before printing:

```
$ echo "00100\n10100\n01100\n00000" > glider
$ cat glider
00100
10100
01100
00000
$ cat glider | lifelike 4
00000
00010
01010
00110
```

You don't have to use ones and zeros to represent life and death.
Lifelike will be smart and try to guess:

```
$ echo "...\nooo\n..." | lifelike
.o.
.o.
.o.
$ echo "   \nXXX\n   " | lifelike
 X 
 X 
 X 
```

### Game of Life variants

You can define the rules Lifelike will use with the `-r` flag.

By default, it uses the rules for Conway's Game of Life, which are "B3/S23".

This format of specifying the rules means:

- It takes 3 live neighbors for a cell to be *b*orn
- It takes 2 or 3 live neighbors for a cell to *s*tay alive

One interesting variant is called
[Seeds](https://en.wikipedia.org/wiki/Seeds_(cellular_automaton)) which has the
rule "B2/S", meaning:

- It takes 2 live neighbors for a cell to be born
- No cells ever survive

This is how you would make Lifelike play this variant:

```
$ echo "0000000\n0000000\n0011000\n0000000\n0000000" | lifelike -r "B2/S"
0000000
0011000
0000000
0011000
0000000
$ echo "0000000\n0000000\n0011000\n0000000\n0000000" | lifelike 2 -r "B2/S"
0011000
0000000
0100100
0000000
0011000
```

## Contributing

1. Fork it ( https://github.com/mxhold/lifelike/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
