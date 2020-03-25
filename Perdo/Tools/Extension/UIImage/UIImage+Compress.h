//
//  UIImage+Compress.h
//  BeePai
//
//  Created by LKCZ on 2019/12/12.
//  Copyright © 2019 BeePlay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Compress)

/** 快速压缩 压缩到大约指定体积大小(kb) 返回压缩后图片 */
- (UIImage *)fastestCompressImageWithSize:(CGFloat)size;
- (UIImage *)fastestCompressImageWithSize:(CGFloat)size imageSize:(NSUInteger)imageSize;
/** 快速压缩 压缩到大约指定体积大小(kb) 返回data, 小于size指定大小，返回nil */
- (NSData *)fastestCompressImageDataWithSize:(CGFloat)size;
- (NSData *)fastestCompressImageDataWithSize:(CGFloat)size imageSize:(NSUInteger)imageSize;
- (NSData *)fastestCompressAnimatedImageDataWithScaleRatio:(CGFloat)ratio;

@end

NS_ASSUME_NONNULL_END
