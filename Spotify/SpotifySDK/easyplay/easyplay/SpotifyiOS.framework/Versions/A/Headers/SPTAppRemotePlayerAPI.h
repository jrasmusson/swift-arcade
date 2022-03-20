#import <Foundation/Foundation.h>

#import "SPTAppRemoteCommon.h"
#import "SPTAppRemotePlaybackOptions.h"

@protocol SPTAppRemotePlayerState, SPTAppRemoteContentItem, SPTAppRemotePodcastPlaybackSpeed;

NS_ASSUME_NONNULL_BEGIN

/**
 * The `SPTAppRemotePlayerStateDelegate` is used to get notifications from the Spotify app when the player state is changed.
 */
@protocol SPTAppRemotePlayerStateDelegate <NSObject>

/**
 * Called when the player state has been updated.
 *
 * @param playerState The new player state.
 */
- (void)playerStateDidChange:(id<SPTAppRemotePlayerState>)playerState;

@end

/**
 * The `SPTAppRemotePlayerAPI` is used to interact with and control the Spotify player.
 */
@protocol SPTAppRemotePlayerAPI <NSObject>

/// The delegate receiving player state updates
@property (nonatomic, weak) id<SPTAppRemotePlayerStateDelegate> delegate;

#pragma mark Player Control

/**
 * Asks the Spotify player to play the entity with the given identifier.
 *
 * @note Implement `SPTAppRemotePlayerStateDelegate` and set yourself as delegate in order to be notified when the
 *       the track begins to play.
 *
 * @param entityIdentifier The unique identifier of the entity to play.
 * @param callback         On success `result` will be `YES`.
 *                         On error `result` will be `nil` and `error` set
 */
- (void)play:(NSString *)entityIdentifier callback:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to play the entity with the given identifier.
 *
 * @note Implement `SPTAppRemotePlayerStateDelegate` and set yourself as delegate in order to be notified when the
 *       the track begins to play.
 *
 * @param trackUri      The track URI to play.
 * @param asRadio       `YES` to start radio for track URI.
 * @param callback      On success `result` will be `YES`.
 *                      On error `result` will be `nil` and `error` set
 */
