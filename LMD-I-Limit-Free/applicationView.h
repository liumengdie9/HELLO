//
//  applicationView.h
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subjectModel.h"


@interface applicationView : UIView

@property (nonatomic, strong)applications *model;

-(void)resetPostion;
@end
