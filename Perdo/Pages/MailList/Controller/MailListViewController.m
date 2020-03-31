//
//  MailListViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/23.
//  Copyright © 2020 一招. All rights reserved.
//

#import "MailListViewController.h"
#import "NameListTableViewCell.h"

@interface MailListViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong)UIView *sectionView;

@property (nonatomic, strong)UIView *listView;
@property (nonatomic, strong)NSArray *classArray;

@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *detailLabel;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation MailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];

}

- (void)buildUI{
    self.view.backgroundColor = UIColorHex(f5f5f5);
    self.title = @"通讯录";
    [self configNavigationWitImageName:[NSArray arrayWithObject:[UIImage imageNamed:@"index_add"]] action:@selector(addAction) type:NavigationItemTypeRight];
    
    [self addTopView];
    [self addListView];
    [self addMailListView];
}

- (void)addTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, SCREEN_WIDTH, 48)];
    topView.backgroundColor = UIColorHex(ffffff);
    [self.view addSubview:topView];
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"maillist_group"]];
    iconImageView.frame = CGRectMake(16, 12, 24, 24);
    [topView addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    [self setLabel:nameLabel frame:CGRectMake(48, 0, 100, 48) font:[UIFont boldSystemFontOfSize:14] textColor:UIColorHex(4c4e4d) view:topView];
    nameLabel.text = @"我的群组";
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-16-16, 16, 16, 16)];
    rightImageView.image = [UIImage imageNamed:@"right_icon"];
    [topView addSubview:rightImageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 48);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
       //跳转到我的群聊
        
    }];
    [topView addSubview:button];
    
}

- (void)addListView{
    self.classArray = @[@"一年级(一班)",@"一年级(实验班)",@"三年级(A班)"];
    self.listView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight +64, SCREEN_WIDTH, 130+self.classArray.count*24 )];
    self.listView.backgroundColor = UIColorHex(ffffff);
    [self.view addSubview:self.listView];
    
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 16, 48, 48)];
    self.topImageView.image = [UIImage imageNamed:@"maillist_school"];
    [self.listView addSubview:self.topImageView];
    
    self.nameLabel = [UILabel new];
    [self setLabel:self.nameLabel frame:CGRectMake(72, 16, SCREEN_WIDTH-88, 20) font:[UIFont boldSystemFontOfSize:14] textColor:UIColorHex(4c4e4d) view:self.listView];
    self.nameLabel.text = @"全部班级";
    
    self.detailLabel = [UILabel new];
    [self setLabel:self.detailLabel frame:CGRectMake(72, 44, SCREEN_WIDTH-88, 17) font:[UIFont systemFontOfSize:12] textColor:UIColorHex(cacccb) view:self.listView];
     self.detailLabel.text = @"苏州相城区实验小学";
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(72, 80, SCREEN_WIDTH-88, 0.5)];
    lineView.backgroundColor = UIColorHex(e8e9e9);
    [self.listView addSubview:lineView];
    
    UIImageView *classImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 92, 24, 24)];
    classImageView.image = [UIImage imageNamed:@"maillist_class"];
    [self.listView addSubview:classImageView];
    
    UILabel *classLabel = [[UILabel alloc]init];
    [self setLabel:classLabel frame:CGRectMake(72, 94, SCREEN_WIDTH-88, 20) font:[UIFont boldSystemFontOfSize:14] textColor:UIColorHex(4c4e4d) view:self.listView];
     classLabel.text = @"年级班级";
    
    for (int i = 0; i < self.classArray.count; i++) {
        UIView *classV = [[UIView alloc]initWithFrame:CGRectMake(0, 124+i*24, SCREEN_WIDTH, 24)];
        UILabel *classL = [[UILabel alloc]init];
        [self setLabel:classL frame:CGRectMake(72, 4, SCREEN_WIDTH-134, 20) font:[UIFont systemFontOfSize:14] textColor:UIColorHex(4c4e4d) view:classV];
        classL.text = self.classArray[i];
        
        UIButton *classB = [UIButton buttonWithType:UIButtonTypeCustom];
        classB.frame = CGRectMake(SCREEN_WIDTH - 60, 4, 46, 20);
        [classB setTitle:@"班级群" forState:UIControlStateNormal];
        [classB setTitleColor:UIColorHex(30da82) forState:UIControlStateNormal];
        [classB.titleLabel setFont:[UIFont systemFontOfSize:12]];
        classB.titleLabel.textAlignment = NSTextAlignmentRight;
        [[classB rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
        [classV addSubview:classB];
        
        [self.listView addSubview:classV];
    }
}

-(void)addMailListView{
    UIView *mailListView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.listView.frame)+16, SCREEN_WIDTH, SCREEN_HEIGHT-210-self.classArray.count*24-kTabBarHeight-kNavBarHeight)];
    mailListView.backgroundColor = UIColorHex(ffffff);
    [self.view addSubview:mailListView];
    
    UILabel *mailListLabel = [UILabel new];
     [self setLabel:mailListLabel frame:CGRectMake(16, 0, SCREEN_WIDTH-32, 36) font:[UIFont boldSystemFontOfSize:14] textColor:UIColorHex(4c4e4d) view:mailListView];
    mailListLabel.text = @"联系人";
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 36.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorHex(e8e9e9);
    [mailListView addSubview:lineView];
    
    [mailListView addSubview:self.tableView];
}

#pragma mark - UITabelViewDelegate,UITableViewDataSource -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NameListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameListTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    PhoneChargeListModel *model = self.dataArray[indexPath.row];
//    [cell configModel:model];
    [cell configBtn];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 37, SCREEN_WIDTH, SCREEN_HEIGHT-247-self.classArray.count*24-kTabBarHeight-kNavBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"NameListTableViewCell" bundle:nil] forCellReuseIdentifier:@"NameListTableViewCell"];
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





-(void)addAction{
    CustomAlertThreeView *addStudentView = [[NSBundle mainBundle]loadNibNamed:@"CustomAlertThreeView" owner:self options:nil].lastObject;
    addStudentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [addStudentView configLabelTextOne:@"创建年级/班级" textTwo:@"加入年级/班级"];
    [addStudentView setAddActionBlock:^(NSInteger index) {
        if (index == 1) {
            //创建群聊
            
        }else if (index == 2){
            //关联学生

        }
    }];
    [PDAppDelegate.window addSubview:addStudentView];
}

- (void)setLabel:(UILabel *)label frame:(CGRect )frame font:(UIFont *)font textColor:(UIColor *)textColor view:(UIView *)view {
    label.frame = frame;
    label.font = font;
    label.textColor = textColor;
    [view addSubview:label];
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
