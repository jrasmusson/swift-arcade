#import <Foundation/Foundation.h>

#import "SPTMacros.h"

NS_ASSUME_NONNULL_BEGIN

SPT_EXPORT NSErrorDomain const SPTLoginErrorDomain;

/// Spotify error codes, use NSUnderlyingErrorKey to see the underlying error
typedef NS_ENUM(NSUInteger, SPTErrorCode)
{
    /// Unknown error code
    SPTUnknownErrorCode NS_SWIFT_NAME(unknown) = 0,
    /// Authorization failed
    SPTAuthorizationFailedErrorCode NS_SWIFT_NAME(authorizationFailed),
    /// Renew session failed
    SPTRenewSessionFailedErrorCode NS_SWIFT_NAME(renewSessionFailed),
    /// Failed to parse the returned JSON
    SPTJSONFailedErrorCode NS_SWIFT_NAME(jsonFailed),
};

/// Spotify-specific errors. Use NSUnderlyingErrorKey to see the underlying error
@interface SPTError : NSError

+ (instancetype)errorWithCode:(SPTErrorCode)code;

+ (instancetype)errorWithCode:(SPTErrorCode)code description:(NSString *)description;

+ (instancetype)errorWithCode:(SPTErrorCode)code underlyingError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
