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

Resuming a download
===================

As long as a file name is indicated as **second parameter**, `gdown.pl` **will try to resume the partially downloaded file** if an incomplete file with that name already exists. Please note that for this to work, wget must correctly provide `--spider` with `--server-response` (`-S`). `wget` v1.17 at least is advised.

Download protected files
========================

Download of protected files can be done manually exporting browers' auth cookies. With firefox or chrome browsers:

    1. authenticate in google drive or get access to the file download (and stop there, as you want to download it with gdown.pl)

    2. Now the browser has all the needed cookies: install [cookies-txt for firefox](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) and export them (all), or [editthiscookie for chrome](https://chrome.google.com/webstore/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg?hl=en) (in this case, change in **Options** the format of exportation to **Netscape HTTP Cookie File**)

    3. if using firefox and "cookies-txt" addon, open the `cookies.txt` exported file and remove the string "#HttpOnly_" from all lines. With vim this suffices: ":%s/^#HttpOnly_//" (and ":wq" to exit). If you're an experienced txt master, maintain only "^[^\s]*.google.com" lines, and remove from them the string "#HttpOnly_".

    4. copy the (cookies.txt) modified content (if using firefox and cookies-txt) or copy directly from the clipboard (if using chrome and editthiscookie addon) to `gdown.cookie.temp` file in the same directory where you'll run `gdown.pl`. Note that `gdown.cookie.temp` will be deleted after each download, so retain its data in order to use it multiple times (for example make a master copy, and copy it to `gdown.cookie.temp` before each run).

    5. run `gdown.pl` with your protected link

    6. It should now download the file, and any other file which needs access permissions with the account used in (1). But only until that session finishes.

Version
=======

This version is **v2.2**.

### Warning

Please, note that v1.2 (available between days 12 to 31 of Jan/2019) **should not be used**, as it contains a bug that could result in unusable downloaded files. Proceed to overwrite with v1.4 in case you have it.

Docker
======

A simple Docker file is provided, to build a simple Docker image with gdown.pl.    
This has been used for pre-pulling data from a Google Drive to Kubernetes persistent volumes.     
Thanks @anton-khodak

Singularity
===========

An example [Singularity](https://sylabs.io/guides/3.2/user-guide/quick_start.html) file is provided.    
Build the container:
`sudo singularity build (imagename) Singularity`

Run the container:
`singularity run (imagename) (gdown.pl args)`

Thanks to @ttbrunner

License
=======

Distributed [under GPL 3](http://www.gnu.org/licenses/gpl-3.0.html)

Disclaimer
==========

This software is provided "as is", without warranty of any kind, express or implied.

More info
=========

[https://circulosmeos.wordpress.com/2014/04/12/google-drive-direct-download-of-big-files](https://circulosmeos.wordpress.com/2014/04/12/google-drive-direct-download-of-big-files)

Contact
=======

by [circulosmeos](loopidle@gmail.com)   
