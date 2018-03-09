//
//  ADView.h
//  Demo
//
//  Created by 李峰 on 2018/3/6.
//  Copyright © 2018年 李峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFAdViewDelegate <NSObject>
- (void) pushAd;
@end

@interface ADView : UIView
@property (nonatomic, weak) id<LFAdViewDelegate> delegate;
@property (nonatomic, copy) NSString *adImagePath;

/**
 显示广告页
 */
- (void) show;
@end

/**
 *  AD 模型
 */
//@interface AD : NSObject
//
//@property (nonatomic, copy) NSString *imageUrl;
//@property (nonatomic, copy) NSString *adUrl;
//
//@end

