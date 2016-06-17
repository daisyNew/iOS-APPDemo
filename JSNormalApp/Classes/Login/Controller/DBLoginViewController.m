//
//  DBLoginViewController.m
//  danbai_client_ios
//
//  Created by dbjyz on 15/6/23.
//  Copyright (c) 2015年 db. All rights reserved.
//

#import "DBLoginViewController.h"
#import "CustomTabBarController.h"
#import "DBServerClauseViewController.h"
#import "NSString+Tools.h"
#import "UserModel.h"

@interface DBLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *accountBgImg;
@property (weak, nonatomic) IBOutlet UITextField *accountText;

@property (weak, nonatomic) IBOutlet UIImageView *passwordBgImg;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UIButton *verificationBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation DBLoginViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *patternImage = [UIImage imageNamed:@"dan_bg"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    //设置属性
    [self setupProperty];
    
    [self setupKeyboard];
}

#pragma mark --notifications
/**
 *  监听键盘的通知
 */
-(void)setupKeyboard{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//键盘即将显示的时候调用
-(void)keyboardWillShow:(NSNotification *)note{
    
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (self.passwordText.frame.origin.y+self.passwordText.frame.size.height+100) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
}

//键盘即将退出的时候调用
-(void)keyboardWillHide:(NSNotification *)note{
    // 键盘动画时间
    double duration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}


#pragma mark 设置属性
-(void)setupProperty {
    
    self.accountBgImg.layer.borderWidth = 1.0;
    self.accountBgImg.layer.borderColor = [UIColor redColor].CGColor;
    self.accountBgImg.layer.cornerRadius = 5.0;
    self.accountBgImg.layer.masksToBounds = YES;
    
    self.passwordBgImg.layer.borderWidth = 1.0;
    self.passwordBgImg.layer.borderColor = [UIColor redColor].CGColor;
    self.passwordBgImg.layer.cornerRadius = 5.0;
    self.passwordBgImg.layer.masksToBounds = YES;
    
    self.verificationBtn.layer.borderWidth = 1.0;
    self.verificationBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.verificationBtn.layer.cornerRadius = 5.0;
    self.verificationBtn.layer.masksToBounds = YES;
    [self.verificationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.startBtn.layer.borderWidth = 1.0;
    self.startBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.startBtn.layer.cornerRadius = 5.0;
    self.startBtn.layer.masksToBounds = YES;
    [self.startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.startBtn.backgroundColor = [UIColor orangeColor];
}


#pragma mark 获取验证码点击事件
- (IBAction)getVerificationButton:(UIButton *)sender {
    
    //验证是不是手机号
    if(![self.accountText.text validateMobile]){
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入正确的手机号码";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:3];
        
        return;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.accountText.text;
    params[@"verificationMethod"] = @"0";
    
    
    //发送验证码
    [HttpTool postWithURL:SendCode
                   params:params success:^(id json) {
                       
                       NSString *code = [json objectForKey:@"code"];
                       
                       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                       hud.mode = MBProgressHUDModeCustomView;
                       
                       if ([code isEqualToString:@"0"]) {
                           
                           [self timer];
                           hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                           hud.labelText = @"发送成功";
                       }else {
                           
                           hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                           hud.labelText = @"发送失败";
                       }
                       
                       [hud show:YES];
                       [hud hide:YES afterDelay:2];
 
                       
                       
                   } failure:^(NSError *error) {
                       
                       UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误" message:@"验证码发送失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                       [alertView show];
                       
                       
                   }];
}

#pragma mark 登录点击事件
- (IBAction)startButton:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    //判断是否输入正确信息
    if(sender == self.startBtn){
        NSString *errMsg = nil;
        if (self.accountText.text.length == 0 || self.passwordText.text.length == 0) {
            errMsg = @"手机号码和验证码不能为空";
        }else if(![self.accountText.text validateMobile]){
            errMsg = @"请输入正确的手机号码";
        }else if(self.passwordText.text.length != 6){
            errMsg = @"验证码错误";
        }
        
        if(errMsg != nil){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errMsg
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.accountText.text;
    params[@"verificationCode"] = self.passwordText.text;

    [HttpTool postWithURL:LoginAndRegister
                   params:params success:^(id json) {
                       
                       NSString *code = [json objectForKey:@"code"];
   
                       if ([code isEqualToString:@"0"]) {
                           
                           // 先将字典转为模型
                           NSDictionary *dataDic = [json objectForKey:@"data"];
                           UserModel *model = [[UserModel alloc] init];
                           
                           if ((NSNull *)dataDic[@"uname"] == [NSNull null]) {
                               model.username = @"";
                           }else {
                               model.username = dataDic[@"uname"];
                           }
                           
                           if ((NSNull *)dataDic[@"img"] == [NSNull null]) {
                               model.avatar = @"";
                           }else {
                               model.avatar = dataDic[@"img"];
                           }
                           
                           model.uid = dataDic[@"id"];
                           [model save];
                           
                           if (self.successLoginBlock) {
                               self.successLoginBlock(nil);
                           }
                           
                           
                           self.view.window.rootViewController = [[CustomTabBarController alloc]init];
                           [hud hide:YES];
                           
                       }else {
                           [hud hide:YES];
                           UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[json objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                           [alertView show];
                       }
                       
                   } failure:^(NSError *error) {
                      
                       hud.mode = MBProgressHUDModeText;
                       hud.labelText = @"网络异常";
                       hud.margin = 10.f;
                       hud.removeFromSuperViewOnHide = YES;
                       [hud hide:YES afterDelay:3];
                   }];
}

#pragma mark 设置定时器
-(void)timer{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                [self.verificationBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
                self.verificationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
                [self.verificationBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.verificationBtn.userInteractionEnabled = YES;
                [self.verificationBtn addTarget:self action:@selector(getVerificationButton:) forControlEvents:UIControlEventTouchUpInside];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.verificationBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
                self.verificationBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                [self.verificationBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                self.verificationBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)closeBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)serverButton {
    
     DBServerClauseViewController *serverView = [[DBServerClauseViewController alloc]init];
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:serverView];
    [self presentViewController:nav animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


@end
