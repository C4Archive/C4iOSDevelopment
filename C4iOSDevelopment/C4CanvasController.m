//
//  ViewController.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-06.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4CanvasController.h"

@implementation C4CanvasController

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
    self.view.multipleTouchEnabled = YES;
    self.view.exclusiveTouch = YES;

    /* This is how to add taps */
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:canvas action:@selector(test)];
    tap.numberOfTapsRequired=2;
    [self.view addGestureRecognizer:tap];

    /* --- */
    [self reset];
}

-(void)reset {    
    CGPoint position = CGPointMake(16, 16);
    
    for(NSString *familyName in [UIFont familyNames]) {
        for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            C4String *newString = [[C4String alloc] initWithString:fontName];

            newString.font = [C4Font fontWithName:fontName size:10.0f];

            C4TextLayer *textLayer = [C4TextLayer layerWithString:newString];
            textLayer.position = position;

            [canvas addTextLayer:textLayer];
            position.y += 24.0f;
            if(position.y > 1000) {
                position.x += 195.0f;
                position.y = 16.0f;
            }
        }
    }


}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [canvas receiveTouchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [canvas receiveTouchesMoved:touches withEvent:event];
}
@end
