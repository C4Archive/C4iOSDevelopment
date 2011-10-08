//
//  ViewController.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-06.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4Canvas.h"
#import "C4Color.h"

@interface C4CanvasController : UIViewController
-(void)setup;
-(void)reset;
@property (readwrite,retain) C4Canvas *canvas;
@end