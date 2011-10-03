//
//  C4CanvasController.h
//  C4iOS
//
//  Created by Travis Kirton on 11-08-24.
//  Copyright 2011 mediart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C4Canvas.h"
#import "C4Color.h"

@interface C4CanvasController : NSObject
-(void)setup;
-(void)reset;
@property (readwrite,retain) C4Canvas *canvas;
@end