#import <Foundation/Foundation.h>
#import "SPTAppRemoteCommon.h"

NS_ASSUME_NONNULL_BEGIN

/// A type representing different lists of content.
typedef NSString * const SPTAppRemoteContentType;

extern NSString * const SPTAppRemoteContentTypeDefault;
extern NSString * const SPTAppRemoteContentTypeNavigation;
extern NSString * const SPTAppRemoteContentTypeFitness;

@protocol SPTAppRemoteContentItem;

/**
 * The `SPTAppRemoteContentAPI` is used to access content from the Spotify application.
 */
@protocol SPTAppRemoteContentAPI <NSObject>

/**
 * Fetches the root level of content items for the current user.
 *
 * @note The content returned is based on the users' home feeds, and as such may vary
 *       between different users. If the user has no network connection or Spotify is
 *       forced offline, this method will return the user's offline content, if any.
 *
 *       Deprecated. Use fetchRecommendedContentItemsForType:flattenContainers:callback: instead.
 *
 * @param contentType A type that is used to retrieve content for a specific use-case.
 * @param callback The callback to be called once the request is completed.
 */
- (void)fetchRootContentItemsForType:(SPTAppRemoteContentType)contentType
                            callback:(nullable SPTAppRemoteCallback)callback DEPRECATED_MSG_ATTRIBUTE("Deprecated. Use fetchRecommendedContentItemsForType:flattenContainers:callback: instead.");

/**
 * Fetches the children items for the provided content item.
 *
 * @note The `isContainer` property of the `SPTAppRemoteContentItem`
 *       indicates whether or not the item has any children.
 *
 * @param contentItem The content item to fetch the children for.
 * @param callback The callback to be called once the request is completed.
 */
- (void)fetchChildrenOfContentItem:(id<SPTAppRemoteContentItem>)contentItem
                          callback:(nullable SPTAppRemoteCallback)callback;

/**
 * Fetches a list of recommended playlists for the current user.
 *
 * @note The playlists returned are a mix of the user's recently played feed
 *       as well as personal recommendations, and as such may vary between users. If the
 *       user is offline, this method will only return the content that is available offline, if any.
 * @note This method is only supported by Spotify clients running version 8.4.75 and above
 *       and will fail with an `SPTAppRemoteWAMPClientNotSupportedError` otherwise.
 *
 * @param contentType A type that is used to retrieve content for a specific use-case.
 * @param flattenContainers Whether or not the recommendations should be flattened into a single list or remain
 *                          separated in containers.
 * @param callback The callback to be called once the request is completed.
 */
- (void)fetchRecommendedContentItemsForType:(SPTAppRemoteContentType)contentType
                          flattenContainers:(BOOL)flattenContainers
                                   callback:(nullable SPTAppRemoteCallback)callback;

/**
 Fetches the content item for the provided URI.

 @param URI A Spotify URI as string
 @param callback The callback to be called once the request is completed.
 */
- (void)fetchContentItemForURI:(NSString *)URI callback:(nullable SPTAppRemoteCallback)callback;

@end

NS_ASSUME_NONNULL_END
