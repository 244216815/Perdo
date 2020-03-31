//
//  ExerciseViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/23.
//  Copyright © 2020 一招. All rights reserved.
//

#import "ExerciseViewController.h"
#import "HomeworkTableViewCell.h"
#import "CourseChoseButton.h"


@interface ExerciseViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

//@property (nonatomic, strong)UIView *homeworkView;
//@property (nonatomic, strong)UIView *mistakesView;

@property (nonatomic, strong)UIButton *oldSelectedBtn;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation ExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
   
}

- (void)buildUI{
    self.view.backgroundColor = UIColorHex(f5f5f5);
    self.title = @"练习实践";
    [self configNavigationWitImageName:[NSArray arrayWithObject:[UIImage imageNamed:@"index_add"]] action:@selector(addAction) type:NavigationItemTypeRight];
    
    [self addHomeworkView];
    [self addMistakesView];
    
}

-(void)addAction{
    CustomAlertThreeView *addStudentView = [[NSBundle mainBundle]loadNibNamed:@"CustomAlertThreeView" owner:self options:nil].lastObject;
    addStudentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [addStudentView configLabelTextOne:@"布置作业" textTwo:@"作业质量排行"];
    [addStudentView setAddActionBlock:^(NSInteger index) {
        if (index == 1) {
            //创建群聊
            
        }else if (index == 2){
            //关联学生

        }
    }];
    [PDAppDelegate.window addSubview:addStudentView];
}

- (void)addHomeworkView{
    UIView *homeworkView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+16, SCREEN_WIDTH, 234)];
    [homeworkView setBackgroundColor:UIColorHex(ffffff)];
    [self.view addSubview:homeworkView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 40, 38)];
    titleLabel.textColor = UIColorHex(4c4e4d);
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = @"作业";
    [homeworkView addSubview:titleLabel];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setFrame:CGRectMake(SCREEN_WIDTH - 80-16, 0, 80, 38)];
    [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:UIColorHex(adb1af) forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [moreBtn setImage:[UIImage imageNamed:@"right_icon"] forState:UIControlStateNormal];
    [moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -moreBtn.imageView.image.size.width, 0, moreBtn.imageView.image.size.width)];
    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, moreBtn.titleLabel.bounds.size.width, 0, -moreBtn.titleLabel.bounds.size.width)];
    [[moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//        跳转到
//        ChangeTap(2);
//        [self.navigationController popViewControllerAnimated:YES];
    }];
    [homeworkView addSubview:moreBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorHex(e8e9e9);
    [homeworkView addSubview:lineView];
    
    UIScrollView *titleScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 34)];
    titleScrollview.showsHorizontalScrollIndicator = NO;
    [homeworkView addSubview:titleScrollview];
    
    NSArray *array = @[@"语文",@"数学",@"英语",@"劳动",@"体育",@"自然",@"物理",@"化学",@"生物",@"历史"];
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(16+48*i, 8, 40, 17)];
        [btn setBackgroundImage:[UIImage imageWithColor:UIColorHex(30da82)] forState:UIControlStateSelected];
        [btn setTitleColor:UIColorHex(ffffff) forState:UIControlStateSelected];
        [btn setTitleColor:UIColorHex(4c4e4d) forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:UIColorHex(ffffff)] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 9;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        if (!i) {
            btn.selected = YES;
            self.oldSelectedBtn = btn;
        }
        
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable sender) {
            sender.selected = !sender.selected;
            self.oldSelectedBtn.selected = !self.oldSelectedBtn.selected;
            self.oldSelectedBtn = sender;
            
        }];
        [titleScrollview addSubview:btn];

    }
    titleScrollview.contentSize = CGSizeMake((16+48*array.count), 34);
    

    [homeworkView addSubview:self.tableView];
}

- (void)addMistakesView{
    UIView *mistakesView = [[UIView alloc]initWithFrame:CGRectMake(0,  kNavBarHeight + 250 +16, SCREEN_WIDTH, SCREEN_HEIGHT - (kNavBarHeight + 250 +16)-kTabBarHeight)];
    [mistakesView setBackgroundColor:UIColorHex(ffffff)];
    [self.view addSubview:mistakesView];
       
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 38)];
    titleLabel.textColor = UIColorHex(4c4e4d);
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = @"错题集";
    [mistakesView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorHex(e8e9e9);
    [mistakesView addSubview:lineView];
    
    NSArray *array = @[@"语文",@"数学",@"英语"];
    for (int i = 0; i<array.count; i++) {
        CourseChoseButton *courseBtn = [[CourseChoseButton alloc]initWithFrame:CGRectMake(16+88*i, 55, 80, 32)];
        [courseBtn setTitle:array[i] forState:UIControlStateNormal];
        [courseBtn setTitleColor:UIColorHex(4c4e4d) forState:UIControlStateNormal];
        [courseBtn configTitle:@"200"];
        [[courseBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
        [mistakesView addSubview:courseBtn];
    }
}

#pragma mark - UITabelViewDelegate,UITableViewDataSource -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//    NSInteger count = self.dataArray.count>5?5:self.dataArray.count;
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 28;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeworkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeworkTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    PhoneChargeListModel *model = self.dataArray[indexPath.row];
//    [cell configModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma mark - DZNEmptyDataSetSource,DZNEmptyDataSetDelegate -
 - (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
     return [UIImage imageNamed:@"no_data_placeholder"];
 }

 - (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
     return  [[NSAttributedString alloc] initWithString:@"暂无数据" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#DEE2EB"],NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:15]}];
 }

 - (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
     return -50;
 }



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 73, SCREEN_WIDTH, 161) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"HomeworkTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeworkTableViewCell"];
        //        @weakify(self);
        //        [_tableView configRefreshHeaderAndFooterWithBeginRefresh:^{
        //            @strongify(self);
        //            [self requestData];
        //        }];
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
