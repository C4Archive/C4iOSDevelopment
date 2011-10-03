//
//  C4iOSAppDelegate.h
//  C4iOS
//
//  Created by Travis Kirton on 11-08-23.
//  Copyright 2011 mediart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4Defines.h"
#import "C4Window.h"
#import "C4Foundation.h"
#import "C4CanvasController.h"

@interface C4iOSAppDelegate : NSObject <UIApplicationDelegate> {
    C4CanvasController *controller;
}
@property (nonatomic, retain) IBOutlet C4Window *window;
@end
