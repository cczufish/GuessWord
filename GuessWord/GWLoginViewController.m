//
//  GWLoginViewController.m
//  GuessWord
//
//  Created by Dannion on 13-12-17.
//  Copyright (c) 2013年 BUPTMITC. All rights reserved.
//

#import "GWLoginViewController.h"
#import "GWGridViewController.h"
#import "GWNetWorkingWrapper.h"
#import "GWAccountStore.h"

@interface GWLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usenameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)pressLoginBtn:(id)sender;
- (IBAction)pressGuessLoginBtn:(id)sender;
- (IBAction)pressRegisterBtn:(id)sender;


@end

@implementation GWLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViewBackgroundView];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [self colorForBackground];
    self.passwordTextField.secureTextEntry = YES;
    
}

- (void)addViewBackgroundView
{
    UIView* backgroundAllView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    backgroundAllView.backgroundColor = [self colorForBackground];
    [self.view addSubview:backgroundAllView];
    [self.view sendSubviewToBack:backgroundAllView];
    
    UIButton* backgroundButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    backgroundButton.isAccessibilityElement = NO;
    backgroundButton.backgroundColor = [UIColor clearColor];
    [backgroundButton addTarget:self action:@selector(tapRequest) forControlEvents:UIControlEventTouchUpInside];
    [backgroundAllView addSubview:backgroundButton];
}

- (void)tapRequest
{
    for (UIView* aView in self.view.subviews) {
        [aView resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"LoginToGrid"]) {
        GWGridViewController *destination = segue.destinationViewController;
        if ([destination respondsToSelector:@selector(setUniqueID:)])
        {
            destination.volNumber = @101001;
            destination.level = 0;
        }
    }
}


- (IBAction)pressLoginBtn:(id)sender
{
    NSString* usename;
    NSString* password;
    if (self.usenameTextField) {
        if (self.usenameTextField.text.length>0) {
            usename = self.usenameTextField.text;
        }
    }
    if (self.passwordTextField) {
        if (self.passwordTextField.text.length>0) {
            password = self.passwordTextField.text;
        }
    }
    
    if (usename && password) {
        [self loginWithUsername:usename andPassword:password];
    }else{
        [self showToastWithDescription:@"用户名或密码不能为空"];
    }
}

- (IBAction)pressGuessLoginBtn:(id)sender
{
    [self performSegueWithIdentifier:@"LoginToGrid" sender:sender];
}

- (IBAction)pressRegisterBtn:(id)sender {
    [self performSegueWithIdentifier:@"LoginToRegister" sender:sender];
}



#pragma mark -
#pragma mark Internal Method

- (void)loginWithUsername:(NSString*)usename andPassword:(NSString*)password
{
//    示例：10.105.00.00/register?username=hh&password=123
    NSMutableDictionary* paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:usename forKey:@"id"];
    [paraDic setObject:password forKey:@"pw"];
    
    [GWNetWorkingWrapper getPath:@"login" parameters:paraDic successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if ([responseString isEqualToString:@"Success!"]) {//登陆成功
            
            [[GWAccountStore shareStore] saveToLocalCacheWithUsername:usename andPassword:password];
            [self performSegueWithIdentifier:@"LoginToGrid" sender:nil];
        }else{//登陆失败
            
            [self showToastWithDescription:responseString];
        }
        
        
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self showToastWithDescription:error.localizedDescription];
        
    }];
    
}

- (void)showToastWithDescription:(NSString*)description
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color = [UIColor whiteColor];
    hud.labelTextColor = [UIColor blueColor];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = description;
    [hud hide:YES afterDelay:1.5];
}


#pragma mark -
#pragma mark Image & Color Method

- (UIColor*)colorForBackground
{
    return [UIColor colorWithRed:234.0/256 green:234.0/256 blue:234.0/256 alpha:1.0];
}

@end
