//
//  C4Window.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4CanvasController.h"
#import "C4Canvas.h"

@interface C4Window : UIWindow 
    
@property (readwrite,retain) C4CanvasController *canvasController;
@end
