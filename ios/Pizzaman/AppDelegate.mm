#import "AppDelegate.h"

#import <UserNotifications/UserNotifications.h>

#import <React/RCTBundleURLProvider.h>

@import Mindbox;
@import MindboxSdk;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"Pizzaman";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};
  
  // MINDBOX INTEGRATION - enable the AppDelegate to respond to notification events
  [[UIApplication sharedApplication] registerForRemoteNotifications];
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  center.delegate = self;
  [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
    if (!error) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[Mindbox shared] notificationsRequestAuthorizationWithGranted:granted];
      });
    }
    else {
      NSLog(@"NotificationsRequestAuthorization failed with error: %@", error.localizedDescription);
    }
  }];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// MINDBOX INTEGRATION - Handling push notification clicks
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
  [[Mindbox shared] pushClickedWithResponse:response];
  [MindboxJsDelivery emitEvent:response];

  TrackVisitData *data = [[TrackVisitData alloc] init];
  data.push = response;
  [[Mindbox shared] trackWithData:data];

  completionHandler();
}

// MINDBOX INTEGRATION - Displaying notifications when the app is active
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
  completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}

// MINDBOX INTEGRATION - Updating APNS token in Mindbox
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [[Mindbox shared] apnsTokenUpdateWithDeviceToken:deviceToken];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self bundleURL];
}

- (NSURL *)bundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
