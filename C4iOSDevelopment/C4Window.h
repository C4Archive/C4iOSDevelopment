//
//  C4Window.h
//  C4iOS
//
//  Created by Travis Kirton on 11-08-23.
//  Copyright 2011 mediart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4Defines.h"
#import "C4Canvas.h"
#import "C4Foundation.h"
#import "C4CanvasController.h"

@interface C4Window : UIWindow {
    C4CanvasController *controller;
}
@property (readwrite, retain) C4CanvasController *controller;
@end
