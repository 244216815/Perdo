//
//  AuthCodeView.h
//  BeePai
//
//  Created by beice on 2019/1/5.
//  Copyright © 2019 BeePlay. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AuthCodeState) {
    AuthCodeState_Send,//发送验证码
    AuthCodeState_Time,//倒计时
    AuthCodeState_Resend//重新发生验证码
};

typedef void(^userShouldBindWx)(void);

NS_ASSUME_NONNULL_BEGIN

@interface AuthCodeView : UIButton

@property(nonatomic,copy) NSString *phone;
@property(nonatomic,assign,readonly) AuthCodeState authCodeState;
@property (nonatomic ,assign)int type;//0默认登录 1绑定微信  2实名认证
@property (nonatomic ,copy)userShouldBindWx userBindWxBlock;

- (void)reCreateBaseView;

@end

NS_ASSUME_NONNULL_END
