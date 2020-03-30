//
//  UIScrollView+ConfigRefresh.h
//  
//
//  Created by LKCZ on 2019/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define loadDataPageSize 20

typedef void(^loadComplete)(int itemsCount);
typedef void(^beignLoadData)(void);

@interface UIScrollView (ConfigRefresh)

@property (nonatomic ,assign)int currentPage;

@property (nonatomic ,copy)loadComplete completeBlock;

@property (nonatomic ,copy)beignLoadData beginLoadBlock;

-(void)beginRefreshing;
- (void)configRefreshHeaderAndFooterWithBeginRefresh:(void(^)(void))beginRefreshBlock;
- (void)configRefreshHeaderRefresh:(void(^)(void))beginRefreshBlock;
- (void)configRefreshFooterRefresh:(void(^)(void))loadMoreBlock;
- (void)resetRefreshHeader;
- (void)resetRefreshFooter;

@end

NS_ASSUME_NONNULL_END
