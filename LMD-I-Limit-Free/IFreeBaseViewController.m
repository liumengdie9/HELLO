//
//  IFreeBaseViewController.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "IFreeBaseViewController.h"

@interface IFreeBaseViewController ()

@end

@implementation IFreeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationTitleWithTitle:self.title];
}

- (void)addNavgationTitleWithTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithRed:30/255.f green:160/255.f blue:230/255.f alpha:1];
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:25];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}

- (void)addNavgationItemWithTitle:(NSString *)title aSelector:(SEL)aSelector isLeft:(BOOL)isLeft
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (aSelector) {
        if ([self respondsToSelector:aSelector]) {
            [button addTarget:self action:aSelector forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft)
        self.navigationItem.leftBarButtonItem = barButtonItem;
    else
        self.navigationItem.rightBarButtonItem = barButtonItem;
            
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
