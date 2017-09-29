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
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
//    [searchBar setShowsCancelButton:YES animated:YES];
    [self.view addSubview:searchBar];
}

- (BOOL)lf_iOS7SearchBarShouldBeginEditing:(LF_iOS7SearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)lf_iOS7SearchBarTextDidEndEditing:(LF_iOS7SearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
