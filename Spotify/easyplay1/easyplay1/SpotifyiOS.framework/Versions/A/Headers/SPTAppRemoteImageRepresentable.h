#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The `SPTImageRepresentable` protocol represents an object that may contain an image.
 * If something conforms to this protocol you can pass it to `SPTAppRemoteImageAPI` fetchImageForItem: method.
 */
@protocol SPTAppRemoteImageRepresentable <NSObject>

/// The identifier of the image of the entity.
@property (nonatomic, strong, readonly) NSString *imageIdentifier;

@end

NS_ASSUME_NONNULL_END
