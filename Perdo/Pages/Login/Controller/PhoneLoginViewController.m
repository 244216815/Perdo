//
//  MemberInfoModel.h
//  Perdo
//
//  Created by Perdo on 2020/3/24.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "PhoneLoginViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
//#import "FLLoginService.h"
//#import "BPWebViewController.h"
//#import "WXApi.h"
//#import "PhoneBindViewController.h"
//#import "CustomAlertView.h"
#import <BarrageRenderer/BarrageRenderer.h>
//#import "HomePageBaseModel.h"
//#import "UserConfigModel.h"

@interface PhoneLoginViewController ()<UITextFieldDelegate,BarrageRendererDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnWechat;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCode;
@property (weak, nonatomic) IBOutlet AuthCodeView *authCodeView;
@property (weak, nonatomic) IBOutlet UIView *danmuBackView;
@property (weak, nonatomic) IBOutlet YYLabel *rewardsTextLabel;
@property (weak, nonatomic) IBOutlet ProtocolLabel *protocolBottomLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeBtnTopMargin;
@property (nonatomic ,strong)BarrageRenderer *renderShowSuccessAcution;
@property (nonatomic ,assign)int currentIndex;
@property (nonatomic ,weak)RACDisposable *timeScheduler;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoBottomMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdBtnBottomMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayputMargin;

@end

@implementation PhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
    [self createBaseView];
    [self configNotification];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timeScheduler dispose];
}


- (void)configNotification{
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSNotification_LoginSuccess object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)createBaseView{
    self.topLayputMargin.constant = kStatusBarHeight == 20?96:120;
    self.closeBtnTopMargin.constant = kStatusBarHeight +15;
    self.logoBottomMargin.constant = kScreenHeight<667?40:60;
    self.thirdBtnBottomMargin.constant = kScreenHeight<667?20:44;
    [self bindingSignal];
    @weakify(self);
    self.protocolBottomLabel.ProtocolTapBlock = ^(int index){
        @strongify(self);
//        用户协议 隐私政策
//        BPWebViewController *protoVc = [BPWebViewController new];
//        protoVc.urlStr = index?[BEEH5Configer privacy]:[BEEH5Configer agreement];
//        [self.navigationController pushViewController:protoVc animated:YES];
    };
}

- (void)bindingSignal{
    @weakify(self);
    RACSignal *signalPhone = _textFieldPhone.rac_textSignal;
    RACSignal *signalCode = _textFieldCode.rac_textSignal;
    [[RACSignal combineLatest:@[signalPhone,signalCode]
                       reduce:^id(NSString *phone,NSString *code){
                           @strongify(self);
                           phone = [self updateUserPhone:phone];
                           self.textFieldPhone.text = phone;
                           phone = [self removeBlank:phone];
                           code = [self updateUserCode:code];
                           self.textFieldCode.text = code;
                           return @(phone.length == 11 && code.length == 6);
                       }]subscribeNext:^(id  _Nullable x) {
                           @strongify(self);
                           BOOL isLogin = [x boolValue];
                           if (isLogin) {
                               self.btnLogin.enabled = YES;
                           }
                           else{
                               self.btnLogin.enabled = NO;
                           }
                       }];
    RAC(self.authCodeView,phone) = [_textFieldPhone.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        @strongify(self);
        return [RACReturnSignal return:([self removeBlank:value])];
    }];
}

#pragma mark - event
- (IBAction)didPressedLogin:(id)sender {
//    [BEETraceManager upLoadEventInfoWithEventId:@"A_BEEPAI0023000076" eventContent:nil];
//    BEEProgressToast(@"登录中");
//    [BEENetClient postUserPhoneLogin:@{ @"mobile": [self removeBlank:_textFieldPhone.text],
//                                   @"verifyCode": _textFieldCode.text} complete:^(id  _Nonnull response) {
//
//                                       BEESuccessToast(@"登录成功");
//                                    [MemberInfoModel loginSuccessWithUserInfo:response];
//                                   }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.textFieldPhone) {
        if (string.length > 0) {
            if (textField.text.length % 5 == 3) {
                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
            }
        }
        return YES;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _textFieldPhone) {
        NSString *strTemp = [self removeBlank:textField.text];
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@",strTemp];
        if (str.length >= 3) {
            [str insertString:@" " atIndex:3];
        }
        
        if (str.length >= 8) {
            [str insertString:@" " atIndex:8];
        }
        _textFieldPhone.text = str;
    }
}


#pragma mark - private
- (NSString *)removeBlank:(NSString *)phone{
    return [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)updateUserPhone:(NSString *)phone{
    NSString *currentPhone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (currentPhone.length>11 && phone.length>13) {
      return [phone substringToIndex:13];
    }
    return phone;
}

- (NSString *)updateUserCode:(NSString *)code{
    if (code.length>6) {
        return [code substringToIndex:6];
    }
    return code;
}

@end
