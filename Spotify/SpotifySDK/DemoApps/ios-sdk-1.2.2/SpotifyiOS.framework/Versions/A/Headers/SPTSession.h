#import "SPTScope.h"

NS_ASSUME_NONNULL_BEGIN


/// The `SPTSession` represents an authenticated Spotify user session.
@interface SPTSession : NSObject <NSSecureCoding>

/// The access token of the authenticated user.
@property (nonatomic, readonly, copy) NSString *accessToken;

/// The refresh token.
@property (nonatomic, readonly, copy) NSString *refreshToken;

/// The expiration date of the access token.
@property (nonatomic, readonly, copy) NSDate *expirationDate;

/// The scope granted.
@property (nonatomic, readonly) SPTScope scope;

/**
 Check whether the session has expired. `YES` if expired; `NO` otherwise.
 Note: The session is considered expired once the current date and time is equal to or greater than the expiration date and time.
*/
@property (nonatomic, readonly, getter=isExpired) BOOL expired;

- (instancetype)init NS_UNAVAILABLE;

@end


NS_ASSUME_NONNULL_END
