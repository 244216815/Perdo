//
//  NameListTableViewCell.h
//  Perdo
//
//  Created by 一招 on 2020/3/27.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NameListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tab;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

-(void)configBtn;

@end

NS_ASSUME_NONNULL_END
