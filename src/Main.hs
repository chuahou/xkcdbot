-- SPDX-License-Identifier: MIT
-- Copyright (c) 2020 Chua Hou

module Main where

import Telegram.Bot.API ( Token, Update, defaultTelegramClientEnv )
import Telegram.Bot.Simple
import Telegram.Bot.Simple.UpdateParser ( updateMessageText )

import qualified Data.Text as T

import Xkcdify ( xkcdify )

type Model = ()
data Action = Reply String | Noop deriving Show

handleUpdate :: Update -> Model -> Maybe Action
handleUpdate update _ = case updateMessageText update of
    Just cs -> Reply <$> (xkcdify . T.unpack) cs
    Nothing -> Nothing

handleAction :: Action -> Model -> Eff Action Model
handleAction (Reply cs) model =
    model <# ((replyText $ T.pack cs) >> return Noop)
handleAction (Noop)     model = pure model

xkcdbot :: BotApp Model Action
xkcdbot = BotApp
    { botInitialModel = ()
    , botAction       = handleUpdate
    , botHandler      = handleAction
    , botJobs         = []
    }

run :: Token -> IO ()
run token = do
  env <- defaultTelegramClientEnv token
  startBot_ xkcdbot env

main :: IO ()
main = getEnvToken "TELEGRAM_BOT_TOKEN" >>= run
