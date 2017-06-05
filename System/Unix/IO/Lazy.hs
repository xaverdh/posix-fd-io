{-# language MultiParamTypeClasses, FlexibleInstances #-}
module System.Unix.IO.Lazy
  ( fdGetContents
  , fdGetLine
  , fdPut )
where

import System.Unix.ByteString.Class
import System.Unix.IO.ByteString

import System.Posix.Types
import Control.Monad.IO.Class

fdGetContents :: (MonadIO io,FromLazyByteString io a) => Fd -> io a
fdGetContents fd = fromLazyByteString =<< liftIO (fdGetContentsLB fd)

fdGetLine :: (MonadIO io,FromLazyByteString io a) => Fd -> io a
fdGetLine fd = fromLazyByteString =<< liftIO (fdGetLineLB fd)

fdPut :: (MonadIO io,ToLazyByteString io a) => Fd -> a -> io ()
fdPut fd a = liftIO . fdPutLB fd =<< toLazyByteString a



