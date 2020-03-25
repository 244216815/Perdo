//
//  NSArray+CheckSP.m
//  jdd
//
//  Created by 姚凤 on 2017/2/22.
//
//

#import "NSArray+CheckSP.h"

@implementation NSArray (CheckSP)

- (NSString *)safeObjectAtIndex:(int)index{
     
     if (index >= [self count]) {
          return @"";
     }
     id value = [self objectAtIndex:index];
     if (![value isKindOfClass:[NSString class]]) {
          return [NSString stringWithFormat:@"%@",value];
     }
     return value;
}

@end