- (void)play:(NSString *)trackUri asRadio:(BOOL)asRadio callback:(SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to play the provided content item.
 *
 * @note Implement `SPTAppRemotePlayerStateDelegate` and set yourself as delegate in order to be notified when the
 *       the track begins to play.
 * @note The `playable` property of the `SPTAppRemoteContentItem` indicates whether or not a content item is
 *       playable.
 *
 * @param contentItem      The content item to play.
 * @param callback         On success `result` will be `YES`.
 *                         On error `result` will be `nil` and error set
 */
- (void)playItem:(id<SPTAppRemoteContentItem>)contentItem callback:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to play the provided content item starting at the specified index.
 *
 * @note Implement `SPTAppRemotePlayerStateDelegate` and set yourself as delegate in order to be notified when the
 *       the track begins to play.
 * @note The `playable` property of the `SPTAppRemoteContentItem` indicates whether or not a content item is
 *       playable.
 * @note Sending an `index` parameter that is out of bounds is undefined.
 *
 * @param contentItem      The content item to play.
 * @param index            The index of the track to skip to if applicable.
 * @param callback         On success `result` will be `YES`.
 *                         On error `result` will be `nil` and error set
 */
- (void)playItem:(id<SPTAppRemoteContentItem>)contentItem skipToTrackIndex:(NSInteger) index callback:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to resume playback.
 *
 * @note Implement `SPTAppRemotePlayerStateDelegate` and set yourself as delegate in order to be notified when the
 *       the playback resumes.
 *
 * @param callback On success `result` will be `YES`.
 *                 On error `result` will be nil and error set
 */
- (void)resume:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to pause playback.
 *
 * @note Implement `SPTAppRemotePlayerStateDelegate` and set yourself as delegate in order to be notified when the
 *       the playback pauses.
 *
 * @param callback On success `result` will be `YES`.
 *                 On error `result` will be `nil` and error set
 */
- (void)pause:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to skip to the next track.
 *
 * @note Implement `SPTAppRemotePlayerStateDelegate` and set yourself as delegate in order to be notified when the
 *       the track changes.
 *
 * @param callback On success `result` will be `YES`.
 *                 On error `result` will be `nil` and error set
 */
- (void)skipToNext:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to skip to the previous track.
 *
 * @note Implement `SPTAppRemotePlayerStateDelegate` and set yourself as delegate in order to be notified when the
 *       the track changes.
 *
 * @param callback On success `result` will be `YES`.
 *                 On error `result` will be `nil` and `error` set
 */
- (void)skipToPrevious:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to seek to the specified position.
 *
 * @param position The position to seek to in milliseconds.
 * @param callback On success `result` will be `YES`.
 *                 On error `result` will be `nil` and `error` set
 */
- (void)seekToPosition:(NSInteger)position callback:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to seek forward 15 seconds.
 * Note: You should only use this method if isEpisode = YES for the currently playing track
 *
 * @param callback On success `result` will be `YES`.
 *                 On error `result` will be `nil` and `error` set
 */
- (void)seekForward15Seconds:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player to seek backward 15 seconds.
 * Note: You should only use this method if isEpisode = YES for the currently playing track
 *
 * @param callback On success `result` will be `YES`.
 *                 On error `result` will be `nil` and `error` set
 */
- (void)seekBackward15Seconds:(nullable SPTAppRemoteCallback)callback;

#pragma mark Playback Options

/**
 *  Asks the Spotify player to set shuffle mode.
 *
 *  @param shuffle  `YES` to enable shuffle, `NO` to disable.
 *  @param callback On success `result` will be `YES`.
 *                  On error `result` will be `nil` and `error` will be set.
 */
- (void)setShuffle:(BOOL)shuffle callback:(nullable SPTAppRemoteCallback)callback;

/**
 *  Asks the Spotify player to set the repeat mode.
 *
 *  @param repeatMode The repeat mode to set.
 *  @param callback On success `result` will be `YES`.
 *                  On error `result` will be `nil` and `error` will be set.
 */
- (void)setRepeatMode:(SPTAppRemotePlaybackOptionsRepeatMode)repeatMode callback:(nullable SPTAppRemoteCallback)callback;

#pragma mark Player State

/**
 * Asks the Spotify player for the current player state.
 *
 * @param callback On success `result` will be an instance of `id<SPTAppRemotePlayerState>`
 *                 On error `result` will be nil and error set
 */
- (void)getPlayerState:(nullable SPTAppRemoteCallback)callback;

/**
 * Subscribes to player state changes from the Spotify app.
 *
 * @note Implement `SPTAppRemotePlayerStateDelegate` and set yourself as delegate in order to be notified when the
 *       the player state changes.
 *
 * @param callback On success `result` will be an instance of `id<SPTAppRemotePlayerState>`
 *                 On error `result` will be nil and error set
 */
- (void)subscribeToPlayerState:(nullable SPTAppRemoteCallback)callback;

/**
 * Stops subscribing to player state changes from the Spotify app.
 *
 * @param callback On success `result` will be `YES`
 *                 On error `result` will be `nil` and error set
 */
- (void)unsubscribeToPlayerState:(nullable SPTAppRemoteCallback)callback;

/**
 * Adds a track to the user's currently playing queue
 *
 * @param trackUri The track URI to add to the queue
 * @param callback On success `result` will be `YES`
 *                 On error `result` will be `nil` and error set
 */
- (void)enqueueTrackUri:(NSString*)trackUri callback:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player for available podcast playback speeds
 *
 * @param callback On success `result` will be an `NSArray` of `SPTAppRemotePodcastPlaybackSpeed` objects
 *                 On error `result` will be `nil` and `error` set
 */
- (void)getAvailablePodcastPlaybackSpeeds:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player for the current podcast playback speed
 *
 * @note Podcast playback speed is seperate from other contents' playback speed. This value is only used for podcasts
 *
 * @param callback On success `result` will be a `SPTAppRemotePodcastPlaybackSpeed`
 *                 On error `result` will be `nil` and `error` set
 */
- (void)getCurrentPodcastPlaybackSpeed:(nullable SPTAppRemoteCallback)callback;

/**
 * Set the current podcast playback speed
 *
 * @note This playback speed will only affect podcasts and not other types of media. If you set this
 * when a podcast is not playing this will be the default value when a podcast does begin to play. For this reason
 * you may get a successful callback when setting this even when a podcast is not playing and the current playback
 * speed does not change.
 *
 * @note You should use `getAvailablePodcastPlaybackSpeeds:` to get a list of valid speeds to pass to this method
 *
 * @param speed The `SPTAppRemotePodcastPlaybackSpeed` to set as the current podcast playback speed
 * @param callback  On success `result` will be `YES`.
 *                  On error `result` will be `nil` and `error` set
 */
- (void)setPodcastPlaybackSpeed:(nonnull id<SPTAppRemotePodcastPlaybackSpeed>)speed callback:(nullable SPTAppRemoteCallback)callback;

/**
 * Asks the Spotify player for the current crossfade state.
 *
 * @param callback On success `result` will be an instance of `id<SPTAppRemoteCrossfadeState>`
 *                 On error `result` will be nil and error set
 */
- (void)getCrossfadeState:(nullable SPTAppRemoteCallback)callback;

@end

NS_ASSUME_NONNULL_END
