//
//  AppDelegate.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-06.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4iOSDevelopmentAppDelegate.h"

#import "C4CanvasController.h"

@implementation C4iOSDevelopmentAppDelegate

@synthesize window = _window;
@synthesize canvasController = _canvasController;
@synthesize inceptionMovieController = _inceptionMovieController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.statusBarHidden = YES;
    self.window = [[C4Window alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.canvasController = [[C4CanvasController alloc] initWithNibName:@"C4CanvasController" bundle:nil];
    self.window.rootViewController = self.canvasController;
    
    self.canvasController.canvas = (C4Canvas *)self.window.layer;
    
    [self.window makeKeyAndVisible];
    [[AVAudioSession sharedInstance] setDelegate:self.canvasController];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    [self.canvasController setup];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [C4Vector disposeOfVectorQueueIfNeeded];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
