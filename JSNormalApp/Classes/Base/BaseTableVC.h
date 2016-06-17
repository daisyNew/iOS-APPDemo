//
//  BaseTableVC.h
//  youxue
//
//  Created by DaisyNew on 16/5/13.
//  Copyright © 2016年 决胜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface BaseTableVC : BaseVC


/**
 *是否添加下拉刷新上拉加载控件, 默认不添加 在子类ViewDidLoad之前设置
 */
@property (nonatomic, assign) BOOL isAddPullDownControl;
@property (nonatomic, assign) BOOL isAddPullUpControl;

/** 设置MJ*/
- (void)setupRefresh;

/** 下拉刷新*/
- (void)pullDownToRefresh;

/** 上拉加载*/
- (void)pullUpToRefresh;

/** 停止更新*/
- (void)stopRefresh;

@end
