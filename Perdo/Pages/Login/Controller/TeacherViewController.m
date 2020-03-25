//
//  TeacherViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/25.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "TeacherViewController.h"
#import "IndexViewController.h"

@interface TeacherViewController ()

@property (weak, nonatomic) IBOutlet UIButton *teacherBtn1;
@property (weak, nonatomic) IBOutlet UIButton *teacherBtn2;
@property (weak, nonatomic) IBOutlet UIButton *teacherBtn3;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"完善基础信息";
    self.sureBtn.enabled = NO;
    
}

- (IBAction)teacherAction1:(id)sender {
    
    self.teacherBtn2.selected = self.teacherBtn3.selected = NO;
    self.sureBtn.enabled = YES;
    self.teacherBtn1.selected = YES;
    
}


- (IBAction)teacherAction2:(id)sender {
    
    self.teacherBtn1.selected = self.teacherBtn3.selected = NO;
       self.sureBtn.enabled = YES;
     self.teacherBtn2.selected = YES;
    
       
}

- (IBAction)teacherAction3:(id)sender {
    self.teacherBtn1.selected = self.teacherBtn2.selected = NO;
       self.sureBtn.enabled = YES;
     self.teacherBtn3.selected = YES;
       
    
}
- (IBAction)sureAction:(id)sender {
    
    IndexViewController *vc = [[IndexViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
