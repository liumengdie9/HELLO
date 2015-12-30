//
//  IFreeTabBarController.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "IFreeTabBarController.h"
#import "IFreeApplistViewController.h"
#import "KillAllDefine.h"
#import "UIView+Common.h"
@interface IFreeTabBarController ()

@end

@implementation IFreeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSplashView];
    [self createViewControllers];
    
}

- (void)createViewControllers
{
    NSString *plistpath = [[NSBundle mainBundle] pathForResource:@"Controllers" ofType:@"plist"];
    NSArray *vcArrays = [[NSArray alloc] initWithContentsOfFile:plistpath];
    NSArray *urlArray = @[kLimitUrl, kReduceUrl, kFreeUrl, kSubjectUrl, kHotUrl];
    NSArray *categoryType = @[kLimitType,kReduceType,kFreeType,kSubjectType,kHotType];
    NSMutableArray *controllers = [NSMutableArray new];
    int i = 0;
    
    for (NSDictionary *dict in vcArrays) {
        
        Class class = NSClassFromString(dict[@"className"]);
        IFreeApplistViewController *controller = [[class alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        controller.tabBarItem.image = [UIImage imageNamed:dict[@"iconName"]];
        controller.title = dict[@"title"];
        controller.requestURL = urlArray[i];
        controller.categoryType = categoryType[i++];
        
        [controllers addObject:nav];
        
    }
    
    self.viewControllers = controllers;
}

- (void)createSplashView
{
    UIImageView *imageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight())];
    NSString *splashPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Default%d@2x",arc4random_uniform(3)+1] ofType:@"png"];
    imageView.image = [[UIImage alloc] initWithContentsOfFile:splashPath];
    [self.view addSubview:imageView];
    [UIView animateWithDuration:1 animations:^{
        
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end









































