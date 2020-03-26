//
//  APPHelper.h
//  BeePai
//
//  Created by jdd on 2019/6/10.
//  Copyright © 2019 BeePlay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,RoleType){
    RoleTypeStudent = 1,
    RoleTypeTeacher = 2
};


@interface APPHelper : NSObject


#pragma mark --DateFormatters
@property(strong,nonatomic)  NSDateFormatter * dateFormatter_typeOne;//yyyy-MM-dd HH:mm
@property(strong,nonatomic)  NSDateFormatter * dateFormatter_typeTwo;//yyyy-MM-dd HH:mm:ss
@property(strong,nonatomic)  NSDateFormatter * dateFormatter_typeThree;//HH:mm
@property(strong,nonatomic)  NSDateFormatter * dateFormatter_typeFour;//yyyy-MM-dd
@property(strong,nonatomic)  NSDateFormatter * dateFormatter_typeFive;//MM-dd HH:mm
@property(strong,nonatomic)  NSDateFormatter * dateFormatter_typeSix;//MM-dd
@property(strong,nonatomic)  NSDateFormatter * dateFormatter_typeSeven;//yyyyMMddHHmmss


+(instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
