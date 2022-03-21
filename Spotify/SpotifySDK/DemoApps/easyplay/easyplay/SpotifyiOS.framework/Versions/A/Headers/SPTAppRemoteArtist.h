#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `SPTAppRemoteArtist` represents an artist.
 */
@protocol SPTAppRemoteArtist <NSObject>

/// The name of the artist.
@property (nonatomic, copy, readonly) NSString *name;

/// The URI of the artist.
@property (nonatomic, copy, readonly) NSString *URI;

@end

NS_ASSUME_NONNULL_END
