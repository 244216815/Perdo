//
//  ProtocolLabel.m
//  BeePai
//
//  Created by beice on 2019/1/5.
//  Copyright © 2019 BeePlay. All rights reserved.
//

#import "ProtocolLabel.h"

static NSString *const strProtocol = @"登录即代表同意一招《用户协议及隐私政策》";

@implementation ProtocolLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBaseView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createBaseView];
    }
    return self;
}

- (void)createBaseView{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:strProtocol];
    [attributedStr setColor:UIColor_333333];
    [attributedStr setFont:[UIFont systemFontOfSize:12.0f]];
    [attributedStr setAttributes:@{NSForegroundColorAttributeName:UIColorHex(33c66b),NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0f]} range:NSMakeRange(@"登录即代表同意一招".length, @"《用户协议及隐私政策》".length)];
//    [attributedStr setColor:UIColor_333333 range:[strProtocol rangeOfString:@"《隐私政策》"]];
    YYTextHighlight *highlight = [YYTextHighlight new];
    @weakify(self);
    highlight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
         @strongify(self);
         if (self.ProtocolTapBlock) {
            self.ProtocolTapBlock(0);
         }
    };
    [attributedStr setTextHighlight:highlight range:[strProtocol rangeOfString:@"《用户协议及隐私政策》"]];
//    YYTextHighlight *pricyHighlight = [YYTextHighlight new];
//    pricyHighlight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        @strongify(self);
//        if (self.ProtocolTapBlock) {
//            self.ProtocolTapBlock(1);
//        }
//    };
//    [attributedStr setTextHighlight:pricyHighlight range:[strProtocol rangeOfString:@"《隐私政策》"]];
    self.attributedText = attributedStr;
    self.textAlignment = NSTextAlignmentCenter;
}

@end
