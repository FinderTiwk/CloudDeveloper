//
//  XChatViewController.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/9.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XChatViewController.h"
#import "XChatViewModel.h"

@interface XChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XChatViewModel *viewModel;

@end

@implementation XChatViewController

- (XChatViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel  = [[XChatViewModel alloc] init];
    }
    return _viewModel;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    _tableView.dataSource           = self;
    _tableView.delegate             = self;
    _tableView.tableFooterView      = [UIView new];
    _tableView.emptyDataSetSource   = self.viewModel;
    _tableView.emptyDataSetDelegate = self.viewModel;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    }
    cell.textLabel.text = @"fasdfsdf";
    return cell;
}


@end
