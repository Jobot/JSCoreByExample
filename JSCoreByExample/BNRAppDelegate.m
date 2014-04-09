//
//  BNRAppDelegate.m
//  JSCoreByExample
//
//  Created by Joseph W. Dixon on 4/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRContact.h"
#import "BNRContactApp.h"
#import "BNRContactListVC.h"

@interface BNRAppDelegate()

@property (nonatomic) BNRContactApp *app;

@end

@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // create a new contact app
    self.app = [BNRContactApp new];
    
    // add some dummy data
    [self.app addContact:[BNRContact contactWithName:@"Philip J. Fry" phone:@"999 555-1999" address:@"Robot Arms Apt 00100100, Earth"]];
    [self.app addContact:[BNRContact contactWithName:@"Bender B. Rodriguez" phone:@"010 110-0101" address:@"Robot Arms Apt 00100100, Earth"]];
    [self.app addContact:[BNRContact contactWithName:@"Turanga Leela" phone:@"999 555-5309" address:@"132 Sewer Street, Earth"]];
    [self.app addContact:[BNRContact contactWithName:@"Amy Wong" phone:@"999 555-2811" address:@"1 Wong Way, Mars"]];
    [self.app addContact:[BNRContact contactWithName:@"Zapp Brannigan" phone:@"3" address:@"D.O.O.P. HQ, Earth"]];
    [self.app addContact:[BNRContact contactWithName:@"Lrrr" phone:@"999 555-8888" address:@"1 Palace Circle, Omicron Persei 8"]];
    
    NSLog(@"%@", self.app);
    
    // create list VC as root VC
    self.window.rootViewController = [[BNRContactListVC alloc] initWithApp:self.app];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
