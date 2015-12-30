//
//  applicationView.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "applicationView.h"
#import "iStarsView.h"
#import "UIView+Common.h"
#import <UIImageView+WebCache.h>
#import "subjectModel.h"
@implementation applicationView
{

    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    iStarsView *_istartView;
    UIImageView *_downLoadImageView;
    UILabel *_downsLabel;
    UIImageView *_share;
    UILabel *_shareLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customViews];
    }
    return self;
}

- (void)customViews
{
    _iconImageView = [UIImageView new];
    _titleLabel = [UILabel new];
//    _titleLabel.backgroundColor = [UIColor orangeColor];
    _istartView =[iStarsView new];
    _downLoadImageView = [UIImageView new];
    _downsLabel = [UILabel new];
    _share = [UIImageView new];
    _shareLabel = [UILabel new];
    
    [self addSubview:_share];
    [self addSubview:_shareLabel];
    [self addSubview:_iconImageView];
    [self addSubview:_titleLabel];
    [self addSubview:_istartView];
    [self addSubview:_downsLabel];
    [self addSubview:_downLoadImageView];

}

- (void)setModel:(applications *)model
{
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:nil];
    _downLoadImageView.image = [UIImage imageNamed:@"topic_Download"];
    
    _titleLabel.text = model.name;
    _downsLabel.text = model.downloads;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _downsLabel.font = [UIFont systemFontOfSize:10];
    
    _shareLabel.font = [UIFont systemFontOfSize:10];
    
    [_istartView setLeveal:[model.starOverall doubleValue]];
    
    _share.image = [UIImage imageNamed:@"topic_Comment"];
    _shareLabel.text = model.ratingOverall;

}



-(void)resetPostion{
    
    CGFloat leftpading = 0;
    CGFloat topadding = 0;
    CGFloat padding = 10;
    
    _iconImageView.frame = CGRectMake(leftpading, topadding, 50, 50);
    
    _titleLabel.frame = CGRectMake(maxX(_iconImageView)+padding,0, width(self)-width(_iconImageView), 25);
    
    _share.frame = CGRectMake(maxX(_iconImageView)+padding, maxY(_titleLabel),15, 6+padding/4);
    
    _shareLabel.frame = CGRectMake(maxX(_share), maxY(_titleLabel),40, 6+padding/4);
    
    _istartView.frame = CGRectMake(maxX(_iconImageView) + padding, maxY(_titleLabel)+padding, 65, 23);
    
    _downLoadImageView.frame = CGRectMake(maxX(_istartView)+padding, maxY(_titleLabel)+padding/4, 8, 8);
    
    _downsLabel.frame = CGRectMake(maxX(_downLoadImageView)+padding, maxY(_titleLabel)+padding/4, width(self)-maxX(_downLoadImageView)-padding, 6+padding/4);
}
























@end

