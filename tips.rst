.. _tips:
TIPS
====

Here are some tips for writing ACOM (CODA?) files. They should be somewhat
modeled after the `APOD <https://apod.nasa.gov/>`_ layout, and come with some cute graphic
created by the software. Ideally in a reproducable way.

layout
------

Each page needs a constant look and feel, which is what APOD does.

- title + big figure + short blurb, all visible on main page of most big browsers (sorry phone users?)
- below this you scroll down to the meat of the paper.  Interspersing some commands needed to make some
  figures or produce some interesting output.
- text should not contain too many astro-lingo
- each ACOM in a separate directory with figures, scripts, should have a reproducible install (via Makefile)
- make use of standard datasets (so they can be re-used) somewhere. make a separate acom-data ?
  For example https://github.com/pyspeckit/pyspeckit-tests/blob/master/3C286.fits
- references at the bottom with a "SEE ALSO" section of external references?



math
----

It can do math

:math:`\frac{ \sum_{t=0}^{N}f(t,k) }{N}`

lists
-----

- a bullet list
- another bullet

1) enumerated
2) more enumeration
3) and finally

links
-----

.. _ASCL:  http://ascl.net


code
----

Here is some code that I don't like to see , you cannot cut and paste

   >>> import astropy
   >>> import numpy as np


code link
---------

We can also provide a code 
:download:`eagle.sh <eagle/eagle.sh>`

code displayed
--------------

Here is the same code, eagle.sh, displaying inline with linenumber, and we can highlight selected
lines by their linenumbers. 13 and 14 in this case

.. literalinclude:: eagle/eagle.sh
   :linenos:
   :emphasize-lines: 13,14

.. DANGER::
   We should warn for dangerous things too

smart code
----------


.. compound::

   The 'rm' command is very dangerous.  If you are logged
   in as root and enter ::

       cd /
       rm -rf *

   you will erase the entire contents of your file system. 
