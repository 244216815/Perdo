//
//  ClassViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/23.
//  Copyright © 2020 一招. All rights reserved.
//

#import "ClassViewController.h"
#import "ZJScrollPageView.h"
#import "HonorViewController.h"
#import "NameListViewController.h"

@interface ClassViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UIButton *nameButton;
@property (nonatomic, strong)UILabel *scaleLabel;//人数比例
@property (nonatomic, strong)UILabel *countLabel;//缺勤人数
@property (nonatomic, strong)UILabel *attendanceLabel;//出勤率

@property (nonatomic ,strong)ZJScrollSegmentView *segmentView;
@property (nonatomic ,strong)ZJContentView *scrollContentView;
@property (nonatomic ,strong)NSArray *categorys;
@property (nonatomic ,assign)int selectIndex;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//      [self.segmentView setSelectedIndex:self.selectIndex animated:YES];
}

- (void)configNotification{
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSNotification_LoginSuccess object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
//        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

- (void)buildUI{
    self.title = @"班级";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColorHex(f5f5f5);
  
//    if (RoleTypeTeacher) {
//    @"class_info"
        [self configNavigationWitImageName:[NSArray arrayWithObject:[UIImage imageNamed:@"class_set"]] action:@selector(setAction) type:NavigationItemTypeRight];
        [self.view addSubview:self.topView];
        [self buildTopView];
//    }
    [self configChildVcs];
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.scrollContentView];
}

- (void)buildTopView{
//    [self.topView addSubview:self.nameButton];
    
    [self.topView addSubview:self.scaleLabel];
    [self.topView addSubview:self.countLabel];
    [self.topView addSubview:self.attendanceLabel];
    NSArray *nameArray = @[@"人数比例",@"缺勤人数",@"出勤率"];
    for (int i = 0; i<3; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16+ (SCREEN_WIDTH-32)/3*i, 55, (SCREEN_WIDTH-32)/3, 17)];
        label.text = nameArray[i];
        label.textColor = UIColorHex(4c4e4d);
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:label];
    }
    
    UIButton *countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [countBtn setFrame:CGRectMake(16+ (SCREEN_WIDTH-32)/3, 0, (SCREEN_WIDTH-32)/3, 85)];
    [[countBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //跳转到缺勤人数
        
    }];
    [self.topView addSubview:countBtn];
}

- (void)setAction{
    //
    
    CustomAlertThreeView *classTeacherView = [[NSBundle mainBundle]loadNibNamed:@"CustomAlertThreeView" owner:self options:nil].lastObject;
    classTeacherView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [classTeacherView configLabelTextOne:@"新增班级风采/荣誉" textTwo:@"班级荣誉统计"];
    [classTeacherView setAddActionBlock:^(NSInteger index) {
        if (index == 1) {
            //新增班级风采/荣誉
        }else if (index == 2){
            //班级荣誉统计

        }
    }];
    [PDAppDelegate.window addSubview:classTeacherView];
}


#pragma mark privateFunc
- (void)configChildVcs{
    //，1=风采，2=荣誉
    NSArray *types = @[@(1),@(2)];
//    NSInteger count = RoleTypeTeacher?(self.categorys.count-1):self.categorys.count;
    for (int i = 0; i<self.categorys.count-1; i++) {
        HonorViewController *honorVc = [HonorViewController new];
        honorVc.type =  [types[i] stringValue];
        [self addChildViewController:honorVc];
    }
//    if (RoleTypeTeacher) {
        NameListViewController *nameListVc = [NameListViewController new];
        [self addChildViewController:nameListVc];
//    }
   
}
#pragma mark - TopView-

-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, SCREEN_WIDTH, 85)];
        _topView.backgroundColor = UIColorHex(ffffff);
    }
    return _topView;
}

-(UIButton *)nameButton{
    if (!_nameButton) {
        _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nameButton setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 46)];
        [_nameButton setTitleColor:UIColorHex(4c4e4d) forState:UIControlStateNormal];
        [_nameButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_nameButton setTitle:@"一年级(实验班)" forState:UIControlStateNormal];
//        [_nameButton setImage:[UIImage imageNamed:@"down_icon"] forState:UIControlStateNormal];
//        [_nameButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -_nameButton.imageView.image.size.width, 0, _nameButton.imageView.image.size.width)];
//        [_nameButton setImageEdgeInsets:UIEdgeInsetsMake(0, _nameButton.titleLabel.bounds.size.width, 0, -_nameButton.titleLabel.bounds.size.width)];
//        [[_nameButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
                 //跳转到
