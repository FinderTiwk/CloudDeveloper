//
//  XAddFirendController.m
//  CloudDeveloper
//
//  Created by _Finder丶Tiwk on 16/4/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XAddFirendController.h"
#import "XRequestCell.h"
#import "XAddFirendViewModel.h"

@interface XAddFirendController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) XAddFirendViewModel *viewModel;

@end

@implementation XAddFirendController

- (XAddFirendViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[XAddFirendViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    RAC(self.viewModel,addText) = [_inputTextField rac_textSignal];
    _addButton.rac_command = self.viewModel.addFirendCommand;
    _tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.requestArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     XRequestCell *cell = [XRequestCell cellWithTableView:tableView];
    cell.addRequest = self.viewModel.requestArray[indexPath.row];
    [cell setRequestHandleBlock:^{
        [self.viewModel removeRequestAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [tableView reloadData];
    }];
    return cell;
}

@end
