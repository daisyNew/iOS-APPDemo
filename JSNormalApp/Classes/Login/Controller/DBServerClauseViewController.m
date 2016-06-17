//
//  DBServerClauseViewController.m
//  danbai_client_ios
//
//  Created by dbjyz on 15/8/20.
//  Copyright (c) 2015年 db. All rights reserved.
//  

#import "DBServerClauseViewController.h"

@interface DBServerClauseViewController ()
@property (weak, nonatomic) IBOutlet UITextView *serverText;

@end

@implementation DBServerClauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"蛋白服务条款";
    self.serverText.editable = NO;
    
    [self.serverText setContentOffset:CGPointMake(0, -200) animated:YES];
    self.serverText.bouncesZoom = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"jiantou"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

-(void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
