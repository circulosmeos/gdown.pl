gdown.pl
========

Google Drive direct download of big files

Requirements
============

*wget* and *Perl* must be in the PATH.   
**Windows** and **linux** compatible.

Usage
=====

Use Google Drive shareable links, viewable by anyone:   

    $ ./gdown.pl 'gdrive file url' ['desired file name']   

Example
=======

For example, to download [this video](https://drive.google.com/file/d/0B1L_hFrWJfRhLUJZdXdSdTdfSWs/edit) from my [axolotl project](https://circulosmeos.wordpress.com/2015/03/04/axolotl-a-simple-plain-text-documentation-system/), just copy the url, and give a file name if desired:

    $ ./gdown.pl https://drive.google.com/file/d/0B1L_hFrWJfRhLUJZdXdSdTdfSWs/edit axolotl.mp4   

As long as a file name is indicated (second parameter), gdown.pl **will try to resume the partially downloaded file** if an incomplete file with that name already exists. Please note that for this to work, wget must correctly provide --spider with --server-response (-S). Wget v1.17 at least is advised.

License
=======

Distributed [under GPL 3](http://www.gnu.org/licenses/gpl-3.0.html)

More info
=========

[https://circulosmeos.wordpress.com/2014/04/12/google-drive-direct-download-of-big-files](https://circulosmeos.wordpress.com/2014/04/12/google-drive-direct-download-of-big-files)

Contact
=======

by [circulosmeos](loopidle@gmail.com)   
