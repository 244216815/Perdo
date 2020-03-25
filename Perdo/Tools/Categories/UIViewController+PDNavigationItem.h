//
//  MainTabBarController.m
//  Perdo
//
//  Created by 一招 on 2020/3/23.
//  Copyright © 2020 一招. All rights reserved.
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NavigationItemType) {
    
    //以下是枚举成员
    NavigationItemTypeLeft = 0,
    NavigationItemTypeRight = 1,
};
@protocol NavigationItemTypeProtocal <NSObject>

@optional
-(void)leftItemAction;
-(void)rightItemAction;
-(void)backItemAction;
@end

@interface UIViewController(PDNavigationItem)<NavigationItemTypeProtocal>

-(void)configNavigationBackItem;
-(void)configNavigationBackBlackItem;
-(void)configNavigationCloseItem;
-(void)configNavigationBlackCloseItem;
- (void)configNavigationCloseImageItem;
-(void)configNavigationWitImageName:(NSArray<UIImage *> *)images action:(SEL)action type:(NavigationItemType)type;
-(void)configNavigationWithTitle:(NSString *)title imageName:(NSString *)imageName action:(SEL)action type:(NavigationItemType)type fontSize:(CGFloat)size;

-(void)configNavigationWitImageName:(UIImage *)image action:(SEL)action type:(NavigationItemType)type messageNum:(NSString *)num;

-(UILabel *)configMessageWitImageName:(UIImage *)image targetView:(UIView *)targetView action:(SEL)action type:(NavigationItemType)type messageNum:(NSString *)num;
//建议使用下面
//titles:名称 images:图片 actions:SEL数组 fontSize：0 为默认
//例子：SEL action[2] = {@selector(moreButtonOnClick:),@selector(baskekBallSelectMatchesBtnClick:)};
-(void)configNavTitles:(NSArray<NSString *> *)titles imageNames:(NSArray<NSString *> *)images actions:(NSArray<NSString *> *)actionNames type:(NavigationItemType)type fontSize:(CGFloat)size;



@end

NS_ASSUME_NONNULL_END
