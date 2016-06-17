//
//  BaseTableViewCell.m
//  youxue
//
//  Created by DaisyNew on 16/5/13.
//  Copyright © 2016年 决胜. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

//cell高度
+ (CGFloat)cellHeightWithModel:(id)model{
    CGFloat height = 0;
    return height;
}

+ (CGFloat)getTextSizeHeight:(NSString*)string UIFont:(int)font Width:(CGFloat)width lineSpace:(NSInteger)lineSpace
{
    //获取文本

    CGSize size                             = CGSizeMake(width, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing              = lineSpace;
    NSDictionary *attributeDic              = @{NSFontAttributeName: [UIFont systemFontOfSize:font],
                                      NSParagraphStyleAttributeName: paragraphStyle};

    CGRect textRect                         = [string boundingRectWithSize:size
                                           options:NSStringDrawingTruncatesLastVisibleLine
                                                   |NSStringDrawingUsesLineFragmentOrigin |
                                                    NSStringDrawingUsesFontLeading
                                        attributes:attributeDic
                                           context:nil];

    return textRect.size.height;
}

@end
