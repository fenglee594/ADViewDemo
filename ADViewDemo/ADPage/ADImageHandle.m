//
//  ADImageHandle.m
//  ADViewDemo
//
//  Created by 李峰 on 2018/3/7.
//  Copyright © 2018年 Stward. All rights reserved.
//

#import "ADImageHandle.h"
#import "ADView.h"
#import "MainConfigure.h"
#import "ViewController.h"


static NSString * const kADImageName = @"kADImageName";
@implementation ADImageHandle

+ (void) setupWithVC:(id)vc
{
    ![self imageIsExsist]?:[self ADViewShowWithImagePath:[[self getImageFilePath]stringByAppendingString:SMUserDefaultGet(kADImageName)]setDelegateVC:vc];
    
    [self getADImageData];
}


/**
     广告接口，一般来说，这里应该是访问广告类的接口，返回的应该会有一个imageURL和一个广告跳转的ADURL,
 在这里对这两个进行处理，再根据imageURL把图片名字截取出来,跟保存的imageName进行对比，一样的就不操作，不一样就开始下载图片，
 下载完成的时候更新imageName的值，并删除旧照片。
 Attention：第一次我是没有显示广告的
 */
+ (void)getADImageData
{
    NSArray *imageList = @[
                          @"http://images.cnblogs.com/cnblogs_com/fenglee594/1173372/o_WechatIMG189.jpg",
                          @"http://images.cnblogs.com/cnblogs_com/fenglee594/1173372/o_2222.jpg",
                          @"http://images.cnblogs.com/cnblogs_com/fenglee594/1173372/o_WechatIMG1.jpg",
                          @"http://images.cnblogs.com/cnblogs_com/fenglee594/1173372/o_WechatIMG2.jpg",
                          ];
    NSString *imageUrl = imageList[arc4random() % imageList.count];
    NSString *imageName = [[imageUrl componentsSeparatedByString:@"/"] lastObject];
    NSString * exsistImageName = SMUserDefaultGet(kADImageName);
    
    //第一次获取的exsistImageName是为nil的，这时候直接是下载
    [imageName isEqualToString:exsistImageName]?:[self downloadImageWithUrl:imageUrl ImageName:imageName DeleteOldImage:exsistImageName];
}

/**
 异步下载广告图片

 @param imageUrl 图片URL
 @param imageName 图片保存的名字
 @param oldImage 旧图片的名字
 */
+ (void) downloadImageWithUrl:(NSString *)imageUrl
                    ImageName:(NSString *)imageName
               DeleteOldImage:(NSString *)oldImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:imageData];
        NSString *filePath = [[self getImageFilePath] stringByAppendingString:imageName];
        if ([UIImageJPEGRepresentation(image, 1) writeToFile:filePath atomically:YES]) {
            //保存完图片就更新ImageName,并删除旧的图片
            SMUserDefaultSet(kADImageName, imageName);
            [self deleteOldImage:oldImage];
        }
    });
    
}




/**
 获取image的存储路径

 @return image的存储路径
 */
+ (NSString *) getImageFilePath
{
    BOOL isDir;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    NSString *directryPath = [path stringByAppendingPathComponent:@"AdImage"];
    
    if (![kFileManager fileExistsAtPath:directryPath isDirectory:&isDir]) {
        [kFileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return directryPath;
}



+ (void) deleteOldImage:(NSString *)oldImage
{
    //为空时，跳过此步骤
    if (oldImage == nil) {
        return;
    }
    [kFileManager removeItemAtPath:[[self getImageFilePath]stringByAppendingString:oldImage] error:nil];
}



/**
 设置广告页的显示和代理VC

 @param imagePath 加载的广告图片路径
 @param vc 代理VC
 */
+ (void) ADViewShowWithImagePath:(NSString *)imagePath
                          setDelegateVC:(id )vc
{
    ADView *adView = [[ADView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    adView.adImagePath = imagePath;
    adView.delegate = vc;
    [adView show];
}

/**
 判断图片是否存在

 @return yes 存在 no 不存在
 */
+ (BOOL) imageIsExsist
{
    if (!SMUserDefaultGet(kADImageName)) {
        return NO;
    }
    BOOL isDir = NO;
    if ([kFileManager fileExistsAtPath:[[self getImageFilePath] stringByAppendingString:SMUserDefaultGet(kADImageName)] isDirectory:&isDir]){
        return YES;
    } else {
        return NO;
    }
}
@end
