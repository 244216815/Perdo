//
//  IndexViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/26.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexAddTeacherView.h"
#import "IndexAddStudentView.h"

@interface IndexViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewLayout;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *label3;


@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self buildUI];
    [self configNotification];
    
}

- (void)buildUI{
    self.title = @"消息";
    [self configNavigationWitImageName:[NSArray arrayWithObject:[UIImage imageNamed:@"index_add"]] action:@selector(addAction) type:NavigationItemTypeRight];
    
    self.topViewLayout.constant = kStatusBarHeight+16+44;
    
    if (RoleTypeTeacher) {
        self.imageView2.image = [UIImage imageNamed:@"richeng"];
        self.label2.text = @"日程";
        
        self.imageView3.image = [UIImage imageNamed:@"jiaowu"];
        self.label3.text = @"教务";
    }
    
    if (RoleTypeStudent) {
        self.imageView2.image = [UIImage imageNamed:@"cuotiji"];
        self.label2.text = @"错题集";
               
        self.imageView3.image = [UIImage imageNamed:@"qingjia"];
        self.label3.text = @"请假";
    }
 
//    JudgeIsLogin;
}

- (void)configNotification{
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSNotification_LogoutSuccess object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
     
    }];
    
}



- (void)addAction{
    if (RoleTypeTeacher) {
//        IndexAddTeacherView *addTeacherView = [[NSBundle mainBundle]loadNibNamed:@"IndexAddTeacherView" owner:self options:nil].lastObject;
//        addTeacherView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        [addTeacherView setAddActionBlock:^(NSInteger index) {
//            if (index == 1) {
//                //创建群聊
//            }else if (index == 2){
//                //加入学校/班级
//            }else if (index == 3){
//                //创建年级/班级
//
//            }
//        }];
//        [PDAppDelegate.window addSubview:addTeacherView];
        
    }
    
    if (RoleTypeStudent) {
       
        IndexAddStudentView *addStudentView = [[NSBundle mainBundle]loadNibNamed:@"IndexAddStudentView" owner:self options:nil].lastObject;
        addStudentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [addStudentView setAddActionBlock:^(NSInteger index) {
            if (index == 1) {
                //创建群聊
            }else if (index == 2){
                //关联学生

            }
        }];
        [PDAppDelegate.window addSubview:addStudentView];
    }
    
}

- (IBAction)TopBtnAction:(UIButton *)sender {
    NSInteger index = sender.tag - 200;
    if (RoleTypeTeacher) {
        if (index == 1) {//课程表
                 
        }else if (index == 2){//日程
                 
        }else if (index == 3){//教务
                 
        }else if (index == 4){//公告
                 
        }
           
    }
    if (RoleTypeStudent) {
        if (index == 1) {//课程表
            
        }else if (index == 2){//错题集
            
        }else if (index == 3){//请假
            
        }else if (index == 4){//公告
            
        }
    }
    
   
    
    
    
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
