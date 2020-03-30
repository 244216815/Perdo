//
//  CommonMacro.h
//  BeePai
//
//  Created by beice on 2019/1/7.
//  Copyright © 2019 BeePlay. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  判断id是为空
 *
 *  @param thing <#thing description#>
 *
 *  @return <#return value description#>
 */
static inline BOOL IsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]] || ([thing isKindOfClass:[NSString class]] && [thing isEqualToString:@"(null)"])
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

static inline NSString *StringFromObject(id object) {
    if (object == nil || [object isEqual:[NSNull null]]) {
        return @"";
    } else if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object respondsToSelector:@selector(stringValue)]){
        return [object stringValue];
    } else {
        return [object description];
    }
}


//通用
#define PDAppDelegate  [UIApplication sharedApplication].delegate

#define checkImageUrl(str)  [BEENetClient checkImageUrlWithString:str]
#define checkImageStr(str)  [BEENetClient checkImageStrWithString:str]
//APP版本号
#define BEEAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#if DEBUG
//0开发环境 1测试环境 2正式环境
#define currentEnvironment 1
#else
#define currentEnvironment 2
#endif

static NSString * const ChannelStr = (currentEnvironment == 0?@"local":currentEnvironment ==1?@"test":@"app_ios_bp");

//系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define DocumentFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject]

#define UserDefaults ([NSUserDefaults standardUserDefaults])
//状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define kISiPhoneX ((kStatusBarHeight>20)?YES:NO)
//标签栏高度
#define kTabBarHeight (kStatusBarHeight > 20 ? 83 : 49)
//导航栏高度
#define kNavBarHeight (kStatusBarHeight + 44)

//以X的宽高为比例
#define kScale_W(w) ((kScreenWidth)/375) * (w)
#define kScale_H(h) (kScreenHeight/667) * (h)

//安全区高度
#define kSafeAreaBottom (kISiPhoneX ? 34 : 0)

#pragma mark iOS UI
//获取当前screen
#define SCREEN  [ UIScreen mainScreen ].bounds
// 屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width


#define placeholderUserIconImage [UIImage imageNamed:@"defult_no_icon"]

#define placeholderNodataImage [UIImage imageNamed:@"ic_placeholder_error"]

#define commonAnimationSeconds 0.25

#define dismissCurrentVc(targetVc) \
{NSMutableArray *childsVcs = targetVc.navigationController.viewControllers.mutableCopy;\
[childsVcs removeObject:targetVc];\
targetVc.navigationController.viewControllers = childsVcs;\
}

#define NeverAdjustInset(scrollview) \
if (@available(iOS 11.0, *)){\
[scrollview setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];\
}

#define JudgeIsLogin \
if (!MemberInfoModel.isLogin) {\
    [[[UIApplication sharedApplication].delegate window].rootViewController presentLoginVc];\
    return;\
}

#define ChangeTap(index) [(UITabBarController *)PDAppDelegate.window.rootViewController setSelectedIndex:index]


#define checkIsNsNull(str) ([str isKindOfClass:[NSNull class]]||([str isKindOfClass:[NSString class]]&&[str isEqualToString:@""])?nil:str)


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)


#define iPhoneXorXs [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO
#define iPhoneXsMax [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO
#define iPhoneXr [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO

#define is_iPhoneX_Series ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)
