#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `SPTAppRemoteCrossfadeState` represents the state of crossfade.
 */
@protocol SPTAppRemoteCrossfadeState <NSObject>

/// The on/off state of crossfade.
@property (nonatomic, readonly, getter=isEnabled) BOOL enabled;

/// The duration of crossfade in milliseconds. The value is meaningless if crossfade is not enabled.
@property (nonatomic, readonly) NSInteger duration;

@end

NS_ASSUME_NONNULL_END
