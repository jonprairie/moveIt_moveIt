moveIt_moveIt.vim
=================

necessity
---------

This plugin arose out of my dissatisfaction with moving lines of code around in Vim. This task was made especially annoying when using rnu (relativelinenumber), an option which, in all other respects, is absolutely awesome. My remedy for this was to create a "dual-layered" operator, an operator which takes two motions. One motion to define the code block which is to be moved, the second to describe the movement itself.

As I used this plugin I occasionally needed similar functionality, but with a copy action instead of a move. That led to the development of the second half of this plugin, which now offers analogous copy operators for each of the moves.

mappings
------------

### move ###
* `Mf` moves lines forwards (down), moved lines are placed on a new line BELOW the line that the second movement ends on.
* `Mr` moves lines backwards (up), moved lines are placed on a new line ABOVE the line that the second movement ends on.
* `Mff` grabs the current line, 'skips' the first motion and waits for the second motion to define where to move the current line. Synonym for `0v$Mf`.
* `Mrr` is the same, but for backwards motions.

### copy ###
* `Md` copies lines forwards.
* `Me` copies lines backwards.
* `Mdd` copies current line forwards.
* `Mee` copies current line backwards.

syntax
------

(Mf|Mb) + (motion|text-object|operator-pending etc) + motion

(Mff|Mbb) + motion

visually-selected-text + (Mf|Mb) + motion

examples
--------

To move the first three lines in the following example below the last line (if the cursor is currently somewhere on "line 1") type `Mf2j4j`:

	line 1
	line 2
	line 3

	line 5

After this sequence, the lines become:

	line 5
	line 1
	line 2
	line 3

To do the inverse, with cursor on "line 1", type `Mr2j2k`. After this sequence the lines will revert back to their original positions:

	line 1
	line 2
	line 3

	line 5

To move text in parentheses down two lines (supposing the cursor is within the parentheses), type `Mfi(j`:

    print("hello world")

becomes:

    print()

    "hello world"

*Note* that the initial, "selection" motion can be character-wise or line-wise (or visually-selected text), but the second motion (to define the actual movement) is always line-wise. This means that the moved text will always be placed on a new line, there's no way to move text left or right within a target line. This may change in a later release, but I haven't had a need for it yet. 

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
