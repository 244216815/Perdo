//
//  RoleChoicesViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/25.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "RoleChoicesViewController.h"
#import "StudentViewController.h"
#import "TeacherViewController.h"

@interface RoleChoicesViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logOut;

@end

@implementation RoleChoicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self configNotification];

}

- (void)configNotification{
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSNotification_LoginSuccess object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)studentAction:(id)sender {
    StudentViewController *vc = [[StudentViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)teacherAction:(id)sender {
    TeacherViewController *vc = [[TeacherViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)logOutAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
