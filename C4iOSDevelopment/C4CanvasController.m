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
    [canvas setBackgroundColor:[[UIColor whiteColor] CGColor]];
    [canvas setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [canvas setBorderWidth:3];
    
    [self reset];
}

-(void)reset {
    
    C4Log(@"controller reset");
    [canvas removeAllShapes];
    [C4Shape setFillColor:[UIColor colorWithRed:1.0f green:0.2f blue:0.2f alpha:1.0f]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(350, 612) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(250, 612) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(150, 612) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(150, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(150, 412) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(150, 312) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(250, 312) size:CGSizeMake(100, 100)]];
    
    [C4Shape setFillColor:[UIColor colorWithRed:0.2 green:0.4 blue:1.0f alpha:1.0f]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(550, 312) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(550, 412) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(550, 612) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(650, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(550, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(450, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(350, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(350, 412) size:CGSizeMake(100, 100)]];
    
    [C4Shape setFillColor:[UIColor colorWithWhite:0.13 alpha:1.0f]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(350, 312) size:CGSizeMake(100, 100)]];
    
    [canvas addShape:[C4Shape pointAt:CGPointMake(10, 10)]];
    
    [canvas display];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
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

@end
