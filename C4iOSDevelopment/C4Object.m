//
//  C4Object.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"

@implementation C4Object

@synthesize timestamp;

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    
}

-(void)listenFor:(NSString *)aNotification andRunMethod:(NSString *)aMethodName{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:NSSelectorFromString(aMethodName) name:aNotification object:nil];
}

-(void)stopListeningFor:(NSString *)aMethodName {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:aMethodName object:nil];
}

-(void)postNotification:(NSString *)aNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:aNotification object:self];
}

-(void)setTimestamp:(NSTimeInterval)_timestamp {
    if(self.timestamp == 0.0f)
        self.timestamp = _timestamp;
}

@end
