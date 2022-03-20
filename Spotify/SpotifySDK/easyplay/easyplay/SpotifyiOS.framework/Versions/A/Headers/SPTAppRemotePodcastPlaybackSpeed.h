#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The `SPTAppRemotePodcastPlaybackSpeed` represents playback speed(s) for podcasts
 */
@protocol SPTAppRemotePodcastPlaybackSpeed <NSObject>

/// The speed multiplier representing this podcast speed. 0.5 = half speed, 2 = twice as fast, 1 = normal playback
@property (nonatomic, strong, readonly) NSNumber *value;

@end

NS_ASSUME_NONNULL_END
