//
//  MemberInfoModel.m
//  Perdo
//
//  Created by Perdo on 2020/3/24.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "MemberInfoModel.h"
//#import "InviteCodeModel.h"

static long userBegginerTime;


@implementation MemberInfoModel

+ (BOOL)isLogin{
    return (((NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:Default_Token]).length > 0);
}

+ (NSString *)nickname{
    return ((NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:Default_Nickname]);
}

+ (NSString *)accessToken{
    return ((NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:Default_Token]);
}
+ (NSString *)userId{
    return ((NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:Default_UserId]);
}

+ (NSArray *)userRewardsData{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] valueForKey:Default_userRewardsData]];
}

+ (NSArray *)userRewardsImages{
    return [[NSUserDefaults standardUserDefaults] valueForKey:Default_awardsImages];
}

+ (NSString *)awardsTitle{
    return ((NSString *)[[NSUserDefaults standardUserDefaults]objectForKey: Default_awardsTitle]);
}

+ (NSString *)awardsSubtitle{
    return ((NSString *)[[NSUserDefaults standardUserDefaults]objectForKey: Default_awardsSubtitle]);
}



+ (UserInfoModel *)userInfoModel{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] valueForKey:Default_userInfo]];
}

+ (NSString *)inviteCode{
     return [[NSUserDefaults standardUserDefaults] valueForKey:Default_userInviteCode];
}

//+ (BOOL)takeShareRewardsStatus{
//    return [[NSUserDefaults standardUserDefaults] boolForKey:Default_takeShareRewardsStatus];
//}

//+ (void)finishTakeShareRewardsStatus{
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Default_takeShareRewardsStatus];
//}

+ (void)recordHomePageRewardsViewShowTime{
     [[NSUserDefaults standardUserDefaults] setDouble:[[NSDate date] timeIntervalSince1970] forKey:Default_homePageRewardsViewShowTime];
}

+ (BOOL)isShowHomePageRewardsView{
    NSTimeInterval showRewardsTime = [[NSUserDefaults standardUserDefaults] doubleForKey:Default_homePageRewardsViewShowTime];
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    return (currentTime - showRewardsTime > 86400);
}


//+ (void)recordAcutionShareClickTime{
//    [[NSUserDefaults standardUserDefaults] setDouble:[[NSDate date] timeIntervalSince1970] forKey:acutionShareClickTime];
//}
//
//+ (BOOL)isShowAcutionShareView{
//    return ![[NSDate dateWithTimeIntervalSince1970:[[NSUserDefaults standardUserDefaults] doubleForKey:acutionShareClickTime]] isToday];
//}
//
//+ (void)recordBeginnerAcutionBackNotifyClickTime{
//    [[NSUserDefaults standardUserDefaults] setDouble:[[NSDate date] timeIntervalSince1970] forKey:beginnerAcutionBackNotifyClickTime];
//}
//
//+ (BOOL)isShowBeginnerAcutionBackNotifyView{
//    return ![[NSDate dateWithTimeIntervalSince1970:[[NSUserDefaults standardUserDefaults] doubleForKey:beginnerAcutionBackNotifyClickTime]] isToday];
//}
//
//
//+ (void)recordWebViewCleanWebCacheTime{
//    [[NSUserDefaults standardUserDefaults] setDouble:[[NSDate date] timeIntervalSince1970] forKey:webViewCleanWebCacheTime];
//}
//
//+ (BOOL)isShouldCleanWebCache{
//    return ![[NSDate dateWithTimeIntervalSince1970:[[NSUserDefaults standardUserDefaults] doubleForKey:webViewCleanWebCacheTime]] isToday];
//}

+ (long)userBeginnerSeconds{
    return userBegginerTime;
}

+ (void)setUserBeginnerSeconds:(long)seconds{
    userBegginerTime = seconds;
}

/**
 设置用户信息
 */
