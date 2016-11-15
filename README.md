moveIt_moveIt.vim
=================
***re-work the key sequences required to move/copy blocks of code***
- - - -

necessity
---------

I don't really care for the standard pattern that goes something like: d + motion + motion + P. I especially do not like that the initial delete operation re-sequences the line-numbers, making the second motion slightly more difficult. Additionally, on a conceptual level, I do not think of the operation as "delete", "jump", "paste", I think of it as one atomic operation, "move".

So this plugin uses a more mnemonic (for me at least) sequence: m + motion + motion. The first motion defines the block of code to be moved, delimited by the line the cursor was originally on and the line the motion would have brought the cursor to, inclusive, provided that the motion is a line motion. If the motion is, instead, a char motion, then the text to be moved is that which is delimited by the cursor and the position where the cursor would have ended up after the motion.

The second motion defines where the block of code will be moved to. If this motion moves 'up' in the buffer, then the code will be moved to a new line above the targeted line. Otherwise, if the motion moves 'down', the code will be moved to a new line below the targeted line. The second motion must move outside the block of text defined with the first motion.

***Note*** There is a second half to this plugin which offers an analogous copy operation initiated by the key sequence mc.

mappings
------------

### move ###
* `m` - move lines, waits for two separate motions, one to delimit the code to move, the second to define the location of the move.
* `mm` move current line, waits for a single motion that defines where to move the current line.

***Note*** that the "marking" functionality of `m` is re-mapped to `M`. You can flip these mappings, so `M` is used in the moveIt_moveIt commands and `m` remains the mark command, by setting `g:moveIt_moveIt_alt_mappings=1`.

### copy ###
* `mc` copy lines, waits for two separate motions, one to delimit the code to copy, the second to define the location to copy to.
* `mcc` copy current line, waits for a single motion that defines where to copy the current line.

syntax
------

### move/copy lines ###
`( m | mc ) + ( motion | text-object | operator-pending etc ) + motion`

### move/copy current line ###
`( mm | mcc ) + motion`

### move/copy visually-selected text ###
`visually-selected-text + ( m | mc ) + motion`

examples
--------

To move the first three lines in the following example below the last line (if the cursor is currently somewhere on "line 1") type `m2j4j`:

	line 1
	line 2
	line 3

	line 5

After this sequence, the lines become:

	line 5
	line 1
	line 2
	line 3

To do the inverse, with cursor on "line 1", type `m2j2k`. After this sequence the lines will revert back to their original positions:

	line 1
	line 2
	line 3

	line 5

To move text in parentheses down two lines (supposing the cursor is within the parentheses), type `mi(j`:

    print("hello world")

becomes:

    print()

    "hello world"

***Note*** that the initial, "selection" motion can be character-wise or line-wise (or visually-selected text), but the second motion (to define the actual movement) is always line-wise. This means that the moved text will always be placed on a new line, there's no way to move text laterally within a target line. This may change in a later release but I haven't had a need for it yet. 

installation - (pathogen)
-------------------------

### *nix ###

	cd ~/.vim/bundle
	git clone git://github.com/jonprairie/moveIt_moveIt.git

### windows ###
where $HOME is the vim home directory:

	cd $HOME/vimfiles/bundle
	git clone git://github.com/jonprairie/moveIt_moveIt.git

license
-------
copyright (c) Jonathan Prairie. Distributed under Vim's license.
