//
//  UIApplication+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (EWSugar)

/// documents文件夹路径
@property (nonatomic, readonly) NSURL *documentsURL;
@property (nonatomic, readonly) NSString *documentsPath;

/// caches文件夹路径
@property (nonatomic, readonly) NSURL *cachesURL;
@property (nonatomic, readonly) NSString *cachesPath;

/// Library文件夹路径
@property (nonatomic, readonly) NSURL *libraryURL;
@property (nonatomic, readonly) NSString *libraryPath;

/// app的bundle名称
@property (nullable, nonatomic, readonly) NSString *appBundleName;

/// app的bundleID
@property (nullable, nonatomic, readonly) NSString *appBundleID;

/// app的bundle Version e.g. "1.2.0"
@property (nullable, nonatomic, readonly) NSString *appVersion;

/// app的构建版本号
@property (nullable, nonatomic, readonly) NSString *appBuildVersion;

/// 判断这个app是否是从appstore上安装的
@property (nonatomic, readonly) BOOL isPirated;

/// Whether this app is being debugged (debugger attached).
@property (nonatomic, readonly) BOOL isBeingDebugged;

/// 当前线程的实际内存使用(单位是byte,当发生错误返回-1)
@property (nonatomic, readonly) int64_t memoryUsage;

/// 当前线程的cpu使用率,1.0代表100%
@property (nonatomic, readonly) float cpuUsage;


/**
 增加活跃的网络请求数,如果原来是0,那么将会激活状态栏上网络菊花.此方法是线程安全的
 */
- (void)incrementNetworkActivityCount;

/**
 减少活跃的网络请求数,如果减少后是0,那么将会关闭状态栏上网络菊花.此方法是线程安全的
 */
- (void)decrementNetworkActivityCount;

/// 判断是否是Extension
+ (BOOL)isAppExtension;

/// 等同于sharedApplication, 但是在App Extension上返回的是nil
+ (nullable UIApplication *)sharedExtensionApplication;

@end

NS_ASSUME_NONNULL_END
