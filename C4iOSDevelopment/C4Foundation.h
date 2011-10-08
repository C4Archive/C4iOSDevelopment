//
//  C4Foundation.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C4Foundation : NSObject
+(C4Foundation *)sharedClass;
void C4Log(NSString *logString,...);
@end
