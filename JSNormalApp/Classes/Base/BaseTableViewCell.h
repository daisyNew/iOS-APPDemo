//
//  BaseTableViewCell.h
//  youxue
//
//  Created by DaisyNew on 16/5/13.
//  Copyright © 2016年 决胜. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
   cell的基类，一般设置cell数据
 */
@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id               model;
@property (nonatomic, weak  ) UIViewController *viewController;


//返回cell高度
+ (CGFloat)cellHeightWithModel:(id )model;

//获取动态高度
+ (CGFloat)getTextSizeHeight:(NSString*)string UIFont:(int)font Width:(CGFloat)width lineSpace:(NSInteger)lineSpace;

@end
