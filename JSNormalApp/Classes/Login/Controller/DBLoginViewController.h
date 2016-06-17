//
//  DBLoginViewController.h
//  danbai_client_ios
//
//  Created by dbjyz on 15/6/23.
//  Copyright (c) 2015年 db. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SuccessLoginBlock)(id userinfo);

/** 登陆页面 弹出方式 */
@interface DBLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, copy)SuccessLoginBlock successLoginBlock;     // 登录成功后的回调

@end
