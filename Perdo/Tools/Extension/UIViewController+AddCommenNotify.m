//
//  UIViewController+MSAddKeyBoardNotify.m
//  MusicShell
//
//  Created by 郭志远 on 2018/4/23.
//  Copyright © 2018年 Ruitu. All rights reserved.
//

#import "UIViewController+AddCommenNotify.h"
#import <objc/runtime.h>
#import "PhoneLoginViewController.h"
#import "MainNavController.h"

//#import <KsyzVerify/KsyzVerify.h>
//#import <KsyzVerify/KSYZSDKHelpExt.h>
//#import <KsyzVerify/KSYZSDKLoginManager.h>


@implementation UIViewController (AddCommenNotify)

+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController{
    return  viewController == [self findCurrentShowViewControllerFromViewController:PDAppDelegate.window.rootViewController];
}

+ (UIViewController *)findCurrentShowViewControllerFromViewController:(UIViewController *)fromVC{
    if ([fromVC isKindOfClass:[UINavigationController class]]) {
        return [self findCurrentShowViewControllerFromViewController:[((UINavigationController *)fromVC) visibleViewController]];
    } else if ([fromVC isKindOfClass:[UITabBarController class]]) {
        return [self findCurrentShowViewControllerFromViewController:[((UITabBarController *)fromVC) selectedViewController]];
    } else {
        if (fromVC.presentedViewController) {
            return [self findCurrentShowViewControllerFromViewController:fromVC.presentedViewController];
        } else {
            return fromVC;
        }
    }
}

- (void)presentLoginVc{
    PhoneLoginViewController *vc = [[PhoneLoginViewController alloc] init];
    MainNavController *navVc = [[MainNavController alloc] initWithRootViewController:vc];
    navVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navVc animated:YES completion:nil];
}

- (void)configUserDidLoginBlock:(userDidLoginBlock)didLoginBlock{
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSNotification_LoginSuccess object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        if (didLoginBlock) {
            didLoginBlock();
        }
    }];
}

- (void)showActionSheetWithTitle:(NSString *)title detailMessage:(NSString *)message otherBtnTitles:(NSArray *)titles otherClick:(void(^)(int index))click{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (titles.count) {
        for (int i = 0; i<titles.count; i++) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (click) {
                    click(i);
                }
            }];
             [alertVc addAction:otherAction];
        }
    }
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVc addAction:cancelBtn];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)addKeyBoardNotify{
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.isKeyAppear = YES;
    }];
    
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillHideNotification object:nil]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.isKeyAppear = NO;
    }];
}


