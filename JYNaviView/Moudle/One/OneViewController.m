//
//  OneViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "OneViewController.h"
#import "OneDetailViewController.h"

@interface OneViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeToTop;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNaviView.titleString = @"第一个控制器";
    self.baseNaviView.jy_hiddenBackBtn = YES; //不展示返回按钮
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.safeToTop.constant = k_Height_NavBar;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld---%ld", indexPath.section, indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OneDetailViewController *oneDetailVC = [[OneDetailViewController alloc]init];
    oneDetailVC.titleString = [NSString stringWithFormat:@"%ld---%ld", indexPath.section, indexPath.row];
    [self.navigationController pushViewController:oneDetailVC animated:YES];
}


@end
