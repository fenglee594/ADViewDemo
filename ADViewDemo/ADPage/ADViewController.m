//
//  ADViewController.m
//  ADViewDemo
//
//  Created by 李峰 on 2018/3/7.
//  Copyright © 2018年 Stward. All rights reserved.
//

#import "ADViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>

@interface ADViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广告详情页";
    self.webView = [[WKWebView alloc] init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.adUrl]]];
}

- (NSString *)adUrl
{
    if (!_adUrl) {
        _adUrl = @"http://www.baidu.com";
    }
    return _adUrl;
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
