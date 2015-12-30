//
//  DetailViewController.m
//  LMD-I-Limit-Free
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 刘梦蝶. All rights reserved.
//

#import "DetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "KillAllDefine.h"
#import "DetailModel.h"
#import "UIView+Common.h"
#import <UIImageView+WebCache.h>
@interface DetailViewController ()
{
    
    NSString *_Id;
    UIScrollView *_scrollView;
    UIImageView *imageview;
    UILabel *name;
    UILabel *priceAndMB;
    UILabel *class;
    UILabel *star;
    DetailModel *model;
    NSMutableArray *_buttonArray;
    UIScrollView *_smallScroll;
    UILabel *_desLabel;
    
}
@end

@implementation DetailViewController
-(void)passID:(NSString *)iD{
    _Id = [NSString stringWithString:iD];
    [self loadFormNet];
}

-(void)loadFormNet{
    NSString *str = [NSString stringWithFormat:kDetailUrl,_Id];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       model = [[DetailModel alloc] initWithData:responseObject error:nil];
        [self createScence];
        [self createScrollImage];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createScence{
    [imageview sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:nil];
    name.text = model.name;
    priceAndMB.text = [NSString stringWithFormat:@"原价:%@ 限免中:%@",model.currentPrice,model.fileSize];
    class.text = model.categoryName;
    star.text = model.starOverall;

}

-(void)createScence1{
    _scrollView = [UIScrollView new];
    _scrollView.frame = CGRectMake(0, 64, width(self.view), height(self.view)-64);
    imageview = [UIImageView new];
    name = [UILabel new];
    priceAndMB = [UILabel new];
    class = [UILabel new];
    star = [UILabel new];
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_scrollView addSubview:button];
        [_buttonArray addObject:button];
    }
    _smallScroll = [UIScrollView new];
    [_scrollView addSubview:imageview];
    [_scrollView addSubview:name];
    [_scrollView addSubview:priceAndMB];
    [_scrollView addSubview:class];
    [_scrollView addSubview:star];
    [_scrollView addSubview:_smallScroll];
    [self.view addSubview:_scrollView];
}

-(void)custom{
    CGFloat leftPadding =10;
    CGFloat tapadding = 10;
    CGFloat padding = 10;
    imageview.frame = CGRectMake(2*leftPadding, 3*tapadding, 60, 60);
    name.frame = CGRectMake(maxX(imageview)+padding, 2*tapadding, width(self.view)-maxX(imageview)-2*leftPadding, 20);
    priceAndMB.frame = CGRectMake(maxX(imageview)+padding, maxY(name)+padding, width(_scrollView)-maxX(imageview)-2*leftPadding, 20);
    class.frame = CGRectMake(maxX(imageview)+padding, maxY(priceAndMB)+padding,(width(_scrollView)-maxX(imageview)-3*leftPadding)/2, 20);
    star.frame = CGRectMake(maxX(class)+padding, maxY(priceAndMB)+padding, (width(_scrollView)-maxX(imageview)-3*leftPadding)/2, 20);
    NSArray *ary = @[@"分享",@"收藏",@"下载"];
    for (int i=0; i<_buttonArray.count; i++) {
        UIButton *button = _buttonArray[i];
        button.frame = CGRectMake(leftPadding+i*(width(_scrollView)-2*leftPadding)/3, maxY(class)+padding, (width(_scrollView)-2*leftPadding)/3, 40);
        [button setTitle:ary[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    }
    _smallScroll.frame = CGRectMake(leftPadding, maxY(class)+2*padding+40,width(_scrollView), 100);
    
}

-(void)createScrollImage{
    CGFloat padding = 5;
    for (int i=0; i<model.photos.count; i++) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(i* (width(_smallScroll)-(model.photos.count-1)*padding)/model.photos.count, 0, width(_smallScroll)/model.photos.count,height(_smallScroll))];
        [view sd_setImageWithURL:[NSURL URLWithString:[model.photos[i] originalUrl]] placeholderImage:nil];
        [_smallScroll addSubview:view];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _buttonArray = [NSMutableArray new];
    [self createScence1];
    [self custom];
     self.view.backgroundColor = [UIColor whiteColor];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
