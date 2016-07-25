//
//  BaseTableVC.m
//  youxue
//
//  Created by DaisyNew on 16/5/13.
//  Copyright © 2016年 决胜. All rights reserved.
//

#import "BaseTableVC.h"
#import "MJRefresh.h"


@interface BaseTableVC ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];


    [self setupRefresh];
}

- (void)setupRefresh{
    
    if (_isAddPullDownControl == YES) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self pullDownToRefresh];
        }];
     }
    
    if (_isAddPullUpControl == YES) {
        
        self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
            
            [self pullUpToRefresh];
        }];
    }
}


/** 下拉刷新*/
- (void)pullDownToRefresh{
    
}

/** 上拉加载*/
- (void)pullUpToRefresh{
   
}

- (void)stopRefresh{
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
