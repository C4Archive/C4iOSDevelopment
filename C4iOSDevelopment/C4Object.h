//
//  C4Object.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C4Object : NSObject {
}
-(void)setup;
-(void)listenFor:(NSString *)aNotification andRunMethod:(NSString *)aMethodName;
-(void)stopListeningFor:(NSString *)aMethodName;
-(void)postNotification:(NSString *)aNotification;

@property (nonatomic, readwrite) NSTimeInterval timestamp;
@end
