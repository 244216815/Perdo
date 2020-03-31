//
//  CourseChoseButton.m
//  Perdo
//
//  Created by 一招 on 2020/3/31.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "CourseChoseButton.h"

@implementation CourseChoseButton


- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 8;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
//        self.titleLabel.textColor = UIColorHex(4C4E4D);
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = UIColorHex(dadcdb).CGColor;
        self.layer.borderWidth = 0.5;
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
}

-(void)setHighlighted:(BOOL)highlighted{
    
}

- (void)configTitle:(NSString *)title{
    NSString *image = @"mistakes_btn";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    [imageView setFrame:CGRectMake(self.size.width-28, 0, 28, 12)];
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, 20, 12)];
    label.text = title;
    label.textColor = UIColorHex(ffffff);
    label.font = [UIFont systemFontOfSize:8];
    label.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:label];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
