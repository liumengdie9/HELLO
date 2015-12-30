//
//  UIView+Common.h
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)
//返回屏幕的宽和高
CGFloat screenWidth();

CGFloat screenHeight();

CGFloat maxX(UIView *view);
CGFloat maxY(UIView *view);
CGFloat minX(UIView *view);
CGFloat minY(UIView *view);


CGFloat width(UIView *view);
CGFloat height(UIView *view);

@end