- (void)addKeyBoardNotifyWithBottomView:(CGRect)targetViewFrame{
    @weakify(self);
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        CGRect beginFrame = [x.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        if (CGRectGetMaxY(targetViewFrame) > beginFrame.origin.y) {
            CGFloat detalY = ABS(CGRectGetMaxY(targetViewFrame) - beginFrame.origin.y);
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(0, -detalY);
            }];
        }
    }];
    
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillHideNotification object:nil]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)setIsKeyAppear:(BOOL)isKeyAppear{
    objc_setAssociatedObject(self, @selector(isKeyAppear), @(isKeyAppear), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isKeyAppear{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsleftBackDisappear:(BOOL)isleftBackDisappear{
    objc_setAssociatedObject(self, @selector(isleftBackDisappear), @(isleftBackDisappear), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isleftBackDisappear{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}


- (int)popIndex{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

- (void)setPopIndex:(int)popIndex{
    objc_setAssociatedObject(self, @selector(popIndex), @(popIndex), OBJC_ASSOCIATION_ASSIGN);
}


- (UIImage *)backImage{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBackImage:(UIImage *)backImage{
     objc_setAssociatedObject(self, @selector(backImage), backImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//-(void)oneKeyLoginVc{
//    [BEEToast showProgressWithMessage:@""];
//    [KsyzVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
//        [BEEToast dismiss];
//
//        if (!error) {
//            //预取号成功。跳转到一键登录
//
//            KsyzVerifyCustomModel *model = [[KsyzVerifyCustomModel alloc]init];
//            model.currentViewController = self;
//
//            [self customModel:model];
//            [BEETraceManager upLoadEventInfoWithEventId:@"P_BEEPAI0131"];
//
//            [KsyzVerify loginWithModel:model showLoginVc:^{
//
//            } loginBtnClicked:^{
//                [BEETraceManager upLoadEventInfoWithEventId:@"A_BEEPAI0131000333"];
//                [BEEToast showProgressWithMessage:@""];
//            } willHiddenLoading:^{
//
//            } completion:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
//                if (!error) {
//                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                    dic[@"operatorToken"] = resultDic[@"operatorToken"];
//                    dic[@"operator"] = resultDic[@"operatorType"];
//                    dic[@"token"] = resultDic[@"token"];
//                    [BEENetClient getOneKeyLoginWithDic:dic complete:^(id  _Nonnull response) {
//                        BEESuccessToast(@"登录成功");
//                        [MemberInfoModel loginSuccessWithUserInfo:response];
//                        [KsyzVerify finishLoginVc:^{
//                            [BEEToast dismiss];
//                        }];
//                    } fail:^(NSError * _Nonnull error) {
//                        [KsyzVerify finishLoginVc:^{
//                            [BEEToast dismiss];
//                        }];
//                        [BEEToast showOtherFailWithMessage:@"登录失败，请重试"];
//                    }];
//                }else{
//
//                    if (error.code == 170602 || error.code == 170204) {
//
//                    }else{
//                        if (error.code == 170005) {
//                            [BEEToast showOtherFailWithMessage:@"当前手机无SIM卡，请插入后重试"];
//                        }else if (error.code == 170003){
//                            [BEEToast showOtherFailWithMessage:@"不支持的运营商"];
//                        }else if(error.code == 170601){
//                           [BEEToast showOtherFailWithMessage:@"请打开蜂窝网络"];
//                        }else if(error.code == 170606){
//                           [BEEToast showOtherFailWithMessage:@"获取授权码数量超限"];
//                        }else if (error.code != 170602 && error.code != 170204) {
//                            [BEEToast showOtherFailWithMessage:@"登录失败，请重试"];
//                        }
//                         [KsyzVerify finishLoginVc:^{
//                             [BEEToast dismiss];
//                        }];
//                    }
//
//                }
//            }];
//        }else{
//           //跳转到正常登录注册页
//            [self presentLoginVc];
//        }
//    }];
//}
//
//
//- (void)customModel:(KsyzVerifyCustomModel *)model{
//    model.logoImg = [UIImage imageNamed:@"onekey_logo"];
//
//    model.numberFont = [UIFont boldSystemFontOfSize:21];
//    model.numberColor = UIColorHex(333333);
//
//    model.switchHidden = @(YES);
//
//    model.privacyNormalTextFirst = @"同意";
//    model.privacyNormalTextSecond = @"并使用本机号码登录";
//    model.privacyAppName = @"";
//    model.privacyNormalTextThird = @"";
//    model.privacyTextColor = UIColorHex(999999);
//    model.privacyTextFont = [UIFont systemFontOfSize:12];
//    model.privacyTextAlignment = @(NSTextAlignmentCenter);
//    model.privacyAgreementColor = UIColorHex(333333);
//
//    model.checkedImg = [UIImage imageNamed:@"onekey_selected"];
//    model.uncheckedImg = [UIImage imageNamed:@"onekey_unselected"];
//    model.checkSize = [NSValue valueWithCGSize:CGSizeMake(14, 14)];
//    model.checkHidden = @(NO);
//     NSString *onekeyStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"onekey"];
//    if ([onekeyStr isEqualToString:@"onekey"]) {
//        model.checkDefaultState = @(YES);
//    }else{
//         model.checkDefaultState = @(NO);
//        [[NSUserDefaults standardUserDefaults] setObject:@"onekey" forKey:@"onekey"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//
//    model.navBarHidden = @(YES);
//
//    model.loginBtnText = @"本机一键登录";
//    model.loginBtnTextColor = UIColorHex(333333);
//    model.loginBtnTextFont = [UIFont systemFontOfSize:16];
//    model.loginBtnBgImgArr = @[[UIImage imageNamed:@"onekey_btn"],[UIImage imageNamed:@"onekey_btn"],[UIImage imageNamed:@"onekey_btn"]];
//
//    model.sloganTextColor = UIColorHex(cccccc);
//    model.sloganTextFont = [UIFont systemFontOfSize:12];
//
//    model.manualDismiss = @(YES);
//    model.hiddenLoading = @(YES);
//
//    KsyzVerifyCustomLayouts *layouts = nil;
//    if (!model.portraitLayouts) {
//        layouts = [[KsyzVerifyCustomLayouts alloc] init];
//    }else {
//        layouts = model.portraitLayouts;
//    }
//
//    //布局
//    //logo 距离上边距离
//    float topHeight = 89 +kStatusBarHeight;
//    if (!layouts.logoLayout) {
//        KsyzVerifyLayout *layout = [[KsyzVerifyLayout alloc] init];
//        layout.layoutTop = @(topHeight);
//        layout.layoutCenterX = @(0);
//        layout.layoutWidth = @(82);
//        layout.layoutHeight = @(82);
//        layouts.logoLayout = layout;
//    }
//
//    //phone
//
//    if (!layouts.phoneLayout) {
//        KsyzVerifyLayout *layout = [[KsyzVerifyLayout alloc] init];
//        layout.layoutTop = @(topHeight + 104);
//        layout.layoutHeight = @(20);
//        layout.layoutCenterX = @(0);
//        layouts.phoneLayout = layout;
//    }
//
//    //登录按钮
//    if (!layouts.loginLayout) {
//        KsyzVerifyLayout *layout = [[KsyzVerifyLayout alloc] init];
//        layout.layoutTop = @(topHeight + 170);
//        layout.layoutCenterX = @(0);
//        layout.layoutWidth = @(kScreenWidth -48);
//        layout.layoutHeight = @(44);
//        layouts.loginLayout = layout;
//    }
//
//    //其他方式登录
//    if (!layouts.switchLayout) {
//        KsyzVerifyLayout *layout = [[KsyzVerifyLayout alloc] init];
//        layout.layoutTop = @(topHeight + 236);
//        layout.layoutCenterX = @(0);
//        layout.layoutHeight = @(17);
//        layouts.switchLayout = layout;
//    }
//
//    if (!layouts.checkPrivacyLayout) {
//        KsyzVerifyCheckPrivacyLayout *layout = [[KsyzVerifyCheckPrivacyLayout alloc] init];
//        layout.layoutCenterY = @(0);
//        layout.layoutRight = @(-2);
//        layout.layoutWidth = @(14);
//        layout.layoutHeight = @(14);
//        layouts.checkPrivacyLayout = layout;
//    }
//
//    //隐私条款
//    if (!layouts.privacyLayout) {
//        KsyzVerifyLayout *layout = [[KsyzVerifyLayout alloc] init];
//        layout.layoutCenterX = @(0);
//        layout.layoutBottom = @(-40 -(kTabBarHeight-49));
//        layout.layoutHeight = @(17);
//        layouts.privacyLayout = layout;
//    }
//     //运营商品牌
//    if (!layouts.sloganLayout) {
//        KsyzVerifyLayout *layout = [[KsyzVerifyLayout alloc] init];
//        layout.layoutBottom = @(-15-(kTabBarHeight-49));
//        layout.layoutHeight = @(17);
//        layout.layoutCenterX = @(0);
//        layouts.sloganLayout = layout;
//    }
//
//    model.portraitLayouts = layouts;
//
//    [model setHasNotSelectedCheckViewBlock:^(UIView *checkView) {
//        [BEEToast showSuccessWithMessage:@"请同意认证服务协议"];
//    }];
//
//    [model setCustomViewBlock:^(UIView *customView) {
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backBtn setImage:[UIImage imageNamed:@"onekey_back"] forState:UIControlStateNormal];
//        [customView addSubview:backBtn];
//        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(kStatusBarHeight+25);
//            make.left.mas_equalTo(38);
//        }];
//        [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            [BEETraceManager upLoadEventInfoWithEventId:@"A_BEEPAI0131000332"];
//            [KsyzVerify finishLoginVc:^{
//            }];
//        }];
//
//        UIButton *otherLogin = [UIButton buttonWithType:UIButtonTypeCustom];
//        [otherLogin setImage:[UIImage imageNamed:@"logisitics_right"] forState:UIControlStateNormal];
//        [otherLogin setTitle:@"其他方式登录 " forState:UIControlStateNormal];
//        [otherLogin setTitleColor:UIColorHex(666666) forState:UIControlStateNormal];
//        [otherLogin.titleLabel setFont:[UIFont systemFontOfSize:12]];
//        [customView addSubview:otherLogin];
//        [otherLogin mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(topHeight + 234);
//            make.height.mas_equalTo(20);
//            make.centerX.mas_equalTo(customView);
//        }];
//        [otherLogin setTitleEdgeInsets:UIEdgeInsetsMake(0, - otherLogin.imageView.image.size.width, 0, otherLogin.imageView.image.size.width)];
//        [otherLogin setImageEdgeInsets:UIEdgeInsetsMake(0, otherLogin.titleLabel.bounds.size.width, 0, -otherLogin.titleLabel.bounds.size.width)];
//
//        [[otherLogin rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//            [BEETraceManager upLoadEventInfoWithEventId:@"A_BEEPAI0131000334"];
//            [KsyzVerify finishLoginVc:^{
//            }];
//            //跳转到正常登录注册页
//            [self presentLoginVc];
//
//        }];
//    }];
//
//}


@end
