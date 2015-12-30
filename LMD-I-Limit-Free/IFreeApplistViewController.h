//
//  IFreeApplistViewController.h
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "IFreeBaseViewController.h"

@class AFHTTPRequestOperationManager;

@interface IFreeApplistViewController : IFreeBaseViewController{

     UITableView *_appTableView;
     NSMutableArray *_dataArray;
    AFHTTPRequestOperationManager *_manager;
}

/**
 *  分类使用的id
 */

@property (nonatomic, copy) NSString *categoryID;

@property (nonatomic, copy) NSString *requestURL;

@property (nonatomic ,copy) NSString *categoryType;

- (void)loadDataForNetWithUrl:(NSString *)urlString isMore:(BOOL)isMore;

@end
