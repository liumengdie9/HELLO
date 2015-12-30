//
//  iStarsView.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "iStarsView.h"

@implementation iStarsView
{
    UIImageView *_foreView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customeViews];
    }
    return self;
}

- (void)customeViews
{
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 23)];
    backView.image = [UIImage imageNamed:@"StarsBackground"];
    
    [self addSubview:backView];
    
    _foreView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _foreView.contentMode = UIViewContentModeLeft;
    
    _foreView.clipsToBounds = YES;
    
    _foreView.image = [UIImage imageNamed:@"StarsForeground"];
    [self addSubview:_foreView];
}

- (void)setLeveal:(double)leverl
{
    _foreView.frame = CGRectMake(0, 0, 65*(leverl/5.00), 23);
}

@end
