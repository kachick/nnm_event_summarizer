nnm_event_summarizer
=====================

[![Build Status](https://secure.travis-ci.org/kachick/nnm_event_summarizer.png)](http://travis-ci.org/kachick/nnm_event_summarizer)

Description
------------

An utility for the NNM(NetworkNodeManager).
"trapd.conf" to some CSV files.

Features
--------

* Supporting formatted version is "3".
  See the header of "trapd.conf"
  
```shell
$ head trapd.conf
```

* Author is just a user of NNM, Of course "No Warranty" :)

Usage
-----

```shell
$ nnm_event_summarizer trapd.conf [*trapd.conf]
```

Requirements
------------

* Ruby 1.9.2 or later [MRI/YARV, Rubinius, JRuby](http://travis-ci.org/#!/kachick/nnm_event_summarizer)
* stiruct - 0.3.0

Installation
-------------

```shell
$ gem install nnm_event_summarizer
```

Link
----

* [code](https://github.com/kachick/nnm_event_summarizer)
* [issues](https://github.com/kachick/nnm_event_summarizer/issues)
* [CI](http://travis-ci.org/#!/kachick/nnm_event_summarizer)
* [gem](https://rubygems.org/gems/nnm_event_summarizer)
* [gem+](http://metagem.info/gems/nnm_event_summarizer)

License
-------

GPL 3.0  
Copyright (c) 2010-2012 Kenichi Kamiya  
See the file COPYING for further details.
