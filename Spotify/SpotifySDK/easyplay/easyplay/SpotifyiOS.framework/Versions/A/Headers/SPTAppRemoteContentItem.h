#import <Foundation/Foundation.h>
#import "SPTAppRemoteImageRepresentable.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * The `SPTAppRemoteContentItem` protocol represents a track or a collection of tracks. Use the `isContainer` instance method
 * to determine if the content item is a collection of tracks for which to grab children from.
 */
@protocol SPTAppRemoteContentItem <NSObject, SPTAppRemoteImageRepresentable>

/// The primary title of the item.
@property (nonatomic, copy, readonly, nullable) NSString *title;

/// The secondary title of the item.
@property (nonatomic, copy, readonly, nullable) NSString *subtitle;

/// The unique identifier of the item.
@property (nonatomic, copy, readonly) NSString *identifier;

/// The playback URI of this item.
@property (nonatomic, copy, readonly) NSString *URI;

/// `YES` if the item is available offline, or if it has any child that is available offline, otherwise `NO`.
@property (nonatomic, assign, readonly, getter=isAvailableOffline) BOOL availableOffline;

/// Returns `YES` if the item is directly playable, otherwise `NO`.
@property (nonatomic, assign, readonly, getter=isPlayable) BOOL playable;

/// Returns `YES` if the item is expected to contain children, otherwise `NO`.
@property (nonatomic, assign, readonly, getter=isContainer) BOOL container;

/**
 A list of the content item's children.

 @note This is not populated for all container items as some of them are fetched
       lazily with the `fetchChildrenOfContentItem:callback:` method.
 */
@property (nonatomic, strong, readonly, nullable) NSArray<id<SPTAppRemoteContentItem>> *children;

@end

NS_ASSUME_NONNULL_END
