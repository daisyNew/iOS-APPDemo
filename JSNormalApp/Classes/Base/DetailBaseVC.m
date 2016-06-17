//
//  DetailBaseVC.m
//  youxue
//
//  Created by DaisyNew on 16/5/13.
//  Copyright © 2016年 决胜. All rights reserved.
//

#import "DetailBaseVC.h"

@interface DetailBaseVC ()

@end

@implementation DetailBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavBack];

}

- (void)initNavBack{
    
    UIButton *btnLeft         = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 19, 24)];
    [btnLeft setImage:[UIImage imageNamed:@"back_indicator.png"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    [self.navigationItem setLeftBarButtonItem:itemLeft];
}

- (void)btnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
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
