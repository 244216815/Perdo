//
//  IndexAddStudentView.h
//  Perdo
//
//  Created by 一招 on 2020/3/26.
//  Copyright © 2020 Perdo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertThreeView : UIView

@property (weak, nonatomic) IBOutlet UIView *studentView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

-(void)configLabelTextOne:(NSString *)textOne textTwo:(NSString *)textTwo;
@property (nonatomic, copy) void(^addActionBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
