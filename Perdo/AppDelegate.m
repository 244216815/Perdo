//
//  AppDelegate.m
//  Perdo
//
//  Created by 一招 on 2020/3/24.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:[MainTabBarController tabbarController]];
    [self.window makeKeyAndVisible];
    
    return YES;
}



- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{

}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{

}


- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
