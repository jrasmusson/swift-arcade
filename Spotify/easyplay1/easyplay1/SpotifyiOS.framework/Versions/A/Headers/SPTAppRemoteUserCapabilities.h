#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `SPTAppRemoteUserCapabilities` represents a set of capabilities the current user has in the Spotify app.
 */
@protocol SPTAppRemoteUserCapabilities <NSObject>

/// `YES` if the user can play songs on demand, otherwise `NO`. This will differ for premium and non-premium users
@property (nonatomic, assign, readonly) BOOL canPlayOnDemand;

@end

NS_ASSUME_NONNULL_END
