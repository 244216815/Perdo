

#import <UIKit/UIKit.h>

extern __attribute__((overloadable)) NSData * BEE_UIImageGIFRepresentation(UIImage *image);

extern __attribute__((overloadable)) NSData * BEE_UIImageGIFRepresentation(UIImage *image, NSTimeInterval duration, NSUInteger loopCount, NSError * __autoreleasing *error);

extern __attribute__((overloadable)) NSData * BEE_UIImagePNGRepresentation(UIImage *image, CGFloat compressionQuality);

extern __attribute__((overloadable)) NSData * BEE_UIImageJPEGRepresentation(UIImage *image, CGFloat compressionQuality);

extern __attribute__((overloadable)) NSData * BEE_UIImageRepresentation(UIImage *image, CGFloat compressionQuality, CFStringRef __nonnull type, NSError * __autoreleasing *error);
