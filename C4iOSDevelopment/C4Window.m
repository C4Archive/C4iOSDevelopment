//
//  C4Window.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Window.h"

@implementation C4Window
@synthesize canvasController;

- (id)init
{
    self = [super init];
    if (self) {
#ifdef VERBOSE
        C4Log(@"%@ init",[self class]);
#endif

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
        pan.minimumNumberOfTouches = 1;
        pan.maximumNumberOfTouches = 5;
        
        [self addGestureRecognizer:pan];
    }
    return self;
}

-(void)awakeFromNib {
#ifdef VERBOSE
    C4Log(@"%@ awakeFromNib",[self class]);
#endif
    [(C4Canvas *)[self layer] setup];
}

-(void)drawRect:(CGRect)rect {
    [self.layer display];
}

/*
 The following method makes sure that the main backing CALayer
 for this UIWindow subclass will be a C4Canvas
 */
+(Class)layerClass {
    return [C4Canvas class];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [(C4Canvas *)self.layer receiveMovedTouches:touches withEvent:event];
}

@end
