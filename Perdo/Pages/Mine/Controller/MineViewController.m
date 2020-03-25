//
//  MineViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/23.
//  Copyright © 2020 一招. All rights reserved.
//

#import "MineViewController.h"
#import "PhoneLoginViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorHex(ffffee);
    
    self.fd_prefersNavigationBarHidden = YES;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];


}


-(void)clickBtn{
    PhoneLoginViewController *vc = [[PhoneLoginViewController alloc]init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
//    [self presentLoginVc];
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
