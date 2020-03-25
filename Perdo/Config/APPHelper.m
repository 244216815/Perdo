//
//  APPHelper.m
//  BeePai
//
//  Created by jdd on 2019/6/10.
//  Copyright © 2019 BeePlay. All rights reserved.
//

#import "APPHelper.h"

@implementation APPHelper

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}

#pragma mark --日期相关
-(NSDateFormatter *)dateFormatter_typeOne{
    
    if (!_dateFormatter_typeOne) {
        _dateFormatter_typeOne =[[NSDateFormatter alloc]init];
        [_dateFormatter_typeOne setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
        [_dateFormatter_typeOne setTimeZone:zone];
    }
    return _dateFormatter_typeOne;
}
-(NSDateFormatter *)dateFormatter_typeTwo{
    if (!_dateFormatter_typeTwo) {
        _dateFormatter_typeTwo =[[NSDateFormatter alloc]init];
        [_dateFormatter_typeTwo setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
        [_dateFormatter_typeTwo setTimeZone:zone];
    }
    return _dateFormatter_typeTwo;
    
}
-(NSDateFormatter *)dateFormatter_typeThree{
    if (!_dateFormatter_typeThree) {
        _dateFormatter_typeThree =[[NSDateFormatter alloc]init];
        [_dateFormatter_typeThree setDateFormat:@"HH:mm"];
        NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
        [_dateFormatter_typeThree setTimeZone:zone];
    }
    return _dateFormatter_typeThree;
    
}
-(NSDateFormatter *)dateFormatter_typeFour{
    if (!_dateFormatter_typeFour) {
        _dateFormatter_typeFour =[[NSDateFormatter alloc]init];
        [_dateFormatter_typeFour setDateFormat:@"yyyy-MM-dd"];
        NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
        [_dateFormatter_typeFour setTimeZone:zone];
    }
    return _dateFormatter_typeFour;
    
}
-(NSDateFormatter *)dateFormatter_typeFive{
    
    if (!_dateFormatter_typeFive) {
        _dateFormatter_typeFive =[[NSDateFormatter alloc]init];
        [_dateFormatter_typeFive setDateFormat:@"MM-dd HH:mm"];
        NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
        [_dateFormatter_typeFive setTimeZone:zone];
    }
    return _dateFormatter_typeFive;
    
    
}
-(NSDateFormatter *)dateFormatter_typeSix{
    
    if (!_dateFormatter_typeSix) {
        _dateFormatter_typeSix =[[NSDateFormatter alloc]init];
        [_dateFormatter_typeSix setDateFormat:@"MM-dd"];
        NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
        [_dateFormatter_typeSix setTimeZone:zone];
    }
    return _dateFormatter_typeSix;
    
}
-(NSDateFormatter *)dateFormatter_typeSeven{
    
    if (!_dateFormatter_typeSeven) {
        _dateFormatter_typeSeven =[[NSDateFormatter alloc]init];
        [_dateFormatter_typeSeven setDateFormat:@"yyyyMMddHHmmss"];
        NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
        [_dateFormatter_typeSeven setTimeZone:zone];
    }
    return _dateFormatter_typeSeven;
    
    
}


@end
