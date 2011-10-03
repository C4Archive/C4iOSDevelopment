//
//  C4Layer.h
//  C4iOS
//
//  Created by Travis Kirton on 11-08-24.
//  Copyright 2011 mediart. All rights reserved.
//

#import "C4Defines.h"
#import "C4Foundation.h"
#import <QuartzCore/QuartzCore.h>

@interface C4Layer : CALayer

-(void)setup;

-(void)listenFor:(NSString *)aNotification andRunMethod:(NSString *)aMethodName;
-(void)stopListeningFor:(NSString *)aMethodName;
-(void)postNotification:(NSString *)aNotification;
@end
