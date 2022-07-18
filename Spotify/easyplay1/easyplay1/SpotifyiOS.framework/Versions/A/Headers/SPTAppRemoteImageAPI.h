#import <UIKit/UIKit.h>

#import "SPTAppRemoteCommon.h"
#import "SPTAppRemoteImageRepresentable.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * API for fetching image data from the Spotify app
 */
@protocol SPTAppRemoteImageAPI <NSObject>

/**
 * Fetch an image with the given ID from the Spotify app.
 *
 * @param imageRepresentable  The item containing the ID of the image to fetch.
 * @param imageSize  The size of the image to fetch.
 * @param callback On success `result` will be an instance of `UIImage`
 *                 On error `result` will be nil and error set
 */
- (void)fetchImageForItem:(id<SPTAppRemoteImageRepresentable>)imageRepresentable withSize:(CGSize)imageSize callback:(nullable SPTAppRemoteCallback)callback;

@end

NS_ASSUME_NONNULL_END
