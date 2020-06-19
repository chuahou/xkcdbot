-- SPDX-License-Identifier: MIT
-- Copyright (c) 2020 Chua Hou

module Xkcdify ( xkcdify ) where

xkcdify :: String -> Maybe String
xkcdify ss = unwords . filter (not . null) <$> (assify . words $ ss)

assify :: [String] -> Maybe [String]
assify []   = Nothing
assify [cs] = Nothing
assify (cs:ds:css)
    | endcs == ass = Just [prunehyp startcs, ass ++ (hyphen:ds)]
    | otherwise    = assify (ds:css)
        where (startcs, endcs) = splitAt (length cs - length ass) cs
              prunehyp ""     = ""
              prunehyp (c:"") | c == hyphen = ""
                              | otherwise   = [c]
              prunehyp (c:cs) = c:prunehyp cs

----- Constants -----

ass :: String
ass = "ass"

hyphen :: Char
hyphen = '-'
