#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `SPTAppRemoteLibraryState` represents a the state of an album or track in a users Spotify library.
 */
@protocol SPTAppRemoteLibraryState <NSObject>

/// The uri of the track or album
@property (nonatomic, strong, readonly) NSString *uri;
/// `YES` album or track was added to the user's library, otherwise `NO`.
@property (nonatomic, assign, readonly) BOOL isAdded;
/// `YES` album or track can be added to the user's library, otherwise `NO`.
@property (nonatomic, assign, readonly) BOOL canAdd;

@end

NS_ASSUME_NONNULL_END
