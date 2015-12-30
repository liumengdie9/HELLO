//
//  appLoacationModel.h
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol AppModel <NSObject>


@end

@interface AppModel : JSONModel

@property (nonatomic, copy) NSString *applicationId;
@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *itunesUrl;
@property (nonatomic, copy) NSString *starCurrent;
@property (nonatomic, copy) NSString *starOverall;
@property (nonatomic, copy) NSString *ratingOverall;
@property (nonatomic, copy) NSString *downloads;
@property (nonatomic, copy) NSString *currentPrice;
@property (nonatomic, copy) NSString *lastPrice;
@property (nonatomic, copy) NSString *priceTrend;
@property (nonatomic, copy) NSString *expireDatetime;
@property (nonatomic, copy) NSString *releaseNotes;
@property (nonatomic, copy) NSString *updateDate;
@property (nonatomic, copy) NSString *fileSize;
@property (nonatomic, copy) NSString *ipa;
@property (nonatomic, copy) NSString *shares;
@property (nonatomic, copy) NSString *favorites;
@end



@interface appLoacationModel : JSONModel

@property (nonatomic,strong)NSMutableArray<AppModel> *applications;
@end

