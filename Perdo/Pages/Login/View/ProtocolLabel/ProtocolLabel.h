//
//  ProtocolLabel.h
//  BeePai
//
//  Created by beice on 2019/1/5.
//  Copyright © 2019 BeePlay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ProtocolTap)(int index);

@interface ProtocolLabel : YYLabel

@property (nonatomic ,copy)ProtocolTap ProtocolTapBlock;

@end

NS_ASSUME_NONNULL_END
