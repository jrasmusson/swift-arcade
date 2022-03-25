#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// The available repeat modes.
typedef NS_ENUM(NSUInteger, SPTAppRemotePlaybackOptionsRepeatMode) {
    /// Repeat is off.
    SPTAppRemotePlaybackOptionsRepeatModeOff = 0,

    /// Repeats the current track.
    SPTAppRemotePlaybackOptionsRepeatModeTrack = 1,

    /// Repeats the current context.
    SPTAppRemotePlaybackOptionsRepeatModeContext = 2,
};

/**
 *  The `SPTAppRemotePlaybackOptions` describes a set of options used for the current playback.
 *
 *  @discussion Use these to determine UI states.
 */
@protocol SPTAppRemotePlaybackOptions <NSObject>

/// `YES` if shuffle is enabled, otherwise `NO`.
@property (nonatomic, readonly) BOOL isShuffling;

/// The current repeat mode in effect.
@property (nonatomic, readonly) SPTAppRemotePlaybackOptionsRepeatMode repeatMode;

@end

NS_ASSUME_NONNULL_END
