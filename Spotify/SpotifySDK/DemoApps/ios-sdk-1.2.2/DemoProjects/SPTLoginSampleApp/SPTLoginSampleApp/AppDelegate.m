#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@property(nonatomic, strong) ViewController *rootViewController;

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<NSString *, id> *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [ViewController new];
    self.rootViewController = [ViewController new];
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)URL
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    [self.rootViewController.sessionManager application:application openURL:URL options:options];
    NSLog(@"%@ %@", URL, options);
    return YES;
}

@end
