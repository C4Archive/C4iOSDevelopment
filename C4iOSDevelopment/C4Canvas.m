//
//  C4Canvas.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Canvas.h"

@implementation C4Canvas

-(id)init {
    self = [super init];
    if(self) {
        readyToDisplay = NO;
        self.borderWidth = 0.0f;
    }
    return self;
}

-(void)setup {
    [self setOpaque:YES];
    self.backgroundColor = [UIColor whiteColor].CGColor;
    readyToDisplay = YES;
}

-(void)display {
    if(readyToDisplay) {
        [super display]; 
    }
}

-(void)addImage:(C4Image *)newImage {
    [self addSublayer:newImage];
}

-(void)addShape:(C4Shape *)newShape {
    [self addSublayer:newShape];
}

-(void)addLayer:(C4Layer *)newLayer {
    [self addSublayer:newLayer];
}

-(void)addTextLayer:(C4TextLayer *)newTextLayer {
    [self addSublayer:newTextLayer];
}

-(void)receiveTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)theEvent {
}

-(void)receiveTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)theEvent {
}

-(void)receiveTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)theEvent {
}

-(void)test {
    for(C4TextLayer *layer in self.sublayers) {
//        if([layer class] == [C4TextLayer class]) {
//            layer.uiFont = [UIFont fontWithName:@"Futura" size:20.0f];
//        }
//        if([layer class] == [C4TextLayer class]) {
//            [layer fitTextToWidth:2200.0f withMaximumFontSize:<#(CGFloat)#>];
//        }
    }
    C4Log(@"test");
}
@end