+ (void)loginSuccessWithUserInfo:(NSDictionary *)dict{
    if (!dict) {
        return;
    }
    NSLog(@"%@",dict);
    NSString *expireSeconds = dict[@"expireSeconds"];
    [NSUserDefaults.standardUserDefaults setObject:expireSeconds forKey:Default_expireSeconds];
    NSString *userID = dict[@"userId"]?[NSString stringWithFormat:@"%@",dict[@"userId"]]:nil;
    [NSUserDefaults.standardUserDefaults setObject:userID forKey:Default_UserId];
    NSString *accessToken = dict[@"token"];
    [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:Default_Token];
    [[NSUserDefaults standardUserDefaults] setDouble:[[NSDate date] timeIntervalSince1970] forKey:Default_userLoginTime];
    NSArray *rewards = [NSArray modelArrayWithClass:[UserRewardsModel class] json:checkIsNsNull(dict[@"awardsData"])];
    if (rewards.count) {
        NSData *rewardsData = [NSKeyedArchiver archivedDataWithRootObject:rewards];
        [[NSUserDefaults standardUserDefaults] setValue:rewardsData forKey:Default_userRewardsData];
    }
    NSArray *rewardsImages = checkIsNsNull(dict[@"awardsImg"]);
    if (rewardsImages.count) {
        [[NSUserDefaults standardUserDefaults] setValue:rewardsImages forKey:Default_awardsImages];
    }
    if (!IsEmpty(dict[@"awardsTitle"])) {
        NSString *awardsTitle = dict[@"awardsTitle"];
        [[NSUserDefaults standardUserDefaults] setValue:awardsTitle forKey:Default_awardsTitle];
    }
    if (!IsEmpty(dict[@"awardsSubtitle"])) {
        NSString *awardsSubtitle = dict[@"awardsSubtitle"];
        [[NSUserDefaults standardUserDefaults] setObject:awardsSubtitle forKey:Default_awardsSubtitle];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotification_LoginSuccess object:nil];
    NSLog(@"++++++++登陆成功+++++++++%@+++++++++%@",MemberInfoModel.userId,MemberInfoModel.accessToken);
//    [BEENetClient getPlatformUserInfoWithcomplete:^(id  _Nonnull response) {
//    }];
//    [BEENetClient getInviteCodeInfoWithComplete:^(id  _Nonnull response) {
//        InviteCodeModel *inviteModel = [InviteCodeModel modelWithDictionary:response];
//        [[NSUserDefaults standardUserDefaults] setValue:inviteModel.inviteCode forKey:Default_userInviteCode];
//    }];
}


+ (void)logout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_expireSeconds];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_UserId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_Token];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_Nickname];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_userLoginTime];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_takeShareRewardsStatus];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_userInfo];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:isTakeBegginerRewards];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_userRewardsData];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_userInviteCode];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_awardsTitle];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_awardsSubtitle];
    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotification_LogoutSuccess object:nil];
}

+ (void)userSelfLogout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_expireSeconds];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_UserId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_Token];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_Nickname];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_userLoginTime];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_userInfo];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:isTakeBegginerRewards];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_takeShareRewardsStatus];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_userRewardsData];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_userInviteCode];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_awardsTitle];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Default_awardsSubtitle];
    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotification_UserSelfLogoutSuccess object:nil];
}

+ (void)updateUserInfoWithUserInfo:(id)info{
    UserInfoModel *infoModel = [UserInfoModel modelWithDictionary:info];
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:infoModel];
    [[NSUserDefaults standardUserDefaults] setValue:userData forKey:Default_userInfo];
}

+ (void)refreshUserLoginToken{
    if (!MemberInfoModel.isLogin) {
        return;
    }
   NSTimeInterval userLoginTime = [[NSUserDefaults standardUserDefaults] doubleForKey:Default_userLoginTime];
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval userTokenExpireTime = [[[NSUserDefaults standardUserDefaults] valueForKey:Default_expireSeconds] longValue];
    if ((currentTime - userLoginTime)<(userTokenExpireTime-24*3600)) {
//         [BEENetClient updateUserTokenWithcomplete:^(id  _Nonnull response) {
//             NSString *expireSeconds = response[@"expireSeconds"];
//             [NSUserDefaults.standardUserDefaults setObject:expireSeconds forKey:Default_expireSeconds];
//             NSString *userID = response[@"userId"]?[NSString stringWithFormat:@"%@",response[@"userId"]]:nil;
//             [NSUserDefaults.standardUserDefaults setObject:userID forKey:Default_UserId];
//             NSString *accessToken = response[@"token"];
//             [[NSUserDefaults standardUserDefaults]setObject:checkIsNsNull(accessToken) forKey:Default_Token];
//             [[NSUserDefaults standardUserDefaults] setDouble:[[NSDate date] timeIntervalSince1970] forKey:Default_userLoginTime];
//             [[NSUserDefaults standardUserDefaults]synchronize];
//         }];
    }
}

@end


@implementation UserInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
      [self modelInitWithCoder:aDecoder];
    }
    return self;
}

- (NSString *)accessToken{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:Default_Token];
}
- (NSString *)id{
    return [[NSUserDefaults standardUserDefaults] objectForKey:Default_UserId];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"fragments" : [UserFragmentInfo class]
             };
}

@end

@implementation UserRewardsModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self modelInitWithCoder:aDecoder];
    }
    return self;
}

@end

@implementation UserFragmentInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self modelInitWithCoder:aDecoder];
    }
    return self;
}

@end
