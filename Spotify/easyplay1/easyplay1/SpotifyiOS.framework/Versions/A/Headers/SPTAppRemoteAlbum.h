#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `SPTAppRemoteAlbum` represents an Album entity.
 */
@protocol SPTAppRemoteAlbum <NSObject>

/// The name of the album.
@property (nonatomic, copy, readonly) NSString *name;

/// The URI of the album.
@property (nonatomic, copy, readonly) NSString *URI;

@end

NS_ASSUME_NONNULL_END
