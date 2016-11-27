//
//  ViewController.m
//  SearchPageDemo
//
//  Created by 渠晓友 on 2016/11/27.
//  Copyright © 2016年 渠晓友. All rights reserved.
//

#import "ViewController.h"
#import "XYHomeSearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"点击进入搜索页面" forState:0];
    [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = self.view.bounds;
    btn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btn];
    
}

- (void)btnClick:(UIButton *)sender
{
    XYHomeSearchViewController *searchPage = [[XYHomeSearchViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchPage];
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
