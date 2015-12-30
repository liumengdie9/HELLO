//
//  DetailModel.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "DetailModel.h"
#import <JSONKeyMapper.h>
@implementation Photos

@end
@implementation DetailModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"dscription"}];
}
@end
