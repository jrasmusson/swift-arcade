#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A configuration class, holding the credentials provided for your app on the Spotify Developer website.
 See https://developer.spotify.com/my-applications/
*/
@interface SPTConfiguration : NSObject <NSSecureCoding>

/// Your app's Client ID from developer.spotify.com
@property (nonatomic, readonly, copy) NSString *clientID;

/// Your redirect URL. This is how the Spotify app will open your application after user authorization.
@property (nonatomic, readonly, copy) NSURL *redirectURL;

/**
 The URL to use for attempting to swap an authorization code for an access token. You should only set this if your
 clientID has a clientSecret and you have a backend service that holds the secret and can exchange the code and secret
 for an access token.
*/
@property (nonatomic, nullable, copy) NSURL *tokenSwapURL;

/**
 The URL to use for attempting to renew an access token with a refresh token. You should only set this if your
 clientID has a clientSecret and you have a backend service that holds the secret and can use a refresh token
 to get a new access token.
*/
@property (nonatomic, nullable, copy) NSURL *tokenRefreshURL;

/**
 If requesting the `SPTAppRemoteControlScope` you can provide an optional uri to begin playing after a successful
 authentication. To continue the user's last session set this to a blank string @"". If this value is `nil` or `SPTAppRemoteControlScope`
 is not requested no audio will play.
 */
@property (nonatomic, nullable, copy) NSString *playURI;

- (instancetype)init NS_UNAVAILABLE;

/**
 Designated initializer for `SPTConfiguration`

 @param clientID Your client ID obtained from developer.spotify.com
 @param redirectURL Your redirect URL for Spotify to open your app again after authorization
 @return A newly initialized `SPTConfiguration`
 */
- (instancetype)initWithClientID:(NSString *)clientID
                     redirectURL:(NSURL *)redirectURL NS_DESIGNATED_INITIALIZER;

/**
 Convenience intializer for `SPtConfiguration`

 @param clientID Your client ID obtained from developer.spotify.com
 @param redirectURL Your redirect URL for Spotify to open your app again after authorization
 @return A newly initialized `SPTConfiguration`
 */
+ (instancetype)configurationWithClientID:(NSString *)clientID
                              redirectURL:(NSURL *)redirectURL NS_SWIFT_UNAVAILABLE("superfluous");

@end


NS_ASSUME_NONNULL_END
