//
//  appCell.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "appCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+Common.h"
#import "KillAllDefine.h"
#import "iStarsView.h"
@implementation appCell
{

    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UILabel *_middleLabel;
    UILabel *_priceLabel;
    UILabel *_shareLabel;
    iStarsView *_starsView;
    
    UILabel *_lineLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customView];
    }
    return self;
}

- (void)customView
{
    _iconImageView = [UIImageView new];
    _iconImageView.layer.cornerRadius = 10;
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _middleLabel = [UILabel new];
    _middleLabel.font = [UIFont systemFontOfSize:12];
    _middleLabel.textColor = [UIColor lightGrayColor];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:16];
    _priceLabel.textColor = [UIColor grayColor];
    
    _shareLabel = [UILabel new];
    _shareLabel.font = [UIFont systemFontOfSize:13];
    _shareLabel.textColor = [UIColor lightGrayColor];
    
    _starsView = [iStarsView new];
    
    _lineLabel = [UILabel new];
    _lineLabel.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:_iconImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_middleLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_shareLabel];
    [self.contentView addSubview:_starsView];
    [self.contentView addSubview:_lineLabel];
}


- (void)setModel:(AppModel *)model
{
    _model = model;
    UIImage *image = [UIImage imageNamed:@"icon"];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:image];
    _titleLabel.text = model.name;
    
    _priceLabel.text = [NSString stringWithFormat:@"￥:%@", model.lastPrice];
    
    if ([model.priceTrend isEqualToString:kLimitType]) {
        
        NSArray *strings = [model.expireDatetime componentsSeparatedByString:@" "];
        if (strings.count == 2) {
            _middleLabel.text = [NSString stringWithFormat:@"剩余时间:%@", strings[1]];
        }
        _lineLabel.hidden = NO;
    
    }else if ([model.priceTrend isEqualToString:kReduceType]){
        _middleLabel.text = [NSString stringWithFormat:@"现价:￥%@", model.currentPrice];
         _lineLabel.hidden = NO;
        
    }else if ([model.priceTrend isEqualToString:kFreeType]){
        _middleLabel.text = [NSString stringWithFormat:@"评分:%@分", model.starCurrent];
         _lineLabel.hidden = YES;
        
    }else if ([model.priceTrend isEqualToString:kHotType]){
        _middleLabel.text = [NSString stringWithFormat:@"评分:%@分", model.starCurrent];
         _lineLabel.hidden = YES;
    }
    
    _shareLabel.text = [NSString stringWithFormat:@"分享: %@     收藏: %@     下载: %@", model.shares, model.favorites, model.downloads];
    
    [_starsView setLeveal:[model.starCurrent doubleValue]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftPadding = 14;
    CGFloat topPadding= 10;
    CGFloat padding = 10;
    
    _iconImageView.frame = CGRectMake(leftPadding, topPadding, 60, 60);
    
    _titleLabel.frame = CGRectMake(maxX(_iconImageView) + padding, topPadding, width(self.contentView) - maxX(_iconImageView) - 2*padding, 20);
    
    _lineLabel.frame = CGRectMake(0, 0, width(_priceLabel) + 10, 1);
    _lineLabel.center = _priceLabel.center;

    _priceLabel.frame = CGRectMake(width(self.contentView) - 50 - padding, maxY(_titleLabel) + padding, 50, 20);
    
    _middleLabel.frame = CGRectMake(minX(_titleLabel), maxY(_titleLabel), width(self.contentView) - minX(_titleLabel) - width(_priceLabel) - padding, 13);
    
    _shareLabel.frame = CGRectMake(leftPadding, maxX(_iconImageView), width(self.contentView) - 2*padding, 20 + padding);
    
    _starsView.frame = CGRectMake(minX(_titleLabel), maxY(_middleLabel) + 5, 65, 23);
}



























@end
