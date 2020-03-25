//
//  AuthCodeView.m
//  BeePai
//
//  Created by beice on 2019/1/5.
//  Copyright © 2019 BeePlay. All rights reserved.
//

#import "AuthCodeView.h"
//#import "GameTools.h"

@interface AuthCodeView ()

@property(nonatomic,assign,readwrite) __block AuthCodeState authCodeState;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) __block NSInteger iTime;

@end

@implementation AuthCodeView

- (void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBaseView];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createBaseView];
    }
    return self;
}

- (void)createBaseView{

    [self setTitleColor:UIColor_333333 forState:UIControlStateNormal];
    
    [self setTitleColor:UIColor_333333 forState:UIControlStateDisabled];
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.authCodeState = AuthCodeState_Send;
    [self addTarget:self action:@selector(didPressedSend:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reCreateBaseView{
    if (self.type == 2) {
        [self setTitleColor:UIColor_FF3339 forState:UIControlStateNormal];
        [self setTitleColor:UIColor_FF3339 forState:UIControlStateDisabled];
    }else{
        [self setTitleColor:UIColor_333333 forState:UIControlStateNormal];
        [self setTitleColor:UIColor_999999 forState:UIControlStateDisabled];
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.authCodeState = AuthCodeState_Send;
    [self addTarget:self action:@selector(didPressedSend:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - get/set
- (void)setAuthCodeState:(AuthCodeState)authCodeState{
    _authCodeState = authCodeState;
    switch (_authCodeState) {
        case AuthCodeState_Send:{
            self.enabled = YES;
            [self setTitle:@"获取验证码" forState:UIControlStateNormal];
//            [self setTitleColor:UIColor_333333 forState:UIControlStateNormal];
            if (self.type == 2) {
                [self setTitleColor:UIColor_FF3339 forState:UIControlStateNormal];
            }else{
                [self setTitleColor:UIColor_333333 forState:UIControlStateNormal];
            }

        }break;
        case AuthCodeState_Time:{
            self.enabled = NO;
            [self setTitle:@"60s" forState:UIControlStateNormal];
//            [self setTitleColor:UIColor_999999 forState:UIControlStateDisabled];
            if (self.type == 2) {
                [self setTitleColor:UIColor_FF3339 forState:UIControlStateNormal];
            }else{
                [self setTitleColor:UIColor_999999 forState:UIControlStateNormal];
            }
            [self countDown];
        }break;
        case AuthCodeState_Resend:{
            self.enabled = YES;
            [self setTitle:@"重新获取" forState:UIControlStateNormal];
//            [self setTitleColor:UIColor_333333 forState:UIControlStateNormal];
            if (self.type == 2) {
                [self setTitleColor:UIColor_FF3339 forState:UIControlStateNormal];
            }else{
                [self setTitleColor:UIColor_333333 forState:UIControlStateNormal];
            }
        }break;
        default:
            break;
    }
    if (_timer && _authCodeState != AuthCodeState_Time) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)setPhone:(NSString *)phone{
    _phone = phone;
    if (self.authCodeState == AuthCodeState_Time) {
        return;
    }
    self.enabled = (_phone.length == 11);
}

#pragma mark - event
- (void)didPressedSend:(id)sender{
    if (_authCodeState == AuthCodeState_Send || _authCodeState == AuthCodeState_Resend) {
//        [BEEToast showProgressWithMessage:@"正在发送..."];
        if (self.type == 1) {
//            [BEENetClient postBindWxSmsCode:@{@"mobile":_phone} complete:^(id  _Nonnull response) {
//                [BEEToast dismiss];
//                self.authCodeState = AuthCodeState_Time;
//            }];
            return;
        }
        if (self.type == 2) {
//            [BEENetClient sendMessageWithPhone:_phone complete:^(id  _Nonnull response) {
//                [BEEToast dismiss];
//                self.authCodeState = AuthCodeState_Time;
//            }];
            return;
        }
//        [BEETraceManager upLoadEventInfoWithEventId:@"A_BEEPAI0023000094" eventContent:nil];
//        [BEENetClient postUserLoginsSmsCode:@{@"mobile":_phone} complete:^(id  _Nonnull response) {
//            [BEEToast dismiss];
//            self.authCodeState = AuthCodeState_Time;
//        }failure:^{
//            if (self.userBindWxBlock) {
//                self.userBindWxBlock();
//            }
//        }];
    }
}

#pragma mark - private
- (void)countDown{
    _iTime = 60;
    if (!_timer) {
        @weakify(self);
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            @strongify(self);
            self.iTime--;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%zds",self.iTime] forState:UIControlStateDisabled];
            });
            if (self.iTime <= 0) {
                self.authCodeState = AuthCodeState_Resend;
            }
        } repeats:YES];
    }
    [_timer fire];
}

@end
 
