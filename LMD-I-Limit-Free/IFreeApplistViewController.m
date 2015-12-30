//
//  IFreeApplistViewController.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "IFreeApplistViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "KillAllDefine.h"
#import "appLoacationModel.h"
#import "appCell.h"
#import "UIView+Common.h"
#import "searchViewControllers.h"
#import "NSString+comment.h"
#import "categoryControllers.h"

@interface IFreeApplistViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@end

@implementation IFreeApplistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _categoryID = 0;
    [self addNavgationItemWithTitle:@"分类" aSelector:@selector(categoryAction) isLeft:YES];
    [self addNavgationItemWithTitle:@"设置" aSelector:@selector(settingAction) isLeft:NO];
    [self createTableView];
    [self createSearchBar];
    [self initRequestManger];
//    [self perpareToLoadData:NO];
}

- (void)initRequestManger
{
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
}

- (void)categoryAction
{
    
    categoryControllers *category = [categoryControllers new];
    
    category.categoryBlock = ^(NSString *categoryId){
        _categoryID = categoryId;
        [_appTableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:category animated:YES];
    
//    category.categoryBlock = ^(NSString *categoryId){
//        _categoryID = categoryId;
//        [_appTableView.mj_header beginRefreshing];
//    };
//    [self.navigationController pushViewController:category animated:YES];
}

- (void)settingAction
{
 
}

- (void)createTableView
{
    if (_appTableView == nil) {
        _appTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        
        _appTableView.delegate = self;
        _appTableView.dataSource = self;
        [self.view addSubview:_appTableView];
    }
//    去掉线即是隐藏下面的线
    _appTableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
   
        [self perpareToLoadData:NO];
    }];
    _appTableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        [self perpareToLoadData:YES];
    }];
    _appTableView.mj_footer = footer;
    
    [_appTableView.mj_header beginRefreshing];
}

- (void)createSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, width(_appTableView), 44)];
    searchBar.placeholder = @"有六十万款应用,搜搜看！";
    _appTableView.tableHeaderView = searchBar;
    searchBar.delegate = self;
    
    
}

#pragma mark - UISarchBarDelegate

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
    for (UIView *view in [searchBar.subviews[0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitle:@"取消" forState:UIControlStateNormal];
        }
    }

    
    return YES;
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{

    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0) {
    
        searchViewControllers *searchVc = [searchViewControllers new];
        
        if ([_categoryType isEqualToString:kLimitType]) {
            searchVc.requestURL = SEARCH_LIMIT_URL;
        }else if ([_categoryType isEqualToString:kReduceType]){
        
            searchVc.requestURL = SEARCH_REDUCE_URL;
        }else if ([_categoryType isEqualToString:kFreeType]){
            
            searchVc.requestURL = SEARCH_FREE_URL;
        }else if ([_categoryType isEqualToString:kHotType]){
            
            searchVc.requestURL = SEARCH_HOT_URL;
        }
//        中文转码 服务端会有对应的解码
            searchVc.searchText = URLEncodedString(searchBar.text);
            searchVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:searchVc animated:YES];

    }
    
}

- (void)perpareToLoadData:(BOOL)isMore
{
    NSInteger page = 1;
    NSString *urlString = nil;
    if (isMore) {
        if (_dataArray.count % 20 != 0) {
            [_appTableView.mj_footer endRefreshing];
            return;
        }
        page = _dataArray.count / 20 + 1;
    }
    
    if ([_categoryType isEqualToString:kLimitType] ||
        [_categoryType isEqualToString:kReduceType] ||
        [_categoryType isEqualToString:kFreeType]) {
        
        urlString = [NSString stringWithFormat:_requestURL, page, _categoryID];
        
    }else{
        
        urlString = [NSString stringWithFormat:_requestURL, page];
    }
    
    [self loadDataForNetWithUrl:urlString isMore:isMore];
}

- (void)loadDataForNetWithUrl:(NSString *)urlString isMore:(BOOL)isMore
{
    
    [_manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        appLoacationModel *appModel = [[appLoacationModel alloc] initWithData:responseObject error:nil];
        
        if (isMore) {
            [_dataArray addObjectsFromArray:appModel.applications];
        }else{
            
            [_dataArray removeAllObjects];
            [_appTableView reloadData];
            _dataArray = appModel.applications;
            
        }
        
        [_appTableView reloadData];
        
        isMore?[_appTableView.mj_footer endRefreshing]:[_appTableView.mj_header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        isMore?[_appTableView.mj_footer endRefreshing]:[_appTableView.mj_header endRefreshing];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifer";
    
    appCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[appCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
// 加箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    设置选中风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2) {
        
         cell.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:239/255.0 alpha:1.0];
    }else{

        cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    }
    
    cell.model = _dataArray[indexPath.row];
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
