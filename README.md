toplyrics
=========

This little script allows you to download the top 500 lyrics from poemhunter.com. It's simple ruby code that has been tested using version 1.8.7. 

Dependencies
------------

[Nokogiri](http://nokogiri.org/ "Nokogiri")
[JSON lib](https://rubygems.org/gems/json "JSON")

How to run
----------

Just traverse to the folder the file is in and fire "ruby top500.rb" from the command prompt. It should download a json file called poems.json

Issues
------

The json library seems to strip out line breaks. This makes the poems unreadable by the human eye.