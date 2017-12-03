{-# language MultiParamTypeClasses, FlexibleInstances #-}
module System.Unix.IO.Text where

import System.Unix.ByteString.Class

import Data.Functor.Identity
import Control.Monad.IO.Class

-- import qualified Data.Text.ICU.Convert as U
import qualified Data.Text as T
import qualified Data.Text.Encoding as TEnc
import qualified Data.ByteString as B
import qualified Data.Text.Lazy as LT
import qualified Data.ByteString.Lazy as LB


instance MonadIO io => FromByteString io T.Text where
  fromByteString = liftIO . toUnicode

instance MonadIO io => ToByteString io T.Text where
  toByteString = liftIO . fromUnicode

instance MonadIO io => IsByteString io T.Text


instance MonadIO io => FromLazyByteString io LT.Text where
  fromLazyByteString bs = LT.fromChunks
    <$> liftIO (toUnicodef $ LB.toChunks bs)
  -- ^ For performance reasons we use fromUnicodef
  --   instead of reapeated application of fromUnicode.

instance MonadIO io => ToLazyByteString io LT.Text where
  toLazyByteString txt = LB.fromChunks
    <$> liftIO (fromUnicodef $ LT.toChunks txt)
  -- ^ For performance reasons we use fromUnicodef
  --   instead of reapeated application of fromUnicode.

instance MonadIO io => IsLazyByteString io LT.Text



-- Todo: investigate proper use of the "fallback" argument to the ICU open function


-- | Decode 'B.ByteString' using the local(e) encoding.
--   On most modern unix systems this will likely be utf8.
--   (Implememted in terms of toUnicodef).
toUnicode :: B.ByteString -> IO T.Text
toUnicode = 
  fmap runIdentity . toUnicodef . Identity

-- | Encode 'B.ByteString' using the local(e) encoding.
--   On most modern unix systems this will likely be utf8.
--   (Implememted in terms of fromUnicodef).
fromUnicode :: T.Text -> IO B.ByteString
fromUnicode = 
  fmap runIdentity . fromUnicodef . Identity

-- | Functor version of 'toUnicode'.
toUnicodef :: Functor f => f B.ByteString -> IO (f T.Text)
toUnicodef fbs = do
  return $ fmap TEnc.decodeUtf8 fbs

-- | Functor version of fromUnicode'.
fromUnicodef :: Functor f => f T.Text -> IO (f B.ByteString)
fromUnicodef ftext = do
  return $ fmap TEnc.encodeUtf8 ftext



