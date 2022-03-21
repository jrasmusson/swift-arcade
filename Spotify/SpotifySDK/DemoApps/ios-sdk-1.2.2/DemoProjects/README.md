# Spotify iOS SDK Sample Projects

There are 3 sample projects included to show you different ways to interact with the Spotify iOS SDK. There is also an included ruby script to run a local server for OAuth token swaps and refreshes.

## NowPlayingView

This Swift project focuses on how to interact with the Spotify client to control playback, subscribe to player state changes, fetch content, and more. This project does not require you to have a server for token swaps so you can ignore the provided ruby script. You will have to run this project on a real device as it requires the Spotify iOS app to be installed.

## SPTLoginSampleApp

This Objective-C project focuses solely on the authentication part of the SDK. If you are looking to use the Web API this will show you how to request different scopes and get access tokens. You will need to have a server running for this sample to work so you will likely want to use the provided ruby script.

## SPTLoginSampleAppSwift

This Swift project shows you how to use both the authentication and remote control parts of the SDK together. This is valuable if you want to be able to control playback but also need additional scopes for the Web API. You will have to run this project on a real device as it requires the Spotify iOS app be installed. You will also need a server to perform the token swap operation.

## How to use the provided Ruby script

For some of the above sample projects a server is required to perform an OAuth token swap, these instructions will help you run a sample server for testing. 

First make sure you have [Homebrew](https://brew.sh/) installed.

We will use rbenv to manage ruby versions, if you are familiar with ruby or prefer to use a different environment management tool feel free. 

Navigate to the directory containing this readme in your terminal and run the following commands:

1. `brew install rbenv`
2. `rbenv install $(rbenv local)`
3. `$(rbenv which gem) install sinatra encrypted_strings`

Now to run the ruby script and have your local server running simply execute the following command:

    $(rbenv which ruby) spotify_token_swap.rb
