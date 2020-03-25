//
//  MainTabBarController.m
//  Perdo
//
//  Created by 一招 on 2020/3/23.
//  Copyright © 2020 一招. All rights reserved.

#import "UIViewController+PDNavigationItem.h"
#import <objc/runtime.h>

@implementation UIViewController(PDNavigationItem)
-(void)configNavigationBackItem{

    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navbar_back_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backItemAction)];
    leftItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem= leftItem;
}

-(void)configNavigationBackBlackItem{
    
    UIImage *image = [UIImage imageNamed:@"navbar_back_black"];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backItemAction)];
    leftItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem= leftItem;
}

-(void)configNavigationCloseItem{
    UIBarButtonItem *leftCloseItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemAction)];
    [leftCloseItem setTintColor:UIColorHex(666666)];
    self.navigationItem.leftBarButtonItem = leftCloseItem;
}
-(void)configNavigationBlackCloseItem{
    UIBarButtonItem *leftCloseItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemAction)];
    [leftCloseItem setTintColor:UIColorHex(0x666666)];
    self.navigationItem.leftBarButtonItem = leftCloseItem;
}

- (void)configNavigationCloseImageItem{
    
    UIImage *image = [UIImage imageNamed:@"nav_close"];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(closeItemAction)];
    leftItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem= leftItem;
}

-(void)configNavigationWithTitle:(NSString *)title imageName:(NSString *)imageName action:(SEL)action type:(NavigationItemType)type fontSize:(CGFloat)size{
    
    if (!imageName) {
        UIFont *font = nil;
        if (size -0<0.00001) {
            font = [UIFont systemFontOfSize:16.0f];
            
        }else {
            font = [UIFont systemFontOfSize:size];
        }
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    
        [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorHex(333333),NSFontAttributeName:font} forState:UIControlStateNormal];
        [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorHex(dbdbdb),NSFontAttributeName:font} forState:UIControlStateHighlighted];
        
        
        if (type == NavigationItemTypeLeft) {
            self.navigationItem.leftBarButtonItem = barItem;
        }
        else {
            [self.navigationItem setRightBarButtonItem:barItem];
        }
        
        return;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setExclusiveTouch:YES];
    [button.titleLabel setTextAlignment:NSTextAlignmentRight];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (size -0<0.00001) {
        button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
    }else {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
    button.frame = CGRectMake(0, 0, 60, 30);
    [button.titleLabel setTextAlignment:NSTextAlignmentRight];
    UIBarButtonItem * barButtonItem;
    barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (imageName) {
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 20, 20);
    }
    if (type == NavigationItemTypeLeft) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        self.navigationItem.leftBarButtonItem =barButtonItem ;
        if (action==nil) {
            [button addTarget:self action:@selector(leftItemAction) forControlEvents:
             UIControlEventTouchUpInside];
        }
    }
    else if(type == NavigationItemTypeRight) {
        self.navigationItem.rightBarButtonItem =barButtonItem ;
        
        if (action==nil) {
            [button addTarget:self action:@selector(rightItemAction) forControlEvents:
             UIControlEventTouchUpInside];
        }
    }
    if (action!=nil) {
        [button addTarget:self action:action forControlEvents:
         UIControlEventTouchUpInside];
    }
}
//图片数组
-(void)configNavigationWitImageName:(NSArray *)images action:(SEL)action type:(NavigationItemType)type{
    if (IsEmpty(images)) {
        return;
    }
    UIView *buttonItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH>320?60:50, kScreenWidth > 320?30:20)];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItemView];
    NSInteger imageCount = 0;
    for (int i = 0; i < images.count; i++) {
        imageCount = images.count == 1?2:images.count;
        UIImage *image = images[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSInteger gap = kScreenWidth>320?10:10*(imageCount-1-i);
        button.frame = CGRectMake(gap+buttonItemView.frame.size.height*(imageCount-1-i), 0, buttonItemView.frame.size.height, buttonItemView.frame.size.height);
        [button setExclusiveTouch:YES];
        button.tag = i+1;
        if (image) {
            [button setImage:image forState:UIControlStateNormal];
        }
        if (action!=nil) {
            [button addTarget:self action:action forControlEvents:
             UIControlEventTouchUpInside];
        }
        [buttonItemView addSubview:button];
    }
    if (type == NavigationItemTypeLeft) {
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
    }else if (type == NavigationItemTypeRight){
        [self.navigationItem setRightBarButtonItem:barButtonItem];
    }
}

