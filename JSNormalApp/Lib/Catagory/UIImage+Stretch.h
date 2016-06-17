//
//  UIImage+Stretch.h
//  danbai_client_ios
//
//  Created by dbjyz on 15/6/13.
//  Copyright (c) 2015年 db. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ImageIO/ImageIO.h>
#define kMaxWidth 400.0f
#define kMaxHeight 400.0f
#define MAXImageSize 50.0 //kb

@interface UIImage (Stretch)
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 *  设置Image背景颜色
 */
+ (UIImage *)createImageWithColor: (UIColor *)color;

/**
 *  对图片尺寸进行压缩
 */
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;


/** 长宽比 */
-(float)hwBI;
+(UIImage*)newBoundImage:(NSString*)imgName;


/** 压缩图片至指定尺寸 */
-(UIImage*) scaleToSize:(CGSize)size;
-(UIImage*) thumbImage;
-(UIImage*) screenSizeImage;


/** 长调整方向 */
-(UIImage *)fixOrientation:(UIImageOrientation)orientation;


-(UIImage*)subImageFromTop;


/** 取图片的头 */
-(UIImage*)subImageFromHeader;

/** 取图片的中间 */
-(UIImage*)subImageFromCenter;

/** 取图的右边 */
-(UIImage*)subImageFromFoot;
-(UIImage*)GetSubImageByRect:(CGRect)r;
//-(NSDictionary*)getInfo;
//
- (NSString *)contentTypeForImageData;
-(UIImage *)rotateImage;
-(UIImage *)rotateImageByLeft90degree;

-(UIImage*)rotateImage:(int)degree;
- (UIImage *)telescopicImageToSize:(CGSize)size; //按比例

//处理图片旋转问题（判断图片方向）
+(UIImage *)chageImage:(UIImage *)aImage;





@end
