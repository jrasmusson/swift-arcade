/**
 * Common header definitions
 */

NS_ASSUME_NONNULL_BEGIN

/// The error domain for user facing errors that occur in the App Remote.
extern NSString * const SPTAppRemoteErrorDomain;

/// The error codes in the `SPTAppRemoteErrorDomain` domain.
typedef NS_ENUM(NSInteger, SPTAppRemoteErrorCode) {
    /// An unknown error.
    SPTAppRemoteUnknownError                 =    -1,

    /// The background wakeup of the Spotify app failed.
    SPTAppRemoteBackgroundWakeupFailedError  = -1000,
    /// The connection attempt to the Spotify app failed.
    SPTAppRemoteConnectionAttemptFailedError = -1001,
    /// The conncetion to the Spotify app was terminated.
    SPTAppRemoteConnectionTerminatedError    = -1002,
    /// The arguments supplied are invalid.
    SPTAppRemoteInvalidArgumentsError        = -2000,
    /// The request has failed for some reason.
    SPTAppRemoteRequestFailedError           = -2001,
};

/**
 *  A callback block used by many App Remote API methods.
 *
 *  @param result The result of the operation, or `nil` if the operation failed.
 *  @param error  An error object, or `nil` if the operation was a success.
 */
typedef void (^SPTAppRemoteCallback)(id _Nullable result, NSError * _Nullable error);

NS_ASSUME_NONNULL_END

