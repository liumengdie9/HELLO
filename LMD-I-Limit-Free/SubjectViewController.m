//
//  SubjectViewController.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "SubjectViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "subjectModel.h"
#import "subjectTableViewCell.h"
#import "DetailViewController.h"
@interface SubjectViewController ()<TgrDelegate>

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appTableView.tableHeaderView = nil;
    _dataArray = [NSMutableArray new];
   
}

- (void)addNavgationItemWithTitle:(NSString *)title aSelector:(SEL)aSelector isLeft:(BOOL)isLeft
{
    
}


- (void)perpareToLoadData:(BOOL)isMore
{
    NSInteger page = 1;
    NSString *urlString = nil;
    if (isMore) {
        if (_dataArray.count % 10 != 0) {
            [_appTableView.mj_footer endRefreshing];
            return;
        }
        page = _dataArray.count / 10 + 1;
    }
    urlString = [NSString stringWithFormat:self.requestURL, page];
    [self loadDataForNetWithUrl:urlString isMore:isMore];
}

- (void)loadDataForNetWithUrl:(NSString *)urlString isMore:(BOOL)isMore
{
    [_manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *modelArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dict in modelArray) {
            subjectModel *subjecModel = [[subjectModel alloc] initWithDictionary:dict error:nil];
            [_dataArray addObject:subjecModel];
        }
        [_appTableView reloadData];
        
         isMore?[_appTableView.mj_footer endRefreshing]:[_appTableView.mj_header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         isMore?[_appTableView.mj_footer endRefreshing]:[_appTableView.mj_header endRefreshing];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;
}

-(void)passObject:(subjectTableViewCell *)cell tag:(NSInteger)tag{
    NSIndexPath *index = [_appTableView indexPathForCell:cell];
    applications *apl = [_dataArray[index.row] applications][tag-100];
    //NSLog(@"%@",apl.applicationId);
    
    DetailViewController *detail = [DetailViewController new];
    [detail passID:apl.applicationId];
    detail.view.backgroundColor = [UIColor cyanColor];
    [self.navigationController pushViewController:detail animated:YES];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifer";
    
    subjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[subjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // 加箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    设置选中风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    
    cell.model = _dataArray[indexPath.row];
    
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

























@end
