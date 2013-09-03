redis

This module aims to be a highly configurable, very flexible module for setting up a
redis server on your machine.

Currently it only supports ubuntu, but my aim is to make it really trivial to add support for other operating systems.
The OS-specific bits should likely go into redis::params.

Also, the default settings in the redis::config class were simply taken from the config file installed on ubuntu, so if
those defaults are different for a different OS or different for ... whatever, we can make that be one of the redis::params bits if need be.

Also, I know there aren't any tests yet, I'm getting to that!

License
-------

Copyright ©2013 3dna Corp


Contact
-------

[Jeremy Kitchen <jeremy@nationbuilder.com>](mailto:jeremy@nationbuilder.com)


Support
-------

Please log tickets and issues at our [github page](https://github.com/3dna/3dna-redis)
