{-# LANGUAGE OverloadedStrings #-}

module Main where

import Protolude
import Network.HTTP.Client (newManager, defaultManagerSettings)

import Args (Arguments(..), execParser, argparser)
import Api (RouteResponse(..), runRoute, explainError)


main :: IO ()
main = do
  (Arguments host port) <- execParser argparser
  putStrLn $ "Endpoint: " <> host <> ":" <> show port

  manager <- newManager defaultManagerSettings

  response <- runExceptT $ runRoute manager host port 

  case response of
    Left  err   -> putStrLn $ "Error: "   <> explainError err
    Right route -> putStrLn $ "Success: " <> (routeResponseCode route)
