//
//  UIScrollView+ConfigRefresh.m
//  
//
//  Created by LKCZ on 2019/5/13.
//

#import "UIScrollView+ConfigRefresh.h"

static NSArray *_animations;

@implementation UIScrollView (ConfigRefresh)


+ (void)initialize{
    if (!_animations) {
        NSMutableArray *animations = [NSMutableArray array];
        for (int i = 0; i<12; i++) {
            [animations addObject:[UIImage imageNamed:[NSString stringWithFormat:@"refresh_head_animation%02d",i]]];
        }
        _animations = animations;
    }
}

- (int)currentPage
{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}


- (void)setCurrentPage:(int)currentPage{
     objc_setAssociatedObject(self, @selector(currentPage), @(currentPage),OBJC_ASSOCIATION_ASSIGN);
}


- (loadComplete)completeBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCompleteBlock:(loadComplete)completeBlock{
     objc_setAssociatedObject(self, @selector(completeBlock), completeBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (beignLoadData)beginLoadBlock{
     return objc_getAssociatedObject(self, _cmd);
}

- (void)setBeginLoadBlock:(beignLoadData)beginLoadBlock{
     objc_setAssociatedObject(self, @selector(beginLoadBlock), beginLoadBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)beginRefreshing{
     [self.mj_header beginRefreshing];
}

- (void)configRefreshHeaderAndFooterWithBeginRefresh:(void(^)(void))beginRefreshBlock{
    self.beginLoadBlock = beginRefreshBlock;
    self.currentPage = 1;
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    MJRefreshBackGifFooter *gifFooter = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    [gifHeader setImages:_animations forState:MJRefreshStateRefreshing];
    [gifHeader setImages:_animations forState:MJRefreshStatePulling];
    [gifHeader setImages:_animations forState:MJRefreshStateIdle];
    [gifHeader setImages:_animations forState:MJRefreshStateWillRefresh];
    [gifFooter setImages:_animations forState:MJRefreshStateRefreshing];
    [gifFooter setImages:_animations forState:MJRefreshStatePulling];
    [gifFooter setImages:_animations forState:MJRefreshStateIdle];
    [gifFooter setImages:_animations forState:MJRefreshStateWillRefresh];
    self.mj_header = gifHeader;
    self.mj_footer = gifFooter;
    [self configCompleteBlock];
}

- (void)configRefreshHeaderRefresh:(void(^)(void))beginRefreshBlock{
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:beginRefreshBlock];
    self.currentPage = 1;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    [gifHeader setImages:_animations forState:MJRefreshStateRefreshing];
    [gifHeader setImages:_animations forState:MJRefreshStatePulling];
    [gifHeader setImages:_animations forState:MJRefreshStateIdle];
    [gifHeader setImages:_animations forState:MJRefreshStateWillRefresh];
    self.mj_header = gifHeader;
}

- (void)configRefreshFooterRefresh:(void(^)(void))loadMoreBlock{
   MJRefreshBackGifFooter *gifFooter = [MJRefreshBackGifFooter footerWithRefreshingBlock:loadMoreBlock];
    [gifFooter setImages:_animations forState:MJRefreshStateRefreshing];
    [gifFooter setImages:_animations forState:MJRefreshStatePulling];
    [gifFooter setImages:_animations forState:MJRefreshStateIdle];
    [gifFooter setImages:_animations forState:MJRefreshStateWillRefresh];
    self.mj_footer = gifFooter;
}

- (void)resetRefreshHeader{
    if (!self.mj_header) {
        return;
    }
    self.mj_header = nil;
}

- (void)resetRefreshFooter{
    if (!self.mj_footer) {
        return;
    }
    self.mj_footer = nil;
}

- (void)loadData{
    if ([self.mj_footer isRefreshing]) {
        return;
    }
    self.currentPage = 1;
    if (self.beginLoadBlock) {
        self.beginLoadBlock();
    }
}

- (void)loadMoreData{
    if ([self.mj_header isRefreshing]) {
        return;
    }
    self.currentPage++;
    if (self.beginLoadBlock) {
        self.beginLoadBlock();
    }
}


- (void)configCompleteBlock{
    @weakify(self);
    self.completeBlock = ^(int itemsCount) {
        @strongify(self);
        if (self.currentPage == 1) {
            [self.mj_header endRefreshing];
            [self.mj_footer resetNoMoreData];
            if (itemsCount < 1) {
                [self.mj_footer endRefreshingWithNoMoreData];
            }
            return ;
        }
        [self.mj_footer endRefreshing];
        if (itemsCount < 1) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    };
}


@end
