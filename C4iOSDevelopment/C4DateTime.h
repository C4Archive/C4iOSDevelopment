//
//  C4DateTime.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-11-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"

@interface C4DateTime : C4Object {
}

#pragma mark Singleton
+(C4DateTime *)sharedManager;

#pragma mark Date & Time
+(NSInteger)day;
+(NSString *)dayString;
+(NSString *)daySuffix;
+(NSInteger)hour;
+(NSString *)hourString;
+(NSInteger)minute;
+(NSString *)minuteString;
+(NSInteger)week;
+(NSString *)weekString;
+(NSInteger)month;
+(NSInteger)millis;
+(NSString *)monthString;
+(NSInteger)second;
+(NSString *)secondString;
+(NSInteger)year;
+(NSInteger)weekday;
+(NSString *)weekdayString;
+(NSString *)dayName;
+(NSString *)monthName;

-(NSString *)dayName;
-(NSString *)monthName;

-(NSInteger)day;
-(NSString *)dayString;
-(NSString *)daySuffix;
-(NSInteger)hour;
-(NSString *)hourString;
-(NSInteger)minute;
-(NSString *)minuteString;
-(NSInteger)week;
-(NSString *)weekString;
-(NSInteger)month;
-(NSString *)monthString;
-(NSInteger)millis;

-(NSInteger)second;
-(NSString *)secondString;
-(NSInteger)year;

-(NSInteger)weekday;
-(NSString *)weekdayString;

@property(readonly, strong) NSCalendar *gregorian;

@end