//
//  MyTalbeViewController.m
//  LF_iOS7SearchBar
//
//  Created by LamTsanFeng on 2017/10/20.
//  Copyright © 2017年 LamTsanFeng. All rights reserved.
//

#import "MyTalbeViewController.h"

#import "LF_iOS7SearchBar.h"

@interface MyTalbeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation MyTalbeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    tableView.contentInset = insets;
    tableView.scrollIndicatorInsets = insets;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    /** 这个设置iOS9以后才有，主要针对iPad，不设置的话，分割线左侧空出很多 */
    if ([tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
        if (@available(iOS 9.0, *)) {
            tableView.cellLayoutMarginsFollowReadableWidth = NO;
        } else {
            // Fallback on earlier versions
        }
    }
    /** 解决ios7中tableview每一行下面的线向右偏移的问题 */
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if (@available(iOS 11.0, *)){
        [tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    self.tableView = tableView;
    
    LF_iOS7SearchBar *searchBar = [[LF_iOS7SearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.f)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    searchBar.placeholder = @"搜索";
    
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.f)];
    
    self.tableView.tableHeaderView = searchBar;
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndScroll:scrollView];
    }
}

- (void)scrollViewDidEndScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        if ([self.tableView.tableHeaderView isKindOfClass:[LF_iOS7SearchBar class]]) {
            CGFloat tableHeaderHeight = self.tableView.tableHeaderView.frame.size.height;
            if (self.tableView.contentOffset.y + self.tableView.contentInset.top < tableHeaderHeight/2) {
                [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, -self.tableView.contentInset.top) animated:YES];
            } else if (self.tableView.contentOffset.y + self.tableView.contentInset.top < tableHeaderHeight ) {
                [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, -self.tableView.contentInset.top + tableHeaderHeight) animated:YES];
            }
        }
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

@end
