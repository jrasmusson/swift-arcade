# Changelog

## Spotify iOS SDK v1.2.1

What's New:

- Remove the need for the `-Objc` linker flag
- Update the demo apps

## Spotify iOS SDK v1.2.0

What's New:

- Adds support for connecting to Spotify when completely offline.
- Adds a method to start playing radio from a URI.
- Adds a method to get the content item object from a URI.

## Spotify iOS SDK v1.0.2

What's New

- Adds a method to start playing a playlist from a given index
- Adds a method to query the crossfade state (on/off) and duration

## Spotify iOS SDK v1.0.1

**Important Note:** The api for `fetchRecommendedContentItemsForType:` on `SPTAppRemoteContentAPI` has been renamed to `fetchRootContentItemsForType:` and still functions as it did returning root items. A new method for `fetchRecommendedContentItemsForType:flattenContainers:` has been added to fetch actual recommended items.

What's New

- Adds convenience methods for dealing with podcasts
- Adds additional convenience methods for fetching recommended items
- Adds the ability to check if Spotify is active before authorization

## Spotify iOS SDK v1.0.0

What's New

- Initial iOS SDK release
- Includes authentication and playback control capabilities