//            ChangeTap(2);
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
    }
    return _nameButton;
}

-(UILabel *)scaleLabel{
    if (!_scaleLabel) {
        _scaleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, (SCREEN_WIDTH-32)/3, 45)];
        _scaleLabel.attributedText = [self attributeTitle:@"40(20/20)" str:@"("];
        _scaleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _scaleLabel;
}

-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(16+(SCREEN_WIDTH-32)/3, 10, (SCREEN_WIDTH-32)/3, 45)];
        _countLabel.textColor = UIColorHex(4C4E4D);
        [_countLabel setFont:[UIFont boldSystemFontOfSize:32]];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.text = @"1";
    }
    return _countLabel;
}

-(UILabel *)attendanceLabel{
    if (!_attendanceLabel) {
        _attendanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(16+(SCREEN_WIDTH-32)/3*2, 10, (SCREEN_WIDTH-32)/3, 45)];
        _attendanceLabel.attributedText = [self attributeTitle:@"90%" str:@"%"];
        _attendanceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _attendanceLabel;
}

#pragma mark privateFunc

- (CALayer *)getMarginLayerWithFrame:(CGRect)frame{
    CALayer *topMarginLayer = [[CALayer alloc]init];
    topMarginLayer.backgroundColor = UIColor_E0E0E0.CGColor;
    topMarginLayer.frame = frame;
    return topMarginLayer;
}


#pragma mark - ZJScroll -

- (ZJScrollSegmentView *)segmentView{
    if (!_segmentView) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        //显示滚动条
        style.showLine = YES;
        style.segmentViewBounces = NO;
        style.scrollLineColor = UIColorHex(30da82);
        style.titleMargin = 24;
        style.scrollLineHeight = 2;
        style.normalTitleColor = UIColorHex(cacccb);
        style.selectedTitleColor = UIColorHex(30da82);
        style.contentViewBounces = NO;
        style.autoAdjustTitlesWidth = YES;
        style.titleFont = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        @weakify(self);
         NSInteger topHeight = RoleTypeTeacher? CGRectGetMaxY(self.topView.frame)+16:kNavBarHeight;
        topHeight = CGRectGetMaxY(self.topView.frame)+16;
        _segmentView = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, topHeight, kScreenWidth, 44) segmentStyle:style delegate:self titles:self.categorys titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            @strongify(self);
            [self.scrollContentView setContentOffSet:CGPointMake(self.scrollContentView.bounds.size.width * index, 0.0) animated:YES];
        }];
        [_segmentView.layer addSublayer:[self getMarginLayerWithFrame:CGRectMake(0, _segmentView.height - 0.5, kScreenWidth, 0.5)]];
        _segmentView.backgroundColor = UIColorHex(ffffff);
    }
    return _segmentView;
}

- (NSArray *)categorys{
    if (!_categorys) {
        
//        _categorys = RoleTypeTeacher?@[@"风采",@"荣誉",@"名单"]:@[@"风采",@"荣誉"];
        _categorys = @[@"风采",@"荣誉",@"名单"];
    }
    return _categorys;
}

- (ZJContentView *)scrollContentView{
    if (!_scrollContentView) {
        NSInteger height = RoleTypeTeacher?(kScreenHeight - kNavBarHeight-101-kTabBarHeight-44):(kScreenHeight - kNavBarHeight-kTabBarHeight-44);
        height = kScreenHeight - kNavBarHeight-101-kTabBarHeight-44;
        _scrollContentView = [[ZJContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentView.frame), kScreenWidth, height) segmentView:self.segmentView parentViewController:self delegate:self];
        _scrollContentView.backgroundColor = UIColorHex(ffffff);
    }
    return _scrollContentView;
}

#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.childViewControllers.count;
}

- (UIViewController <ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = self.childViewControllers[index];
    }
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}


#pragma mark - 充值按钮富文本普通/选中显示 -
-(NSAttributedString *)attributeTitle:(NSString *)title str:(NSString *)str{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:title];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:32] range:NSMakeRange(0, [title rangeOfString:str].location)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorHex(30da82) range:NSMakeRange(0, [title rangeOfString:str].location)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange([title rangeOfString:str].location, title.length - [title rangeOfString:str].location)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorHex(30da82) range:NSMakeRange([title rangeOfString:str].location, title.length - [title rangeOfString:str].location)];
    return attributedString;
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
