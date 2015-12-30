//
//  subjectModel.h
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface applications : JSONModel

@property (nonatomic, copy) NSString *applicationId;
@property (nonatomic, copy) NSString *downloads;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ratingOverall;
@property (nonatomic, copy) NSString *starOverall;

@end


@protocol applications

@end


@interface subjectModel : JSONModel

@property (nonatomic, strong) NSMutableArray<applications> *applications;

@property (nonatomic, copy) NSString *desc_img;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *date;

@end

