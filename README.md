Scripts
=======

###tinypng.rb###
TinyPNG script allow you to use [tinypng.com](https://tinypng.com) service. <br>
Details: [https://tinypng.com/developers](https://tinypng.com/developers).

Script help:

    Usage: ruby tinypng.rb [-d | --dir PATH] [--apply]
        -a, --apply                      Apply compression files: rename temp files to source files names
        -d, --dir PATH                   Source files directory. Default: pwd()
        -h, --help                       Show this help
    

Additional gems to install:

    gem install filesize
    

###makeicons.sh###
Make iOS app icons script generates all app icon sizes from one file. For better results source file should be sized 1024x1024.

This script use [ImageMagick's](http://www.imagemagick.org/index.php) [convert](http://www.imagemagick.org/script/convert.php) tool. Installation instructions available [here](http://www.imagemagick.org/script/binary-releases.php).
