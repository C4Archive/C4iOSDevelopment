//
//  C4Canvas.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Layer.h"
#import "C4Shape.h"
#import "C4Foundation.h"

@interface C4Canvas : C4Layer {
@private
BOOL readyToDisplay;
}
-(void)addShape:(C4Shape *)newShape;
-(void)addLayer:(C4Layer *)newLayer;
-(void)receiveMovedTouches:(NSSet *)touches withEvent:(UIEvent *)theEvent;

@end
