#!/usr/bin/env perl
#
# Google Drive direct download of big files
# ./gdown.pl 'gdrive file url' ['desired file name']
#
# v1.0 by circulosmeos 04-2014.
# v1.1 by circulosmeos 01-2017.
# v1.2, v1.3, v1.4, v2.0 by circulosmeos 01-2019, 02-2019.
# v2.1 by circulosmeos 12-2020.
# v2.2, v2.3 by circulosmeos 05-2023.
# //circulosmeos.wordpress.com/2014/04/12/google-drive-direct-download-of-big-files
# Distributed under GPL 3 (//www.gnu.org/licenses/gpl-3.0.html)
#
use strict;
use POSIX;

my $TEMP='gdown.cookie.temp';
my $COMMAND;
my $confirm;
my $check;
sub execute_command();

my $URL=shift;
die "\n./gdown.pl 'gdrive file url' [desired file name]\n\n" if $URL eq '';

my $FILENAME=shift;
my $TEMP_FILENAME='gdown.'.strftime("%Y%m%d%H%M%S", localtime).'.'.substr(rand,2);

my $TEMP_exists = 0;
if (-e $TEMP) {
    $TEMP_exists = 1;
}

if ($URL=~m#^https?://drive.google.com/file/d/([^/]+)#) {
    $URL="https://docs.google.com/uc?id=$1&export=download";
}
elsif ($URL=~m#^https?://drive.google.com/open\?id=([^/]+)#) {
    $URL="https://docs.google.com/uc?id=$1&export=download";
}

execute_command();

while (-s $TEMP_FILENAME < 100000) { # only if the file isn't the download yet
    open fFILENAME, '<', $TEMP_FILENAME;
    $check=0;
    foreach (<fFILENAME>) {
        if (/href="(\/uc\?export=download[^"]+)/ || /action="[^"]+(\/uc\?id=[^"]+export=download[^"]+)/) {
            $URL='https://docs.google.com'.$1;
            $URL=~s/&amp;/&/g;
            $confirm='';
            $check=1;
            last;
        }
        if (/confirm=([^;&]+)/) {
            $confirm=$1;
            $check=1;
            last;
        }
        if (/"downloadUrl":"([^"]+)/) {
            $URL=$1;
            $URL=~s/\\u003d/=/g;
            $URL=~s/\\u0026/&/g;
            $confirm='';
            $check=1;
            last;
        }
    }
    close fFILENAME;
    die "Couldn't download the file :-(\n" if ($check==0);
    $URL=~s/confirm=([^;&]+)/confirm=$confirm/ if $confirm ne '';

    execute_command();

}

unlink $TEMP if !$TEMP_exists;

sub execute_command() {
    my $OUTPUT_FILENAME = $TEMP_FILENAME;
    my $CONTINUE = '';

    # check contents before download & if a $FILENAME has been indicated resume on content download
    # please, note that for this to work, wget must correctly provide --spider with --server-response (-S)
    if ( length($FILENAME) > 0 ) {
        $COMMAND="wget -q -S --no-check-certificate --spider --load-cookie $TEMP --save-cookie $TEMP \"$URL\" 2>&1";
        my @HEADERS=`$COMMAND`;
        foreach my $header (@HEADERS) {
            if ( ( $header =~ /Content-Type: (.+)/ && $1 !~ 'text/html' ) ||
                 $header =~ 'HTTP/1.1 405 Method Not Allowed'
                ) {
                $OUTPUT_FILENAME = $FILENAME;
                $CONTINUE = '-c';
                last;
            }
        }
    }

    $COMMAND="wget $CONTINUE --progress=dot:giga --no-check-certificate --load-cookie $TEMP --save-cookie $TEMP \"$URL\"";
    $COMMAND.=" -O \"$OUTPUT_FILENAME\"";
    my $OUTPUT = system( $COMMAND );
    if ( $OUTPUT == 2 ) { # do a clean exit with Ctrl+C
        unlink $TEMP if !$TEMP_exists;
        die "\nDownloading interrupted by user\n\n";
    } elsif ( $OUTPUT == 0 && length($CONTINUE)>0 ) { # do a clean exit with $FILENAME provided
        unlink $TEMP if !$TEMP_exists;
        die "\nDownloading complete\n\n";
    }
    return 1;
}
