//
//  IndexAddTeacherView.h
//  Perdo
//
//  Created by 一招 on 2020/3/26.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertFourView : UIView

@property (weak, nonatomic) IBOutlet UIView *teacherView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

-(void)configLabelTextOne:(NSString *)textOne textTwo:(NSString *)textTwo texThree:(NSString *)textThree;
@property (nonatomic, copy) void(^addActionBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
