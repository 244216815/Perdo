//
//  NameListTableViewCell.m
//  Perdo
//
//  Created by 一招 on 2020/3/27.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "NameListTableViewCell.h"

@implementation NameListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tab.layer.borderColor = UIColorHex(30da82).CGColor;
    self.tab.layer.borderWidth = 1;
    self.tab.layer.cornerRadius = 8;
}

-(void)configBtn{
    self.editBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
