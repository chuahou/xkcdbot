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

Deployment
==========

To deploy to Heroku, please enjoy the `most disgusting setup script
<deploy.sh>`_. First, ensure that you have the ``heroku`` remote set up
to point at your Heroku app (use the Heroku CLI to do this), and add the
official nodejs buildpack in the app settings.

Make sure the variables ``LIBRARY_DIR`` and ``LIBRARIES`` in
``deploy.sh`` are correct for your system. Then, run

::

	./deploy.sh

and set ``TELEGRAM_BOT_TOKEN`` as a config var to your Telegram bot API
token in your Heroku app's settings.

Due to issues with building this directly on Heroku, I opted to do the
extremely disgusting deployment method of building locally, committing
the binaries and using a dummy ``package.json`` to trick the nodejs
buildpack into doing nothing. `See more here
<https://github.com/yesodweb/yesod/wiki/Deploying-Yesod-Apps-to-Heroku>`_.

Dependencies
============

* `Telegram API <https://hackage.haskell.org/package/telegram-api>`_
* Build was done using:

  * ghc 8.6.5
  * cabal 2.4.0.0

.. |License: MIT| image:: https://img.shields.io/badge/License-MIT-yellow.svg
	:target: https://opensource.org/licenses/MIT
