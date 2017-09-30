//
//  ViewController.m
//  LF_iOS7SearchBar
//
//  Created by LamTsanFeng on 2017/9/29.
//  Copyright © 2017年 LamTsanFeng. All rights reserved.
//

#import "ViewController.h"
#import "LF_iOS7SearchBar.h"

@interface ViewController () <LF_iOS7SearchBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /** code */
    LF_iOS7SearchBar *searchBar = [[LF_iOS7SearchBar alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 44.f)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
//    [searchBar setShowsCancelButton:YES animated:YES];
    [searchBar becomeFirstResponder];
    [self.view addSubview:searchBar];
    
    LF_iOS7SearchBar *navi_searchBar = [[LF_iOS7SearchBar alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 44.f)];
    navi_searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    navi_searchBar.placeholder = @"搜索";
    navi_searchBar.delegate = self;
//    navi_searchBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = navi_searchBar;
    
}

- (BOOL)lf_iOS7SearchBarShouldBeginEditing:(LF_iOS7SearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)lf_iOS7SearchBarTextDidEndEditing:(LF_iOS7SearchBar *)searchBar
{
    
}

- (void)lf_iOS7SearchBarSearchButtonClicked:(LF_iOS7SearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)lf_iOS7SearchBarCancelButtonClicked:(LF_iOS7SearchBar *)searchBar
{
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
