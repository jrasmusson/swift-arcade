#import "ConnectView.h"
#import "ViewController.h"

static NSString * const SpotifyClientID = @"044b2c45e77f45aca8da89e338849b6a";
static NSString * const SpotifyRedirectURLString = @"spotify-login-sdk-test-app://spotify-login-callback";

@interface ViewController ()
@end

@implementation ViewController

#pragma mark - Authorization example

- (void)viewDidLoad
{
    /*
     This configuration object holds your client ID and redirect URL.
     */
    SPTConfiguration *configuration = [SPTConfiguration configurationWithClientID:SpotifyClientID
                                                                      redirectURL:[NSURL URLWithString:SpotifyRedirectURLString]];

    // Set these url's to your backend which contains the secret to exchange for an access token
    // You can use the provided ruby script spotify_token_swap.rb for testing purposes
    configuration.tokenSwapURL = [NSURL URLWithString: @"http://localhost:1234/swap"];
    configuration.tokenRefreshURL = [NSURL URLWithString: @"http://localhost:1234/refresh"];

    /*
     The session manager lets you authorize, get access tokens, and so on.
     */
    self.sessionManager = [SPTSessionManager sessionManagerWithConfiguration:configuration
                                                                    delegate:self];
    [super viewDidLoad];
}

#pragma mark - Actions

- (void)didTapAuthButton:(ConnectButton *)sender
{
    /*
     Scopes let you specify exactly what types of data your application wants to
     access, and the set of scopes you pass in your call determines what access
     permissions the user is asked to grant.
     For more information, see https://developer.spotify.com/web-api/using-scopes/.
     */
    SPTScope scope = SPTUserLibraryReadScope | SPTPlaylistReadPrivateScope;

    /*
     Start the authorization process. This requires user input.
     */
    if (@available(iOS 11, *)) {
        // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
        [self.sessionManager initiateSessionWithScope:scope options:SPTDefaultAuthorizationOption];
    } else {
        // Use this on iOS versions < 11 to use SFSafariViewController
        [self.sessionManager initiateSessionWithScope:scope options:SPTDefaultAuthorizationOption presentingViewController:self];
    }
}

#pragma mark - SPTSessionManagerDelegate

- (void)sessionManager:(SPTSessionManager *)manager didInitiateSession:(SPTSession *)session
{
    [self presentAlertControllerWithTitle:@"Authorization Succeeded"
                                  message:session.description
                              buttonTitle:@"Nice"];
}

- (void)sessionManager:(SPTSessionManager *)manager didFailWithError:(NSError *)error
{
    [self presentAlertControllerWithTitle:@"Authorization Failed"
                                  message:error.description
                              buttonTitle:@"Bummer"];
}

- (void)sessionManager:(SPTSessionManager *)manager didRenewSession:(SPTSession *)session
{
    [self presentAlertControllerWithTitle:@"Session Renewed"
                                  message:session.description
                              buttonTitle:@"Sweet"];
}

#pragma mark - Set up view

- (void)loadView
{
    ConnectView *view = [ConnectView new];
    [view.connectButton addTarget:self action:@selector(didTapAuthButton:) forControlEvents:UIControlEventTouchUpInside];
    self.view = view;
}

- (void)presentAlertControllerWithTitle:(NSString *)title
                                message:(NSString *)message
                            buttonTitle:(NSString *)buttonTitle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:buttonTitle
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:dismissAction];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    });
}

@end
