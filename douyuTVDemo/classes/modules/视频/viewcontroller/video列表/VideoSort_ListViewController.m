//
//  VideoSort_ListViewController.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/8/3.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "VideoSort_ListViewController.h"
#import "VideoListTableView.h"
#import "VideoListTableViewCell.h"
#import "VideoListModel.h"


@interface VideoSort_ListViewController ()

@property (nonatomic , strong ) VideoListTableView *tableView;

@property (nonatomic , strong ) NSMutableArray     *secondArray;//数据原数组

@end

@implementation VideoSort_ListViewController

-(void)dealloc{
    
    _tableView = nil;
    
    _secondArray = nil;
    
    _string = nil;
    
    _name = nil;
    
    _searchName = nil;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.name;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}




//加载数据

-(void)loadData{
    
    //判断是搜索请求还是正常请求
    
    NSString *URL =  nil;
    
    if (_string != nil) {
        
        URL = [NSString stringWithFormat:kUnion_Video_URL , @"%ld" , self.string ];
        
    } else {
        
        URL = [NSString stringWithFormat:kUnion_Video_SearchURL , self.searchName , @"%ld" ];
        
    }
    
    //导航控制器标头
    
    self.title = self.name;
    
    //设置URL
    
    self.tableView.urlStr = URL;
    
    
}






#pragma mark ---leftBarButtonAction

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    //清空请求参数
    
    _string = nil;
    
    _searchName = nil;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark ---LazyLoading

-(VideoListTableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[VideoListTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 ) style:UITableViewStylePlain];
        
        _tableView.rootVC = self;
        
        //添加视频列表视图
        
        [self.view addSubview:self.tableView];
        
    }
    
    return _tableView;
}


-(NSMutableArray *)secondArray{
    
    if (_secondArray == nil) {
        
        _secondArray = [[NSMutableArray alloc]init];
    }
    
    return _secondArray;
    
}

#pragma mark -super method
- (void)setUIElementsFontWhenAwake{
    
}
- (void)setupNavigationItems{
    //[super setupNavigationItems];
}
@end
