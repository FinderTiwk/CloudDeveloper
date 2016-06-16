//
//  XFirendsViewController.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/10.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XFirendsViewController.h"
#import "XFirendsViewModel.h"
#import "XFirendCell.h"

@interface XFirendsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,EMContactManagerDelegate>

@property (nonatomic,strong) XFirendsViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation XFirendsViewController{
    UISearchController *_searchController;
    NSArray  *_searchArray;
    CAShapeLayer *_redCircleLayer;
}

- (XFirendsViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[XFirendsViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    _redCircleLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(8, 8) radius:4 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    _redCircleLayer.path = path.CGPath;
    _redCircleLayer.fillColor = [UIColor redColor].CGColor;
    [_addButton.layer addSublayer:_redCircleLayer];
    _redCircleLayer.hidden = YES;
    
    [[_addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _redCircleLayer.hidden = YES;
    }];
    
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    _tableView.tableFooterView = [UIView new];

    UIRefreshControl *control  = [[UIRefreshControl alloc] init];
    control.attributedTitle    = [[NSAttributedString alloc] initWithString:@"Refreshing Firends List……😽"];
    control.tintColor = [UIColor grayColor];
    [control addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:control];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [_searchController.searchBar sizeToFit];
    [_searchController.searchBar setBarStyle:UIBarStyleBlack];
    [_searchController.searchBar setTintColor:[UIColor whiteColor]];
    [_searchController.searchBar setBackgroundColor:[UIColor clearColor]];
    [_searchController.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.showsCancelButton = YES;
    _searchController.dimsBackgroundDuringPresentation = YES;     //是否添加半透明覆盖层
    _searchController.hidesNavigationBarDuringPresentation = NO;     //是否隐藏导航栏
    _tableView.tableHeaderView = _searchController.searchBar;
    
    _tableView.emptyDataSetSource   = self.viewModel;
    _tableView.emptyDataSetDelegate = self.viewModel;
    
    @weakify(self)
    [RACObserve(self.viewModel, fetchComplete) subscribeNext:^(id x) {
        @strongify(self)
        BOOL transcationTag = [x boolValue];
        if (transcationTag) {
            [self.tableView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.viewModel.fetchComplete = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_searchController.active) {
        _searchController.active = NO;
        [_searchController.searchBar removeFromSuperview];
    }
}

- (void)dealloc{
    [[EMClient sharedClient].contactManager removeDelegate:self];
}

- (void)refreshAction:(UIRefreshControl *)sender{
    self.viewModel.fetchComplete = NO;
    [sender endRefreshing];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchController.active) {
        return _searchArray.count;
    }
    return self.viewModel.firendsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XFirendCell *cell = [XFirendCell cellWithTableView:tableView];
    if (_searchController.active) {
        cell.firend  = _searchArray[indexPath.row];
    }else{
        cell.firend  = self.viewModel.firendsList[indexPath.row];
    }
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction =[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.viewModel deleteFirendAtIndex:indexPath.row complete:^{
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }];
    }];    
    return @[deleteAction];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSPredicate *precidate = [NSPredicate predicateWithFormat:@"account CONTAINS[cd] %@", searchController.searchBar.text];
    _searchArray = [self.viewModel.firendsList filteredArrayUsingPredicate:precidate];
    [_tableView reloadData];
}

#pragma mark - EMContactManagerDelegate
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername message:(NSString *)aMessage{
    _redCircleLayer.hidden = NO;
    [self.viewModel saveAddRequestWithAccount:aUsername message:aMessage];
}

@end
