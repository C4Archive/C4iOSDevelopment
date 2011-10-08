//
//  AppDelegate.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-06.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4Window.h"

@class C4CanvasController;

@interface C4iOSDevelopmentAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) C4Window *window;

@property (strong, nonatomic, retain) C4CanvasController *canvasController;

@end
