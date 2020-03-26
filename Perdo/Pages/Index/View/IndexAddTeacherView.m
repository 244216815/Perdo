//
//  IndexAddTeacherView.m
//  Perdo
//
//  Created by 一招 on 2020/3/26.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import "IndexAddTeacherView.h"

@interface IndexAddTeacherView ()


@end

@implementation IndexAddTeacherView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    
     self.teacherView.layer.cornerRadius = 8;
    
}

- (IBAction)btnAction:(UIButton *)sender {
    NSInteger index = sender.tag - 200;
    [self closeView];
    if (self.addActionBlock) {
        self.addActionBlock(index);
    }
}

- (IBAction)cancleAction:(id)sender {
     [self closeView];
}

- (void)closeView{
    [UIView animateWithDuration:0.3 animations:^{
        self.teacherView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
