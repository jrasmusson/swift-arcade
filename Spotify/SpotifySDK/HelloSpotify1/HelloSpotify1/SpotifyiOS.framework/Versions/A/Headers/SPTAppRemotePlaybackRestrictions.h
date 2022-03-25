#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `SPTAppRemotePlaybackRestrictions` describes a set of restrictions for playback in the Spotify client.
 *
 *  @discussion Use these to determine whether to enable or disable certain actions in the UI.
 */
@protocol SPTAppRemotePlaybackRestrictions <NSObject>

/// `YES` if the user can skip to the next track, otherwise `NO`.
@property (nonatomic, readonly) BOOL canSkipNext;

/// `YES` if the user can skip to the previous track, otherwise `NO`.
@property (nonatomic, readonly) BOOL canSkipPrevious;

/// `YES` if the user can repeat the current track, otherwise `NO`.
@property (nonatomic, readonly) BOOL canRepeatTrack;

/// `YES` if the user can repeat the current context, otherwise `NO`.
@property (nonatomic, readonly) BOOL canRepeatContext;

/// `YES` if the user can toggle shuffle, otherwise `NO`.
@property (nonatomic, readonly) BOOL canToggleShuffle;

/// `YES` if the user can seek to specific positions, otherwise `NO`.
@property (nonatomic, readonly) BOOL canSeek;

@end

NS_ASSUME_NONNULL_END
