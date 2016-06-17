//
//  CustomTabBarController.m
//  JSNormalApp
//
//  Created by DaisyNew on 16/6/2.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import "CustomTabBarController.h"
#import "HomeVC.h"
#import "MineVC.h"


@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化视图控制器
    [self initView];
}

- (void)initView{
    
    HomeVC *hvc = [[HomeVC alloc]init];
    MineVC *mvc = [[MineVC alloc]init];
    
    NSMutableArray *titleArr        = [NSMutableArray arrayWithObjects:@"首页",@"我的", nil];
    NSMutableArray *normalImgArr    = [NSMutableArray arrayWithObjects:@"img1",@"img2", nil];;
    NSMutableArray *HilightedImgArr = [NSMutableArray arrayWithObjects:@"img1_h",@"img2_h", nil];;
    NSMutableArray *vcArr           = [NSMutableArray arrayWithObjects:hvc,mvc, nil];
    
    [self setupRootViewControllers:vcArr withTitle:titleArr withDefultImage:normalImgArr withSelectImage:HilightedImgArr];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end