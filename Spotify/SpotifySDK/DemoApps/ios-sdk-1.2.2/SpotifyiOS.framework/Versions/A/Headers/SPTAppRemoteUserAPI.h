#import <Foundation/Foundation.h>

#import "SPTAppRemoteCommon.h"

@protocol SPTAppRemoteUserAPI;
@protocol SPTAppRemoteUserCapabilities;

NS_ASSUME_NONNULL_BEGIN

/**
 * The `SPTAppRemoteUserAPIDelegate` gets notified whenever the user API receives new data from subscription events.
 */
@protocol SPTAppRemoteUserAPIDelegate <NSObject>

/**
 * Called when the capabilities has been updated.
 *
 * @note This will only be called if there is an active capabilities subscription.
 *
 * @param userAPI      The API that received updates.
 * @param capabilities The new capabilities that was received.
 */
- (void)userAPI:(id<SPTAppRemoteUserAPI>)userAPI didReceiveCapabilities:(id<SPTAppRemoteUserCapabilities>)capabilities;

@end

/**
 * The `SPTAppRemoteUserAPI` is used to get user data from, and interact with user features in, the Spotify app.
 */
@protocol SPTAppRemoteUserAPI <NSObject>

/// The User API delegate gets notified whenever the API receives new data from subscription events.
@property (nonatomic, weak, readwrite) id<SPTAppRemoteUserAPIDelegate> delegate;

/**
 *  Fetches the current users capabilities from the Spotify app.
 *
 *  @param callback A callback block that will be invoked when the fetch request has completed.
 *                  On success `result` will be an instance of `id<SPTAppRemoteUserCapabilities>`.
 *                  On error `result` will be `nil` and `error` will be set.
 */
- (void)fetchCapabilitiesWithCallback:(nullable SPTAppRemoteCallback)callback;

/**
 * Subscribes to capability changes from the Spotify app.
 *
 * @note Implement `SPTAppRemoteUserAPIDelegate` and set yourself as `delegate` in order to be notified when the
 *       the capabilities changes.
 *
 * @param callback A callback block that will be invoked when the subscription request has completed.
 *                 On success `result` will `YES`.
 *                 On error `result` will be `nil` and `error` will be set.
 */
- (void)subscribeToCapabilityChanges:(nullable SPTAppRemoteCallback)callback;

/**
 * Stops subscribing to capability changes from the Spotify app.
 *
 * @param callback A callback block that will be invoked when the unsubscription request has completed.
 *                 On success `result` will be `YES`.
 *                 On error `result` will be `nil` and `error` will be set.
 */
- (void)unsubscribeToCapabilityChanges:(nullable SPTAppRemoteCallback)callback;

/**
 *  Fetches the current users library state for a given album or track uri.
 *
 *  @param URI      The URI of the album or track we are fetching the state for
 *  @param callback A callback block that will be invoked when the fetch request has completed.
 *                  On success `result` will be an instance of `id<SPTAppRemoteLibraryState>`.
 *                  On error `result` will be `nil` and `error` will be set.
 */
- (void)fetchLibraryStateForURI:(NSString *)URI callback:(SPTAppRemoteCallback)callback;

/**
 *  Add item to the users library.
 *  Currently supported uris include:
 *                  Tracks - example: spotify:track:6rqhFgbbKwnb9MLmUQDhG6
 *                  Albums - example: spotify:album:2VYSDvc0ZdcfkXDcYVjHs6
 *
 *  @param URI      The URI of the item to save
 *  @param callback A callback block that will be invoked when the fetch request has completed.
 *                  On success `result` will be @YES.
 *                  On error `result` will be `nil` and `error` will be set.
 */
- (void)addItemToLibraryWithURI:(NSString *)URI callback:(SPTAppRemoteCallback)callback;

/**
 *  Remove item from users library.
 *  Currently supported uris include:
 *                  Tracks - example: spotify:track:6rqhFgbbKwnb9MLmUQDhG6
 *                  Albums - example: spotify:album:2VYSDvc0ZdcfkXDcYVjHs6
 *
 *  @param URI      The URI of the item to remove
 *  @param callback A callback block that will be invoked when the fetch request has completed.
 *                  On success `result` will be @YES.
 *                  On error `result` will be `nil` and `error` will be set.
 */
- (void)removeItemFromLibraryWithURI:(NSString *)URI callback:(SPTAppRemoteCallback)callback;

@end

NS_ASSUME_NONNULL_END
