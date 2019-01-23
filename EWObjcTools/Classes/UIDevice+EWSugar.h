//
//  UIDevice+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIDevice`.
 */
@interface UIDevice (EWSugar)
#pragma mark - Device Information

/// 返回ios的版本号e.g. 8.1
+ (double)systemVersion;

/// 判断设备是是否是ipad(包含iPadMini)
@property (nonatomic, readonly) BOOL isPad;

/// 判断设备是否是模拟器
@property (nonatomic, readonly) BOOL isSimulator;

/// 判断设备是否越狱
@property (nonatomic, readonly) BOOL isJailbroken;

/// 判断设备是否可以拨打电话
@property (nonatomic, readonly) BOOL canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

/// 返回设备的机器型号  e.g. "iPhone6,1" "iPad4,6"
/// http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *machineModel;

/// 返回设备的型号名称 e.g. "iPhone 5s" "iPad mini 2"
/// http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *machineModelName;

/// 系统的开始时间
@property (nonatomic, readonly) NSDate *systemUptime;


#pragma mark - Network Information
///=============================================================================
/// @name Network Information
///=============================================================================


/// 当前设备的wifi的IP地址 e.g.@"192.168.1.111"
@property (nullable, nonatomic, readonly) NSString *ipAddressWIFI;

/// 当前设备的蜂窝网络的ip地址 e.g. @"10.2.2.222
@property (nullable, nonatomic, readonly) NSString *ipAddressCell;


/**
 Network traffic type:
 
 WWAN: Wireless Wide Area Network.
 For example: 3G/4G.
 
 WIFI: Wi-Fi.
 
 AWDL: Apple Wireless Direct Link (peer-to-peer connection).
 For exmaple: AirDrop, AirPlay, GameKit.
 */
typedef NS_OPTIONS(NSUInteger, EWNetworkTrafficType) {
    EWNetworkTrafficTypeWWANSent     = 1 << 0,
    EWNetworkTrafficTypeWWANReceived = 1 << 1,
    EWNetworkTrafficTypeWIFISent     = 1 << 2,
    EWNetworkTrafficTypeWIFIReceived = 1 << 3,
    EWNetworkTrafficTypeAWDLSent     = 1 << 4,
    EWNetworkTrafficTypeAWDLReceived = 1 << 5,
    
    EWNetworkTrafficTypeWWAN = EWNetworkTrafficTypeWWANSent | EWNetworkTrafficTypeWWANReceived,
    EWNetworkTrafficTypeWIFI = EWNetworkTrafficTypeWIFISent | EWNetworkTrafficTypeWIFIReceived,
    EWNetworkTrafficTypeAWDL = EWNetworkTrafficTypeAWDLSent | EWNetworkTrafficTypeAWDLReceived,
    
    EWNetworkTrafficTypeALL = EWNetworkTrafficTypeWWAN |
    EWNetworkTrafficTypeWIFI |
    EWNetworkTrafficTypeAWDL,
};

/**
 Get device network traffic bytes.
 
 @discussion This is a counter since the device's last boot time.
 Usage:
 
 uint64_t bytes = [[UIDevice currentDevice] getNetworkTrafficBytes:EWNetworkTrafficTypeALL];
 NSTimeInterval time = CACurrentMediaTime();
 
 uint64_t bytesPerSecond = (bytes - _lastBytes) / (time - _lastTime);
 
 _lastBytes = bytes;
 _lastTime = time;
 
 
 @param types traffic types
 @return bytes counter.
 */
- (uint64_t)getNetworkTrafficBytes:(EWNetworkTrafficType)types;

#pragma mark - Disk Space
///=============================================================================
/// @name Disk Space
///=============================================================================

/// 当前设备的总空间的大小,单位是byte(当发生错误是-1)
@property (nonatomic, readonly) int64_t diskSpace;

/// 当前设备的剩余空间的大小,单位是byte(当发生错误是-1)
@property (nonatomic, readonly) int64_t diskSpaceFree;

/// 当前设备的使用空间的大小,单位是byte(当发生错误是-1)
@property (nonatomic, readonly) int64_t diskSpaceUsed;


#pragma mark - Memory Information
///=============================================================================
/// @name Memory Information
///=============================================================================

/// Total physical memory in byte. (-1 when error occurs)
/// 当前设备的总内存空间的大小,单位是byte(当发生错误是-1)
@property (nonatomic, readonly) int64_t memoryTotal;

/// 当前设备的使用的内存空间的大小,单位是byte(当发生错误是-1)
@property (nonatomic, readonly) int64_t memoryUsed;

/// 当前设备的空闲内存空间的大小,单位是byte(当发生错误是-1)
@property (nonatomic, readonly) int64_t memoryFree;

/// 当前设备的活动内存空间的大小,单位是byte(当发生错误是-1)
@property (nonatomic, readonly) int64_t memoryActive;

/// 当前设备的不活跃内存空间的大小,单位是byte(当发生错误是-1)
@property (nonatomic, readonly) int64_t memoryInactive;

/// Wired memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryWired;

/// Purgable memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryPurgable;

#pragma mark - CPU Information
///=============================================================================
/// @name CPU Information
///=============================================================================

/// 可用的cpu数量
@property (nonatomic, readonly) NSUInteger cpuCount;
 
///当前cpu的使用率,1.0代表100%(-1 when error occurs)
@property (nonatomic, readonly) float cpuUsage;

/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
@property (nullable, nonatomic, readonly) NSArray<NSNumber *> *cpuUsagePerProcessor;

@end

NS_ASSUME_NONNULL_END

#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

#ifndef kiOS10Later
#define kiOS10Later (kSystemVersion >= 10)
#endif

#ifndef kiOS11Later
#define kiOS11Later (kSystemVersion >= 11)
#endif

#ifndef kiOS12Later
#define kiOS12Later (kSystemVersion >= 12)
#endif

