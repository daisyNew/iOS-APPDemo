//
//  UIImage+Stretch.m
//  danbai_client_ios
//
//  Created by dbjyz on 15/6/13.
//  Copyright (c) 2015年 db. All rights reserved.
//

#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)
//返回一张自由拉伸的图片

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

//用颜色生成图片
+ (UIImage *)createImageWithColor: (UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}




//压缩图片至指定尺寸
-(UIImage*) scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0.0, 0.0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


//调整方向
-(UIImage *)fixOrientation:(UIImageOrientation)orientation{
    if (self == nil) {
        return nil;
    }
    CGImageRef imgRef = self.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    
    UIImageOrientation orient = self.imageOrientation;
    switch(orientation)
    {
        case UIImageOrientationUp: //EXIF = 1
        {
            transform = CGAffineTransformIdentity;
            break;
        }
        case UIImageOrientationUpMirrored: //EXIF = 2
        {
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        }
        case UIImageOrientationDown: //EXIF = 3
        {
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        }
        case UIImageOrientationDownMirrored: //EXIF = 4
        {
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        }
        case UIImageOrientationLeftMirrored: //EXIF = 5
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        }
        case UIImageOrientationLeft: //EXIF = 6
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        }
        case UIImageOrientationRightMirrored: //EXIF = 7
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        }
        case UIImageOrientationRight: //EXIF = 8
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        }
        default:
        {
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            break;
        }
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
    
}
//替换 imageNamed
+(UIImage*)newBoundImage:(NSString*)imgName{
    NSString *path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
    UIImage *temp = [[UIImage alloc] initWithContentsOfFile:path];
    return temp;
}

-(UIImage*)GetSubImageByRect:(CGRect)r{
    CGImageRef imageRef = self.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, r);
    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
    CFRelease(subImageRef);
    return subImage;
}
-(UIImage*)subImageFromTop{
    CGSize sz=self.size;
    CGRect rect;
    if (sz.width>sz.height) {
        return self;
    }else {
        rect=CGRectMake(0, 0, sz.width, sz.width);
    }
    return [self GetSubImageByRect:rect];
}
//取图片的头
-(UIImage*)subImageFromHeader{
    CGSize sz=self.size;
    CGRect rect;
    if (sz.width>sz.height) {
        rect=CGRectMake(0, 0, sz.height, sz.height);
    }else {
        rect=CGRectMake(0, 0, sz.width, sz.width);
    }
    return [self GetSubImageByRect:rect];
}
//取图片的中间
-(UIImage*)subImageFromCenter{
    CGSize sz=self.size;
    CGRect rect;
    if (sz.width>sz.height) {
        rect=CGRectMake((sz.width-sz.height)/2, 0, sz.height, sz.height);
    }else {
        rect=CGRectMake(0, (sz.height-sz.width)/2, sz.width, sz.width);
    }
    return [self GetSubImageByRect:rect];
}
//取图的右边
-(UIImage*)subImageFromFoot{
    CGSize sz=self.size;
    CGRect rect;
    if (sz.width>sz.height) {
        rect=CGRectMake(sz.width-sz.height, 0, sz.height, sz.height);
    }else {
        rect=CGRectMake(0, sz.height-sz.width, sz.width, sz.width);
    }
    return [self GetSubImageByRect:rect];
}
//-(NSDictionary*)getInfo{
//    NSData *dataOfImageFromGallery = UIImageJPEGRepresentation (self,0.5);
//    CGImageSourceRef source;
//    source = CGImageSourceCreateWithData((CFDataRef)dataOfImageFromGallery, NULL);
//    
//    NSDictionary *metadata = (NSDictionary *) CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
//    CFRelease(source);
//    NSMutableDictionary *metadataAsMutable = [[metadata mutableCopy]autorelease];
//    [metadata release];
//    
//    //NSMutableDictionary *EXIFDictionary = [[[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyExifDictionary]mutableCopy]autorelease];
//    //    NSMutableDictionary *GPSDictionary = [[[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyGPSDictionary]mutableCopy]autorelease];
//    return metadataAsMutable;
//}

