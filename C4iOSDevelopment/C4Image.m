//
//  C4Image.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-12.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Image.h"

@implementation C4Image
@synthesize originalImage;

+(C4Image *)imageNamed:(NSString *)name {
    return [[C4Image alloc] initWithImageName:name];
}

-(id)initWithImage:(C4Image *)image {
    self = [super init];
    if(self) {
    }
    return self;
}

-(id)initWithImageName:(NSString *)name {
    self = [super init];
    if(self) {
        self.originalImage = [UIImage imageNamed:name];
        self.bounds = CGRectMake(0, 0, self.originalImage.size.width, self.originalImage.size.height);
        self.contents = (id)[self.originalImage CGImage];
    }
    return self;
}

@end
