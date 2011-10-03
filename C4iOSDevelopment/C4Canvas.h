//
//  C4Canvas.h
//  C4iOS
//
//  Created by Travis Kirton on 11-08-23.
//  Copyright 2011 mediart. All rights reserved.
//
#import "C4Layer.h"
#import "C4Shape.h"

@interface C4Canvas : C4Layer {
    @private
    BOOL readyToDisplay;
}
-(void)addShape:(C4Shape *)newShape;
-(void)addLayer:(C4Layer *)newLayer;
-(void)removeAllShapes;
-(void)receiveMovedTouches:(NSSet *)touches withEvent:(UIEvent *)theEvent;
@end