-(float)hwBI{
    return self.size.width/self.size.height;
}
/**
 - (NSString *)contentTypeForImageData{
 CGImageRef img = self.CGImage;
 NSData* data = CGDataProviderCreateWithCFData((CFDataRef)img);
 uint8_t c;
 [data getBytes:&c length:1];
 switch (c) {
 case 0xFF:
 return @"image/jpeg";
 case 0x89:
 return @"image/png";
 case 0x47:
 return @"image/gif";
 case 0x49:
 case 0x4D:
 return @"image/tiff";
 }
 return nil;
 }
 */
-(UIImage *)rotateImageByLeft90degree
{
    
    CGImageRef imgRef = self.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGFloat scaleRatio = 1;
    
    transform = CGAffineTransformMakeTranslation(width, 0.0);
    
    transform = CGAffineTransformScale(transform, -1.0, 1.0);
    
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextScaleCTM(context, -scaleRatio, scaleRatio);
    CGContextTranslateCTM(context, -height, 0);
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGContextRestoreGState(context);
    return imageCopy;
    
}

-(UIImage *)rotateImage
{
    
    CGImageRef imgRef = self.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGFloat scaleRatio = 1;
    
    CGFloat boundHeight;
    
    UIImageOrientation orient = self.imageOrientation;
    
    switch(orient)
    
    {
            
        case UIImageOrientationUp: //EXIF = 1
            
            transform = CGAffineTransformIdentity;
            
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            
            transform = CGAffineTransformMakeTranslation(width, height);
            
            transform = CGAffineTransformRotate(transform, M_PI);
            
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            
            transform = CGAffineTransformMakeTranslation(0.0, height);
            
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, width);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(0.0, width);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
        default:
            
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        
        CGContextTranslateCTM(context, -height, 0);
        
    }
    
    else {
        
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        
        CGContextTranslateCTM(context, 0, -height);
        
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageCopy;
    
}
-(UIImage*)rotateImage:(int)degree{
    if (degree%360==0) {
        return self;
    }
    CGImageRef imgRef = self.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGFloat arc = degree*M_PI/180;
    int newWidth = width;
    int newheight = height;
    if (degree%180!=0) {
        newWidth = height;
        newheight = width;
    }
    UIGraphicsBeginImageContext(CGRectMake(0, 0, newWidth, newheight).size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, newWidth/2, newheight/2);
    CGContextRotateCTM(context, arc);
    CGContextScaleCTM(context,1,-1);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(-width/2, -height/2, width, height), imgRef);
    
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageCopy;
}



-(UIImage *)screenSizeImage
{
    CGFloat h = self.size.height;
    CGFloat w = self.size.width;
    if (h==0.0f || w == 0.0f) {
        return nil;
    }
    CGFloat maxH = 960;
    CGFloat maxW = 640;
    
    if (h>w) {
        if (h > maxH) {
            CGFloat ratio = maxH / h;
            w *= ratio;
            h = maxH;
        }
    }else{
        if (w > maxW) {
            CGFloat ratio = maxW / w;
            h *= ratio;
            w = maxW;
        }
    }
    
    return [self scaleToSize: CGSizeMake(w, h)];
}

-(UIImage *)thumbImage
{
    CGFloat h = self.size.height;
    CGFloat w = self.size.width;
    if (h==0.0f || w == 0.0f) {
        return nil;
    }
    if (h>w) {
        if (h > kMaxHeight) {
            CGFloat ratio = kMaxHeight / h;
            w *= ratio;
            h = kMaxHeight;
        }
    }else{
        if (w > kMaxWidth) {
            CGFloat ratio = kMaxWidth / w;
            h *= ratio;
            w = kMaxWidth;
        }
    }
    
    return [self scaleToSize: CGSizeMake(w, h)];
}


- (UIImage *)telescopicImageToSize:(CGSize)size

{
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


+(UIImage *)chageImage:(UIImage *)aImage{
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;

    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;

}




@end
