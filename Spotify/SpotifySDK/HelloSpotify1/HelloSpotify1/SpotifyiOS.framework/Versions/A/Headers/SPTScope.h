// (Objective-C identifier, Swift name, string value, bit flag)
#define SPT_SCOPE_LIST \
SPT_SCOPE(SPTPlaylistReadPrivateScope, playlistReadPrivate, "playlist-read-private", (1 << 0)) \
SPT_SCOPE(SPTPlaylistReadCollaborativeScope, playlistReadCollaborative, "playlist-read-collaborative", (1 << 1)) \
SPT_SCOPE(SPTPlaylistModifyPublicScope, playlistModifyPublic, "playlist-modify-public", (1 << 2)) \
SPT_SCOPE(SPTPlaylistModifyPrivateScope, playlistModifyPrivate, "playlist-modify-private", (1 << 3)) \
SPT_SCOPE(SPTUserFollowReadScope, userFollowRead, "user-follow-read", (1 << 4)) \
SPT_SCOPE(SPTUserFollowModifyScope, userFollowModify, "user-follow-modify", (1 << 5)) \
SPT_SCOPE(SPTUserLibraryReadScope, userLibraryRead, "user-library-read", (1 << 6)) \
SPT_SCOPE(SPTUserLibraryModifyScope, userLibraryModify, "user-library-modify", (1 << 7)) \
SPT_SCOPE(SPTUserReadBirthDateScope, userReadBirthDate, "user-read-birthdate", (1 << 8)) \
SPT_SCOPE(SPTUserReadEmailScope, userReadEmail, "user-read-email", (1 << 9)) \
SPT_SCOPE(SPTUserReadPrivateScope, userReadPrivate, "user-read-private", (1 << 10)) \
SPT_SCOPE(SPTUserTopReadScope, userTopRead, "user-top-read", (1 << 11)) \
SPT_SCOPE(SPTUGCImageUploadScope, ugcImageUpload, "ugc-image-upload", (1 << 12)) \
SPT_SCOPE(SPTStreamingScope, streaming, "streaming", (1 << 13)) \
SPT_SCOPE(SPTAppRemoteControlScope, appRemoteControl, "app-remote-control", (1 << 14)) \
SPT_SCOPE(SPTUserReadPlaybackStateScope, userReadPlaybackState, "user-read-playback-state", (1 << 15)) \
SPT_SCOPE(SPTUserModifyPlaybackStateScope, userModifyPlaybackState, "user-modify-playback-state", (1 << 16)) \
SPT_SCOPE(SPTUserReadCurrentlyPlayingScope, userReadCurrentlyPlaying, "user-read-currently-playing", (1 << 17)) \
SPT_SCOPE(SPTUserReadRecentlyPlayedScope, userReadRecentlyPlayed, "user-read-recently-played", (1 << 18))

/**
 `SPTScope` represents the OAuth scopes that declare how your app wants to access a user's account.
 See https://developer.spotify.com/web-api/using-scopes/ for more information.
*/
typedef NS_OPTIONS(NSUInteger, SPTScope)
{
    /// Read access to user's private playlists.
    SPTPlaylistReadPrivateScope NS_SWIFT_NAME(playlistReadPrivate) = (1 << 0),
    /// Include collaborative playlists when requesting a user's playlists.
    SPTPlaylistReadCollaborativeScope NS_SWIFT_NAME(playlistReadCollaborative) = (1 << 1),
    /// Write access to a user's public playlists.
    SPTPlaylistModifyPublicScope NS_SWIFT_NAME(playlistModifyPublic) = (1 << 2),
    /// Write access to a user's private playlists.
    SPTPlaylistModifyPrivateScope NS_SWIFT_NAME(playlistModifyPrivate) = (1 << 3),
    /// Read access to the list of artists and other users that the user follows.
    SPTUserFollowReadScope NS_SWIFT_NAME(userFollowRead) = (1 << 4),
    /// Write/delete access to the list of artists and other users that the user follows.
    SPTUserFollowModifyScope NS_SWIFT_NAME(userFollowModify) = (1 << 5),
    /// Read access to a user's "Your Music" library.
    SPTUserLibraryReadScope NS_SWIFT_NAME(userLibraryRead) = (1 << 6),
    /// Write/delete access to a user's "Your Music" library.
    SPTUserLibraryModifyScope NS_SWIFT_NAME(userLibraryModify) = (1 << 7),
    /// Read access to the user's birthdate.
    SPTUserReadBirthDateScope NS_SWIFT_NAME(userReadBirthDate) = (1 << 8),
    /// Read access to user’s email address.
    SPTUserReadEmailScope NS_SWIFT_NAME(userReadEmail) = (1 << 9),
    /// Read access to user’s subscription details (type of user account).
    SPTUserReadPrivateScope  NS_SWIFT_NAME(userReadPrivate) = (1 << 10),
    /// Read access to a user's top artists and tracks.
    SPTUserTopReadScope NS_SWIFT_NAME(userTopRead) = (1 << 11),
    /// Upload user generated content images
    SPTUGCImageUploadScope NS_SWIFT_NAME(ugcImageUpload) = (1 << 12),
    /// Control playback of a Spotify track.
    SPTStreamingScope NS_SWIFT_NAME(streaming) = (1 << 13),
    /// Use App Remote to control playback in the Spotify app
    SPTAppRemoteControlScope NS_SWIFT_NAME(appRemoteControl) = (1 << 14),
    /// Read access to a user’s player state.
    SPTUserReadPlaybackStateScope NS_SWIFT_NAME(userReadPlaybackState) = (1 << 15),
    /// Write access to a user’s playback state
    SPTUserModifyPlaybackStateScope NS_SWIFT_NAME(userModifyPlaybackState) = (1 << 16),
    /// Read access to a user’s currently playing track
    SPTUserReadCurrentlyPlayingScope NS_SWIFT_NAME(userReadCurrentlyPlaying) = (1 << 17),
    /// Read access to a user’s currently playing track
    SPTUserReadRecentlyPlayedScope NS_SWIFT_NAME(userReadRecentlyPlayed) = (1 << 18),
};

