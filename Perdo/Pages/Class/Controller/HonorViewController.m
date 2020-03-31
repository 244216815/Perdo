//
//  HonorViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/27.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "HonorViewController.h"
#import "HonorTableViewCell.h"

@interface HonorViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HonorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];

}


-(void)requestData{
   
//    [BEENetClient getPhoneChargeListWithType:[self.type intValue] page:self.tableView.currentPage complete:^(id  _Nonnull response) {
//        NSArray *arrays = [NSArray modelArrayWithClass:PhoneChargeListModel.class json:response];
//        if (self.tableView.currentPage == 1) {
//            if (self.dataArray.count) {
//                [self.dataArray removeAllObjects];
//            }
//            if (arrays.count) {
//                [self.dataArray addObjectsFromArray:arrays];
//            }
//        }else{
//            [self.dataArray addObjectsFromArray:arrays];
//        }
//        self.tableView.completeBlock(arrays.count);
//        [self.tableView reloadData];
//
//    }];
    
}

- (void)zj_viewWillAppearForIndex:(NSInteger)index{
    [self.tableView beginRefreshing];
}

- (void)refreshCurrentData{
     [self.tableView beginRefreshing];
}

#pragma mark - UITabelViewDelegate,UITableViewDataSource -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 234;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HonorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HonorTableViewCell"];
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
        NSInteger height = RoleTypeTeacher?(kScreenHeight-kNavBarHeight-101-kTabBarHeight-44):(kScreenHeight-kNavBarHeight-kTabBarHeight-44);
        height = kScreenHeight-kNavBarHeight-101-kTabBarHeight-44;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorHex(f8f8f8);
        [_tableView registerNib:[UINib nibWithNibName:@"HonorTableViewCell" bundle:nil] forCellReuseIdentifier:@"HonorTableViewCell"];
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
