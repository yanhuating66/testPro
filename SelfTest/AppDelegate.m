//
//  AppDelegate.m
//  SelfTest
//
//  Created by 严华停 on 2020/1/13.
//  Copyright © 2020 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FirstVC.h"
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    CLLocationManager *locMgr =[[CLLocationManager alloc] init];
//    [locMgr requestWhenInUseAuthorization];
    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navagation =[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    navagation.navigationBar.translucent =NO;
    self.window.rootViewController =navagation;
    
    [self.window makeKeyAndVisible];
    
    [navagation.navigationBar setBarStyle:UIBarStyleBlack];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    NSLog(@"widow =%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
    return YES;
}


#pragma mark - UISceneSession lifecycle

//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}
//

@end
