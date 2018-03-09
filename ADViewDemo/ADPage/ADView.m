//
//  ADView.m
//  Demo
//
//  Created by 李峰 on 2018/3/6.
//  Copyright © 2018年 李峰. All rights reserved.
//

#import "ADView.h"
#import <Masonry.h>
#import "MainConfigure.h"

@interface ADView ()
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UIButton *pushBtn; //跳过button
@property (nonatomic, strong) NSTimer *timer;   //定时器倒计时
@end

//倒计时5s
static NSUInteger AdCount = 5;

@implementation ADView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configuareWithFrame:frame];
    }
    return self;
}

- (void) configuareWithFrame:(CGRect)frame {
    _adImageView = [[UIImageView alloc] initWithFrame:frame];
    _adImageView.userInteractionEnabled = YES;
//    _adImageView.image = [UIImage imageNamed:@"2222.jpg"];
    _adImageView.contentMode = UIViewContentModeScaleAspectFill;
    _adImageView.clipsToBounds = YES;
    [self addSubview:_adImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkAD)];
    [_adImageView addGestureRecognizer:tap];
    
    _pushBtn = [[UIButton alloc] init];
    [_pushBtn setTitle:[NSString stringWithFormat:@"跳过 %lus",(unsigned long)AdCount]forState:UIControlStateNormal];
    _pushBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _pushBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [_pushBtn setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
    _pushBtn.layer.cornerRadius = 4.0;
    [_pushBtn addTarget:self action:@selector(removeAdView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pushBtn];
    [_pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-50));
        make.top.equalTo(@(75));
    }];
    
}



- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self ticktock];
    }];
}

- (void)ticktock
{
    if(!AdCount){//计时器为0
        [self removeAdView];
        return;
    }
    [_pushBtn setTitle:[NSString stringWithFormat:@"跳过 %@s",@(AdCount--)] forState:UIControlStateNormal];
    [_pushBtn sizeToFit];
}


/**
 移除广告页
 */
- (void)removeAdView{
    [self.timer invalidate];
    self.timer = nil;
    [UIView animateWithDuration:0.4f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)linkAD
{
    if (self.delegate && [self.delegate respondsToSelector:(@selector(pushAd))]) {
        [self removeAdView];
        [self.delegate pushAd];
    }
}

- (void)setAdImagePath:(NSString *)adImagePath{
    _adImagePath = adImagePath;
    _adImageView.image = [UIImage imageWithContentsOfFile:_adImagePath];
}


- (void) show
{
    //启动计时器
    [self startTimer];
    //展示页面
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

@end

//@implementation AD
//
////- (BOOL)isEqual:(id)object
////{
////    return [self modelIsEqual:object];
////}
//
//
//@end

