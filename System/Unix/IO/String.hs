{-# language MultiParamTypeClasses, FlexibleInstances #-}
module System.Unix.IO.String where

import System.Unix.ByteString.Class
import System.Unix.IO.Text

import Control.Monad.IO.Class
import qualified Data.Text as T

instance MonadIO io => FromByteString io String where
  fromByteString = fmap T.unpack . liftIO . toUnicode

instance MonadIO io => ToByteString io String where 
  toByteString = liftIO . fromUnicode . T.pack

instance MonadIO io => IsByteString io String



