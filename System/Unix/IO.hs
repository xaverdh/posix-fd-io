{-# LANGUAGE FlexibleInstances #-}
module System.Unix.IO (
  FdReadWriteable(..)
  ,FdReadable(..)
  ,FdWritable(..)
) where

import System.Unix.IO.ByteString
import System.Unix.IO.Text
import System.Unix.IO.String

import System.Posix.Types
import qualified Data.Text as T
import qualified Data.Text.Lazy as LT
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as LB

class (FdReadable a,FdWritable a) => FdReadWriteable a

class FdReadable a where
  fdGetContents :: Fd -> IO a
  fdGetLine :: Fd -> IO a

class FdWritable a where
  fdPut :: Fd -> a -> IO ()


-- Strict ByteStrings
instance FdReadable B.ByteString where
  fdGetContents = fdGetContentsB
  fdGetLine = fdGetLineB

instance FdWritable B.ByteString where
  fdPut = fdPutB

instance FdReadWriteable B.ByteString


-- Lazy ByteStrings
instance FdReadable LB.ByteString where
  fdGetContents = fdGetContentsLB  
  fdGetLine = fdGetLineLB
  
instance FdWritable LB.ByteString where
  fdPut = fdPutLB

instance FdReadWriteable LB.ByteString


-- Strict Text
instance FdReadable T.Text where
  fdGetContents = fdGetContentsT
  fdGetLine = fdGetLineT

instance FdWritable T.Text where
  fdPut = fdPutT

instance FdReadWriteable T.Text


-- Lazy Text
instance FdReadable LT.Text where
  fdGetContents = fdGetContentsLT
  fdGetLine = fdGetLineLT

instance FdWritable LT.Text where
  fdPut = fdPutLT

instance FdReadWriteable LT.Text


-- Strings
instance FdReadable [Char] where
  fdGetContents = fdGetContentsS
  fdGetLine = fdGetLineS

instance FdWritable [Char] where
  fdPut = fdPutS

instance FdReadWriteable [Char]

