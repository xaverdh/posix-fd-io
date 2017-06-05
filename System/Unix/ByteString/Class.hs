{-# language MultiParamTypeClasses, FlexibleInstances #-}
module System.Unix.ByteString.Class where

import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as LB

class FromByteString m a where
  fromByteString :: B.ByteString -> m a

class ToByteString m a where
  toByteString :: a -> m B.ByteString

class (FromByteString m a,ToByteString m a) => IsByteString m a

class FromLazyByteString m a where
  fromLazyByteString :: LB.ByteString -> m a

class ToLazyByteString m a where 
  toLazyByteString :: a -> m LB.ByteString

class (FromLazyByteString m a,ToLazyByteString m a) => IsLazyByteString m a


instance Applicative f => FromByteString f B.ByteString where
  fromByteString = pure

instance Applicative f => ToByteString f B.ByteString where
  toByteString = pure

instance Applicative f => IsByteString f B.ByteString


instance Applicative f => FromLazyByteString f LB.ByteString where
  fromLazyByteString = pure

instance Applicative f => ToLazyByteString f LB.ByteString where
  toLazyByteString = pure

instance Applicative f => IsLazyByteString f LB.ByteString


