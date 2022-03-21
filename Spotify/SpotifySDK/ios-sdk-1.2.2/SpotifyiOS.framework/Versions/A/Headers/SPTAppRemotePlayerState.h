#import <Foundation/Foundation.h>

@protocol SPTAppRemoteTrack;
@protocol SPTAppRemotePlaybackOptions;
@protocol SPTAppRemotePlaybackRestrictions;

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `SPTAppRemotePlayerState` represents the state within the Spotify player.
 */
@protocol SPTAppRemotePlayerState <NSObject>

/// The track being played in the Spotify player.
@property (nonatomic, readonly) id<SPTAppRemoteTrack> track;

/// The position of the playback in the Spotify player.
@property (nonatomic, readonly) NSInteger playbackPosition;

/// The speed of the playback in the Spotify player.
@property (nonatomic, readonly) float playbackSpeed;

/// `YES` if the Spotify player is paused, otherwise `NO`.
@property (nonatomic, readonly, getter=isPaused) BOOL paused;

/// The playback restrictions currently in effect.
@property (nonatomic, readonly) id<SPTAppRemotePlaybackRestrictions> playbackRestrictions;

/// The playback options currently in effect.
@property (nonatomic, readonly) id<SPTAppRemotePlaybackOptions> playbackOptions;

/// The title of the currently playing context (e.g. the name of the playlist).
@property (nonatomic, readonly) NSString *contextTitle;

/// The URI of the currently playing context (e.g. the URI of the playlist).
@property (nonatomic, readonly) NSURL *contextURI;

@end

NS_ASSUME_NONNULL_END
