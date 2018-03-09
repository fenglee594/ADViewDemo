//
//  ADImageHandle.h
//  ADViewDemo
//
//  Created by 李峰 on 2018/3/7.
//  Copyright © 2018年 Stward. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADImageHandle : NSObject

/**
 设置广告页

 @param vc  跳广告链接我是在ADView上写了一个协议，然后给VC去代理实现的，所以这边要传个VC，
            如果不想传也可以用个通知的方式实现，在点击广告的时候发个通知的，在你的第一个VC里面接收通知然后跳转广告页。
 */
+ (void)setupWithVC:(id)vc;

@end
