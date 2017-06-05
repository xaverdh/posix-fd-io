{-# language MultiParamTypeClasses, FlexibleInstances #-}
module System.Unix.IO
  ( fdGetContents
  , fdGetLine
  , fdPut )
where

import System.Unix.ByteString.Class
import System.Unix.IO.ByteString

import System.Posix.Types
import Control.Monad.IO.Class

fdGetContents :: (MonadIO io, FromByteString io a) => Fd -> io a
fdGetContents fd = fromByteString =<< liftIO (fdGetContentsB fd)

fdGetLine :: (MonadIO io, FromByteString io a) => Fd -> io a
fdGetLine fd = fromByteString =<< liftIO (fdGetLineB fd)

fdPut :: (MonadIO io, ToByteString io a) => Fd -> a -> io ()
fdPut fd a = liftIO . fdPutB fd =<< toByteString a