//消息
-(void)configNavigationWitImageName:(UIImage *)image action:(SEL)action type:(NavigationItemType)type messageNum:(NSString *)num{
    if (IsEmpty(image)) {
        return;
    }
    UIView *buttonItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH>320?60:50, kScreenWidth > 320?30:20)];
   UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItemView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger gap = kScreenWidth>320?10:10;
    button.frame = CGRectMake(gap+buttonItemView.frame.size.height, 0, buttonItemView.frame.size.height, buttonItemView.frame.size.height);
    [button setExclusiveTouch:YES];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (action!=nil) {
        [button addTarget:self action:action forControlEvents:
         UIControlEventTouchUpInside];
    }
    [buttonItemView addSubview:button];
    
    UILabel *messageNum = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.size.width - 10,  5, 12, 12)];
    [messageNum setBackgroundColor:UIColorHex(22253f)];
    [messageNum setTextColor:UIColorHex(ffffff)];
    [messageNum setFont:[UIFont systemFontOfSize:10]];
    [messageNum setTextAlignment:NSTextAlignmentCenter];
    messageNum.layer.cornerRadius = 6;
    messageNum.layer.masksToBounds = YES;
    
    if ([num intValue] > 0) {
        [messageNum setText:num];
        [button addSubview:messageNum];
    }
    
    if (type == NavigationItemTypeLeft) {
       [self.navigationItem setLeftBarButtonItem:barButtonItem];
    }else if (type == NavigationItemTypeRight){
       [self.navigationItem setRightBarButtonItem:barButtonItem];
    }
}

-(UILabel *)configMessageWitImageName:(UIImage *)image targetView:(UIView *)targetView action:(SEL)action type:(NavigationItemType)type messageNum:(NSString *)num{
    if (IsEmpty(image)) {
        return nil;
    }
    UIView *buttonItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH>320?60:50, kScreenWidth > 320?30:20)];
    [targetView addSubview:buttonItemView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger gap = kScreenWidth>320?10:10;
    button.frame = CGRectMake(gap+buttonItemView.frame.size.height, 0, buttonItemView.frame.size.height, buttonItemView.frame.size.height);
    button.right = buttonItemView.width;
    [button setExclusiveTouch:YES];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (action!=nil) {
        [button addTarget:self action:action forControlEvents:
         UIControlEventTouchUpInside];
    }
    [buttonItemView addSubview:button];
    
    UILabel *messageNum = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.size.width - 10,  3, 12, 12)];
    [messageNum setBackgroundColor:UIColor_FF3339];
    [messageNum setTextColor:UIColorHex(ffffff)];
    [messageNum setFont:[UIFont systemFontOfSize:10]];
    [messageNum setTextAlignment:NSTextAlignmentCenter];
    messageNum.layer.cornerRadius = 6;
    messageNum.layer.masksToBounds = YES;
    messageNum.hidden = ![num intValue];
    [messageNum setText:num];
    [button addSubview:messageNum];
    
    if (type == NavigationItemTypeLeft) {
        [buttonItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(targetView).offset(8);
            make.centerY.equalTo(targetView);
            make.width.mas_equalTo(buttonItemView.width);
            make.height.mas_equalTo(buttonItemView.height);
        }];
    }else if (type == NavigationItemTypeRight){
        [buttonItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(targetView).offset(-8);
            make.centerY.equalTo(targetView);
            make.width.mas_equalTo(buttonItemView.width);
            make.height.mas_equalTo(buttonItemView.height);
        }];
    }
    return messageNum;
}


//通用
-(void)configNavTitles:(NSArray<NSString *> *)titles imageNames:(NSArray<NSString *> *)images actions:(NSArray<NSString *> *)actionNames type:(NavigationItemType)type fontSize:(CGFloat)size{
    
    NSArray *arr = nil;
    if (!IsEmpty(titles)) {
        arr = titles;
    }
    if (!IsEmpty(images)) {
        arr = images;
    }
    if(IsEmpty(arr)) return;
    
    NSMutableArray *result = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setExclusiveTouch:YES];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        CGFloat width = size;
        if (width -0<0.00001) {
            width = 15.0f;
        }
        
        button.titleLabel.font = [UIFont systemFontOfSize:width];
        button.frame = CGRectMake(0, 0, width*([self stringIndex:idx arr:titles].length>2?3:2)+2, 50);
        [button setTitle:[self stringIndex:idx arr:titles] forState:UIControlStateNormal];
        [button setImage:[self imageIndex:idx arr:images] forState:UIControlStateNormal];
        NSString * action = [self stringIndex:idx arr:actionNames];
        if(action){
            [button addTarget:self action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchUpInside];
        }
        UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [result addObject:barButtonItem];
    }];
    
    if (type == NavigationItemTypeLeft) {
        self.navigationItem.leftBarButtonItems = result;
    }else if (type == NavigationItemTypeRight){
        self.navigationItem.rightBarButtonItems = result;
    }
}

-(void)backItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)closeItemAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Getters &&Setters

- (UIImage *)imageIndex:(NSInteger)index arr:(NSArray *)origins{
    if(IsEmpty(origins)||(index+1>origins.count)) return [UIImage new];
    return [UIImage imageNamed:origins[index]];
}
- (NSString *)stringIndex:(NSInteger)index arr:(NSArray *)origins{
    if(IsEmpty(origins)||(index+1>origins.count)) return @"";
    return origins[index];
}


@end
