//
//  UIViewController+MSAddKeyBoardNotify.h
//  MusicShell
//
//  Created by 郭志远 on 2018/4/23.
//  Copyright © 2018年 Ruitu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^userDidLoginBlock)(void);

@interface UIViewController (AddCommenNotify)

@property (nonatomic ,assign)BOOL isKeyAppear;
@property (nonatomic ,assign)BOOL isleftBackDisappear;
@property (nonatomic ,assign)int popIndex;
@property (nonatomic ,strong)UIImage *backImage;

//@property (nonatomic ,assign)BOOL isOneKeyLogin;


- (void)presentLoginVc;
- (void)addKeyBoardNotify;
- (void)configUserDidLoginBlock:(userDidLoginBlock)didLoginBlock;
- (void)addKeyBoardNotifyWithBottomView:(CGRect)targetViewFrame;
- (void)showActionSheetWithTitle:(NSString *)title detailMessage:(NSString *)message otherBtnTitles:(NSArray *)titles otherClick:(void(^)(int index))click;

+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

- (void)oneKeyLoginVc;

@end
