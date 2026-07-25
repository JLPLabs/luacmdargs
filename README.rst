LuaLibraries / LuaCmdArgs
=========================

A little utility for grabbing command line arguments, classifying them and
returning them in an Args record...

.. code-block:: lua

  local record Args
     flags      : {string:boolean|integer}
     options    : {string:string}
     positional : {string}
  end

flag
----

Single dash with single character (``-v``) or double dash and a word (``--verbose``).

Existence on command line sets a flag to ``true``, or a count, if multiple occur (e.g, ``-v`` ``-v`` ``-v``, or ``-vvv`` sets flags[v]=3).

::

  -x
  -x -v
  -xv           # stacked form
  --name


option
------

Single dash with following value (``-o=main.s``) or double dash key equal value (``--out=main.s``).

Sets a named arg to a value.

::

  -x=value
  --name=value

positional
----------

Anything without a leading ``-`` or ``--`` is a positional argument. The arg is
added to the positional list.


::

  gcc main.c

::

  NOTE   Unlike other command line argument tools, the user of the library does
         not pass a specification of expected flags, options or positions to use
         the library.


API Reference
=============

function parse_args(argv: {string}): Args
-----------------------------------------

Given an array of strings (such as the ``arg`` global), returns the parsed
command line arguments in an ``Arg`` structure.

**Parameters:**

* ``argv {string}`` - array of strings to parse

**Returns:**

* ``Arg`` structure that holds the flags, options and positional values found in
  ``argv``.

Example
=======

These two commands will result in similar, but **not** identical, Args record. You will need to convert these values into a standardized (for your use) configuration record.

::

  local Args = require "luacmds"
  args = Args.parse_args(arg)  

(1) ``% mycmd -vl -o=tmp.txt tmp.c``
------------------------------------

::

  args.flags.v = true
  args.flags.l = true
  args.options.o = "tmp.txt"
  args.positional = {"tmp.c"}
 
(2) ``% mycmd --verbose --log --out=tmp.txt tmp.c``
---------------------------------------------------

::

  args.flags.verbose = true
  args.flags.log = true
  args.options.out = "tmp.txt"
  args.positional = {"tmp.c"}
