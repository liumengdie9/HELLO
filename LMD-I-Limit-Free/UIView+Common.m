
//
//  UIView+Common.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

CGFloat screenWidth()
{
    return [[UIScreen mainScreen] bounds].size.width;
}

CGFloat screenHeight()
{
    return [[UIScreen mainScreen] bounds].size.height;
}

CGFloat maxX(UIView *view)
{
    return CGRectGetMaxX(view.frame);
}

CGFloat maxY(UIView *view)
{
    return CGRectGetMaxY(view.frame);
}

CGFloat minX(UIView *view)
{
    return CGRectGetMinX(view.frame);
}


CGFloat minY(UIView *view)
{
    return CGRectGetMinY(view.frame);
}

CGFloat width(UIView *view)
{
    return CGRectGetWidth(view.frame);
}

CGFloat height(UIView *view)
{
    return CGRectGetHeight(view.frame);
}
















@end
