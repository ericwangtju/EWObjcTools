//
//  NSNumber+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSNumber (EWSugar)

/**
 将一个字符串转为NSNumber
 无效的数据格式@"12", @"12.345", @" -0xFF", @" .23e99 "...
 当转话失败后返回为nil
 */
+ (nullable NSNumber *)numberWithString:(NSString *)string;
@end
NS_ASSUME_NONNULL_END
