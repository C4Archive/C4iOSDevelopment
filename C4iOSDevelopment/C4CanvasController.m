//
//  ViewController.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-06.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4CanvasController.h"

@interface C4CanvasController()
-(void)reset;
@end

@implementation C4CanvasController

C4Image *image;

@synthesize canvas;
-(void)setup {    
    /* 
     
     Oct. 9/2011
     
     I'm not sure how this view stuf works... 
     I thought it was Window->CALayer
     
     But, apparently, there's a UIView in between somewhere...
     Should the canvas be this view?
     I would prefer it as a CALayer...
     
     */
    
    self.view.userInteractionEnabled = YES;
    self.view.multipleTouchEnabled = NO;
    self.view.exclusiveTouch = YES;
    
    /* This is how to add taps */
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
    tap2.numberOfTapsRequired = 1;
    tap2.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tripleTap)];
    tap3.numberOfTapsRequired = 1;
    tap3.numberOfTouchesRequired = 3;
    [self.view addGestureRecognizer:tap3];
    
    [self reset];
}

-(void)reset {    
    image = [C4Image imageNamed:@"C4LogoiPad-01.png"];
    image.position = CGPointMake(300, 300);
    image.shadowOpacity = 0.7f;
    image.shadowOffset = CGSizeMake(0.0f, 3.0f);
    [canvas addImage:image];
}

-(void)singleTap:(id)sender {
    image.position = [sender locationOfTouch:0 inView:self.view];
}

-(void)doubleTap {
    image.bounds = CGRectMake(0,0,72.0f,72.0f);
}

-(void)tripleTap {
    image.bounds = CGRectMake(0,0,14.0f,14.0f);
}

@end
