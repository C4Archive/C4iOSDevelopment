//
//  AppDelegate.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-06.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class C4CanvasController;

@interface C4iOSDevelopmentAppDelegate : NSObject <UIApplicationDelegate> {
}

@property (strong, nonatomic) IBOutlet C4Window *window;

@property (strong, nonatomic, retain) C4CanvasController *canvasController;

@end
