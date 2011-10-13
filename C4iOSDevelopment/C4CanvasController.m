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
    self.view.multipleTouchEnabled = NO;
    self.view.exclusiveTouch = YES;

    /* This is how to add taps */
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test)];
    tap.numberOfTapsRequired=2;
    [self.view addGestureRecognizer:tap];
    
    /* --- */
    [self reset];
}

-(void)reset {    
    image = [C4Image imageNamed:@"C4LogoiPad-01.png"];
    [image setPosition:CGPointMake(300, 300)];
    image.shadowOpacity = 0.7f;
    image.shadowOffset = CGSizeMake(0.0f, 3.0f);    
    [canvas addImage:image];
}

-(void)test {
    image.position = CGPointMake(500, 500);
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
    for(UITouch *t in touches)
        image.position = [t locationInView:[t view]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}
@end
