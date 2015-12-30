//
//  DetailModel.h
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Photos <NSObject>


@end

@interface Photos : JSONModel
@property (nonatomic,copy)NSString<Optional>*smallUrl;
@property (nonatomic,copy)NSString<Optional>*originalUrl;
@end

@interface DetailModel : JSONModel
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString<Optional>*currentPrice;
@property (nonatomic,copy)NSString<Optional>*categoryName;
@property (nonatomic,copy)NSString<Optional>*dscription;
@property (nonatomic,copy)NSString<Optional>*iconUrl;
@property (nonatomic,copy)NSString<Optional>*fileSize;
@property (nonatomic,copy)NSString<Optional>*starOverall;
@property (nonatomic,copy)NSMutableArray<Photos>*photos;

@end
