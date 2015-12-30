//
//  categoryControllers.h
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "IFreeBaseViewController.h"

typedef void(^categoryBlock)(NSString *catgaryID);

@interface categoryControllers : IFreeBaseViewController

@property(nonatomic,copy)categoryBlock categoryBlock;

@end
