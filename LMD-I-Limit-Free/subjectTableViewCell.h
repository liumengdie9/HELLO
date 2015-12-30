//
//  subjectTableViewCell.h
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subjectModel.h"

@class subjectTableViewCell;

@protocol TgrDelegate <NSObject>

-(void)passObject:(subjectTableViewCell *)cell tag:(NSInteger)tag;

@end



@interface subjectTableViewCell : UITableViewCell

@property (nonatomic, copy) subjectModel *model;

@property (nonatomic,strong)id<TgrDelegate>delegate;

@end
