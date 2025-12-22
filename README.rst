LuaLibraries / LuaCmdArgs
=========================

A little utility for grabbing command line arguments, classifying them and
returning them in an Args record...

.. code-block:: lua

  local record Args
     flags      : {string:boolean}
     options    : {string:string}
     positional : {string}
  end

::

  A *flag* sets a named arg to boolean `true`. The named arg can take these forms:
  
  -x
  --name

  An *option* sets a named arg to a value. The named arg and value can take these
  forms:

  -x=value        (must be a single char after '-')
  --name=value    (one or more chars after '--')

  Anything else is a *positional* argument

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

