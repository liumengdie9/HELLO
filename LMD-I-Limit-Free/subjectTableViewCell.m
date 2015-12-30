//
//  subjectTableViewCell.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "subjectTableViewCell.h"
#import "subjectModel.h"
#import <UIImageView+WebCache.h>
#import "UIView+Common.h"
#import "applicationView.h"
@implementation subjectTableViewCell
{
    subjectModel *_model;
    UILabel *_titleLabel;
    UIImageView *_coverImageView;
    UIImageView *_mmImageView;
    UITextView *_mmTextview;
    NSMutableArray *_appArray;
}
- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _appArray = [NSMutableArray array];
        [self customSubViews];
    }
    return self;
}

- (void)layoutSubviews

{   [super layoutSubviews];
    CGFloat leftPadding = 10;
    CGFloat topPadding = 10;
    CGFloat padding = 10;
    CGFloat space = 5;
    
    _titleLabel.frame = CGRectMake(leftPadding, topPadding, width(self.contentView) - 2*leftPadding, 30);
    
    _coverImageView.frame = CGRectMake(leftPadding, maxY(_titleLabel), 150, 220);
    
    _mmImageView.frame = CGRectMake(leftPadding, maxY(_coverImageView) + 2*topPadding, 50, 50);
    
    _mmTextview.frame = CGRectMake(maxX(_mmImageView) + padding, minY(_mmImageView), width(self.contentView) - maxX(_mmImageView) - 2*padding , 50);
    
    
    for (int i=0; i<_appArray.count; i++) {
        
        applicationView *applicationView = _appArray[i];
        
        applicationView.frame = CGRectMake(maxX(_coverImageView)+padding, maxY(_titleLabel) + (height(_coverImageView)- space * 3) / 4 * i + space * i,width(self.contentView)-width(_coverImageView)- 2 * leftPadding , (height(_coverImageView) - space*3) / 4);
        
        [applicationView resetPostion];
    }
}


- (void)customSubViews
{
    _titleLabel = [UILabel new];
    _coverImageView = [UIImageView new];
    _mmImageView = [UIImageView new];
    _mmTextview = [UITextView new];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_coverImageView];
    [self.contentView addSubview:_mmImageView];
    [self.contentView addSubview:_mmTextview];
    
    for (int i=0; i<4; i++) {
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrHandle:)];
        
        applicationView *app = [applicationView new];
        
        app.tag = 100 + i;
        [self.contentView addSubview:app];
        [_appArray addObject:app];
        [app addGestureRecognizer:tgr];
    }
}

-(void)tgrHandle:(UITapGestureRecognizer *)tgr{
    if (self.delegate && [_delegate respondsToSelector:@selector(passObject: tag:)]) {
        [self.delegate passObject:self tag:tgr.view.tag];
        
    }
}

- (void)setModel:(subjectModel *)model
{
    _model = model;
    
    _titleLabel.text = model.title;
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    [_mmImageView sd_setImageWithURL:[NSURL URLWithString:model.desc_img] placeholderImage:nil];
    _mmTextview.text = model.desc;
    
    for (int i = 0; i < _appArray.count; i++) {
        
        applicationView *applicationView = _appArray[i];
        
        if (i < model.applications.count) {
            
            applicationView.model = model.applications[i];
            applicationView.hidden = NO;
        }else{
            
            applicationView.hidden =YES;
        }
    }
    
}




































- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
