//
//  NameListViewController.m
//  Perdo
//
//  Created by 一招 on 2020/3/27.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "NameListViewController.h"
#import "NameListTableViewCell.h"

@interface NameListViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NameListViewController

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
    return 72;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NameListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameListTableViewCell"];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight-172-kTabBarHeight-44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorHex(f8f8f8);
        [_tableView registerNib:[UINib nibWithNibName:@"NameListTableViewCell" bundle:nil] forCellReuseIdentifier:@"NameListTableViewCell"];
        @weakify(self);
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
