//
//  categoryControllers.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "categoryControllers.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "KillAllDefine.h"
#import "CategoryModel.h"


@interface categoryControllers ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation categoryControllers

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTvc];
    [self loadDataFormNet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)loadDataFormNet{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:kCateUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        FLModel *flModel = [[FLModel alloc] initWithDictionary:@{@"models":array} error:nil];
        _dataArray = flModel.models;

        [_tableView  reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

- (void)createTvc
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = _dataArray[indexPath.row];
    
    if (_categoryBlock) {
        _categoryBlock(model.categoryId);
    };
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    CategoryModel *model = _dataArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"account_candou"]];
    cell.textLabel.text =[NSString stringWithFormat:@"%@",model.categoryCname];
    
    cell.detailTextLabel.text =[NSString stringWithFormat:@"总共有%@款  下载%@次",model.categoryCount,model.down];
    return cell;
}

@end
