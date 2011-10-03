//
//  C4Foundation.h
//  C4iOS
//
//  Created by Travis Kirton on 11-08-24.
//  Copyright 2011 mediart. All rights reserved.
//

@interface C4Foundation : NSObject
+(C4Foundation *)sharedClass;
void C4Log(NSString *logString,...);
@end
