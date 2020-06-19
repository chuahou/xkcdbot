-- SPDX-License-Identifier: MIT
-- Copyright (c) 2020 Chua Hou

module Main where

import Telegram.Bot.API ( Token, Update, defaultTelegramClientEnv )
import Telegram.Bot.Simple

import Xkcdify

type Model = ()
data Action = Reply String | Noop deriving Show

handleUpdate :: Update -> Model -> Maybe Action
handleUpdate _ _ = Nothing

handleAction :: Action -> Model -> Eff Action Model
handleAction _ _ = undefined

xkcdbot :: BotApp Model Action
xkcdbot = BotApp
  { botInitialModel = ()
  , botAction = handleUpdate
  , botHandler = handleAction
  , botJobs = []
  }

run :: Token -> IO ()
run token = do
  env <- defaultTelegramClientEnv token
  startBot_ xkcdbot env

main :: IO ()
main = getEnvToken "TELEGRAM_BOT_TOKEN" >>= run
