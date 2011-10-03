//
//  C4Foundation.m
//  C4iOS
//
//  Created by Travis Kirton on 11-08-24.
//  Copyright 2011 mediart. All rights reserved.
//

#import "C4Foundation.h"

@implementation C4Foundation

- (id)init
{
    self = [super init];
    if (self) {
        #ifdef VERBOSE
        C4Log(@"%@ init",[self class]);
        #endif
    }
    
    return self;
}

+(C4Foundation *)sharedClass {
    static dispatch_once_t once;
    static C4Foundation *myClass;
    dispatch_once(&once, ^ { myClass = [[self alloc] init]; });
    return myClass;
}

void C4Log(NSString *logString,...) {
    va_list args;
	
    va_start (args, logString);
    NSString *finalString = [[NSString alloc] initWithFormat:[logString stringByAppendingString: @"\n"] arguments:args];
    va_end (args);
    
	fprintf(stderr,"[C4Log] %s",[finalString UTF8String]);
}

@end
