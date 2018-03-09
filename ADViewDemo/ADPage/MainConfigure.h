//
//  MainConfigure.h
//  ADViewDemo
//
//  Created by 李峰 on 2018/3/7.
//  Copyright © 2018年 Stward. All rights reserved.
//

#ifndef MainConfigure_h
#define MainConfigure_h


/**
 *UserDefault
 */
#define SMUserDefault               [NSUserDefaults standardUserDefaults]
#define SMUserDefaultSet(key,value) [SMUserDefault setObject:value forKey:key];[SMUserDefault synchronize]
#define SMUserDefaultGet(key)       [SMUserDefault objectForKey:key]


/**
 *  FileManager
 */

#define kFileManager [NSFileManager defaultManager]


#endif /* MainConfiguare_h */

