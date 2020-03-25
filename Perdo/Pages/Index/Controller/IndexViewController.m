//
//  IndexViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/23.
//  Copyright © 2020 一招. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorHex(ee5200);
//   self.fd_prefersNavigationBarHidden = YES;

    self.title = @"首页";
    
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSNotification_LogoutSuccess object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
           @strongify(self);
//            [self getFirstData];
       }];
    JudgeIsLogin;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
