//
//  ViewController.m
//  ADViewDemo
//
//  Created by 李峰 on 2018/3/7.
//  Copyright © 2018年 Stward. All rights reserved.
//

#import "ViewController.h"
#import "ADViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"第一个VC";
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushAd {
    ADViewController *advc = [[ADViewController alloc] init];
    [self.navigationController pushViewController:advc animated:YES];
}



@end
