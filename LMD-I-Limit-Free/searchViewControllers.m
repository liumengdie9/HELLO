//
//  searchViewControllers.m
//  
//
//  Created by qianfeng007 on 15/12/10.
//
//

#import "searchViewControllers.h"

@interface searchViewControllers ()

@end

@implementation searchViewControllers

- (void)viewDidLoad {
    [super viewDidLoad];
    _appTableView.tableHeaderView = nil;
    
}

- (void)addNavgationItemWithTitle:(NSString *)title aSelector:(SEL)aSelector isLeft:(BOOL)isLeft
{
    
}

- (void)perpareToLoadData:(BOOL)isMore
{
    NSInteger page = 1;
    NSString *urlString = nil;
    if (isMore) {
        if (_dataArray.count % 20 != 0) {
           
            return;
        }
        page = _dataArray.count / 20 + 1;
    }
    
    urlString = [NSString stringWithFormat:self.requestURL, page, _searchText];
    
    [self loadDataForNetWithUrl:urlString isMore:isMore];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
