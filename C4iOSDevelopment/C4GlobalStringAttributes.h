//
//  C4GlobalStringAttributes.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-09.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"

@interface C4GlobalStringAttributes : C4Object {
    CGContextRef pdfContext;
    BOOL drawStringsToPDF;
    BOOL isClean;
    
}

+(C4GlobalStringAttributes *)sharedManager;

@property(readwrite) BOOL drawStringsToPDF, isClean;
@property(readwrite) CGContextRef pdfContext;
@end
