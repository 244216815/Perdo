//
//  MemberInfoModel.h
//  Perdo
//
//  Created by Perdo on 2020/3/24.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*NSNotification*/
static NSString *const NSNotification_LoginSuccess = @"LoginSuccess";
static NSString *const NSNotification_LogoutSuccess = @"LogoutSuccess";
static NSString *const NSNotification_UserSelfLogoutSuccess = @"UserSelfLogoutSuccess";
/*NSUserDefaults*/
static NSString *const Default_UserId= @"user_id";
static NSString *const Default_Nickname = @"user_nickname";
static NSString *const Default_Token = @"accessToken";
static NSString *const Default_userInfo = @"kuserInfoModel";
static NSString *const Default_userLoginTime = @"userLoginTime";
static NSString *const Default_expireSeconds = @"expireSeconds";
//static NSString *const Default_takeShareRewardsStatus= @"takeShareRewardsStatus";
static NSString *const Default_userRewardsData = @"Default_userRewardsData";
static NSString *const Default_homePageRewardsViewShowTime = @"Default_homePageRewardsViewShowTime";
static NSString *const Default_userInviteCode = @"Default_userInviteCode";

static NSString *const Default_awardsTitle = @"Default_awardsTitle";
static NSString *const Default_awardsSubtitle = @"Default_awardsSubtitle";
static NSString *const Default_awardsImages = @"Default_awardsImages";

@interface UserFragmentInfo : NSObject

@property (nonatomic ,assign)float fragmentBalance;
@property (nonatomic ,assign)int fragmentId;

@end

@interface UserInfoModel : NSObject

@property (nonatomic ,copy)NSString *nickName;
@property (nonatomic ,copy)NSString *head;
@property (nonatomic ,assign)int amount;
@property (nonatomic ,copy)NSString *userId;
@property (nonatomic ,assign)BOOL premiumUser;
@property (nonatomic ,copy)NSString *sourceNickname;
@property (nonatomic ,copy)NSString *thirdHeadImg;
@property (nonatomic ,assign)int userSource;
@property (nonatomic ,assign)int recharge;
@property (nonatomic ,copy)NSString *groupId;
@property (nonatomic ,assign)BOOL visitor;
@property (nonatomic ,assign)int balance;
@property (nonatomic ,assign)long coinNum;
@property (nonatomic ,assign)long voucherNum;
@property (nonatomic ,copy)NSString *currentAuctionId;
@property (nonatomic ,copy)NSString *headImg;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *id;
@property (nonatomic ,strong)NSArray <UserFragmentInfo *>*fragments;
@property (nonatomic ,assign)BOOL beginner;
@property (nonatomic ,assign)int beginnerPrizeNums;
@property (nonatomic ,assign)BOOL takeStatus;
@property (nonatomic ,copy)NSString *awardsTitle;
@property (nonatomic ,copy)NSString *awardsSubtitle;
@end

@interface UserRewardsModel : NSObject

@property (nonatomic ,assign)int awardNum;
@property (nonatomic ,copy)NSString *awardType;
@property (nonatomic ,copy)NSString *subhead;
@property (nonatomic ,copy)NSString *title;

@end



@interface MemberInfoModel : NSObject

+ (BOOL)isLogin;
+ (NSString *)nickname;
+ (NSString *)accessToken;
+ (UserInfoModel *)userInfoModel;
+ (NSArray *)userRewardsData;
+ (NSArray *)userRewardsImages;
+ (NSString *)awardsTitle;
+ (NSString *)awardsSubtitle;
+ (void)refreshUserLoginToken;
+ (NSString *)userId;
//+ (BOOL)takeShareRewardsStatus;
//+ (void)finishTakeShareRewardsStatus;
+ (long)userBeginnerSeconds;
+ (void)setUserBeginnerSeconds:(long)seconds;
+ (NSString *)inviteCode;
/**
 设置用户信息
 */
+ (void)loginSuccessWithUserInfo:(NSDictionary *)dict;

+ (void)updateUserInfoWithUserInfo:(id)info;

+ (void)logout;

+ (void)userSelfLogout;

+ (void)recordHomePageRewardsViewShowTime;

+ (BOOL)isShowHomePageRewardsView;

+ (BOOL)isShowAcutionShareView;

+ (void)recordAcutionShareClickTime;

+ (void)recordBeginnerAcutionBackNotifyClickTime;

+ (BOOL)isShowBeginnerAcutionBackNotifyView;

+ (void)recordWebViewCleanWebCacheTime;

+ (BOOL)isShouldCleanWebCache;

@end

NS_ASSUME_NONNULL_END
