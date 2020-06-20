#######
xkcdbot
#######

|License: MIT|

Simple Telegram bot implementation of `xkcd 37 <https://xkcd.com/37/>`_.

.. image:: https://imgs.xkcd.com/comics/hyphen.jpg
	:width: 400
	:alt: xkcd 37

Also see `xkcd37 from the toy repository
<https://github.com/chuahou/toy/tree/master/xkcd37>`_.

Hosted bot
==========

You can find a running version of the bot `here
<http://t.me/xkcd37bot>`_.

Usage
=====

Firstly, set up a bot using BotFather and turn its privacy mode off.
Then, save the API token you are given.

To build and run, just run

::

	cabal new-update
	TELEGRAM_BOT_TOKEN=<your Telegram bot API token here> cabal new-run

Lastly, either message the bot directly or add it to a group. Anytime it
receives a message with a word ending with "ass" followed by another
word, it will "xkcdify" it. For example,

.. image:: example.png

For more information on requirements, try checking the `Dockerfile
<Dockerfile>`_.

Deployment
==========

To deploy to Heroku, use the preconfigured Dockerfile and heroku.yml.
Create an app as per usual and set it up as a remote, then

::

	heroku stack:set container
	git push heroku master

and set ``TELEGRAM_BOT_TOKEN`` as a config var to your Telegram bot API
token in your Heroku app's settings.

Dependencies
============

* `Telegram API <https://hackage.haskell.org/package/telegram-api>`_

.. |License: MIT| image:: https://img.shields.io/badge/License-MIT-yellow.svg
	:target: https://opensource.org/licenses/MIT
