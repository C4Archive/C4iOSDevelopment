//
//  C4Noise.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-11-20.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"

@interface C4Noise : C4Object {
@private
    
}

+(C4Noise *)sharedManager;

+(CGFloat)noiseX:(CGFloat)x;
+(CGFloat)noiseX:(CGFloat)x Y:(CGFloat)y;
+(CGFloat)noiseX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
@end
