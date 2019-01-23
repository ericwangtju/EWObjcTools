//
//  NSArray+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/1.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 提供一些数组的常用方法
 */
@interface NSArray (EWSugar)


/**
 用一个plist文件创建一个数组
 @param plist plist文件的二进制,根数据是数组
 @return 返回值是NSArray, 可以是nil或是一个error
 */
+ (nullable NSArray *)arrayWithPlistData:(NSData *)plist;


/**
 将一个plist的xml字符串存储为数组
 @param plist 需要是plist的xml字符串
 @return 数组
 */
+ (nullable NSArray *)arrayWithPlistString:(NSString *)plist;

/**
 将一个数组存成plist文件
 @return plist的二进制文件
 */
- (nullable NSData *)plistData;

/**
 将数组转为xml字符串
 */
- (nullable NSString *)plistString;

/**
 返回一个随机索引上的值,没有则返回nil
 */
- (nullable id)randomObject;

/**
 返回一个指定索引值上的值,没有则返回nil,不会抛出异常
 */
- (nullable id)objectOrNilAtIndex:(NSUInteger)index;

/**
 将一个数组转为json字符串,失败则返回nil
 */
- (nullable NSString *)jsonStringEncoded;

/**
 将一个数组转为json字符串,并且格式化,失败则返回nil
 */
- (nullable NSString *)jsonPrettyStringEncoded;

/**
 判断一个索引值是否在范围内
 */
//- (BOOL)ew_containsIndex:(NSUInteger)index;

@end


/**
 * 提供一些可变数组的通用方法
 */
@interface NSMutableArray (EWSugar)

/**
 用一个plist文件创建一个可变数组
 @param plist plist文件的二进制,根数据是数组
 @return 返回值是NSArray, 可以是nil或是一个error
 */
+ (nullable NSMutableArray *)arrayWithPlistData:(NSData *)plist;

/**
 将一个plist的xml字符串存储为数组
 @param plist 需要是plist的xml字符串
 @return 数组
 */
+ (nullable NSMutableArray *)arrayWithPlistString:(NSString *)plist;

/**
 移除可变数组中的第一个元素,如果数组为空,那么不起效果.
 */
- (void)removeFirstObject;

/**
移除可变数组中的最后一个元素,如果数组为空,那么不起效果.
 */
- (void)removeLastObject;

/**
 将可变数组中的第一个元素移除,并返回这个元素.
 如果这个数组是空数组,返回nil
 */
- (nullable id)popFirstObject;

/**
 将可变数组中的最后一个元素移除,并返回这个元素.
 如果这个数组是空数组,返回nil
 */
- (nullable id)popLastObject;

/**
 将一个元素添加到数组中的最后的位置,这个元素不能为空.如果这个值为空,那么将抛出异常
 */
- (void)appendObject:(id)anObject;

/**
 将一个元素添加到数组中的第一个位置,这个元素不能为空.如果这个值为空,那么将抛出异常
 */
- (void)prependObject:(id)anObject;

/**
 将一组数据添加到数组的最后面,如果为nil,那么不起作用
 */
- (void)appendObjects:(NSArray *)objects;

/**
 将一组数据添加到数组的最前面,如果为nil,那么不起作用
 */
- (void)prependObjects:(NSArray *)objects;

/**
 添加一组数据到数组中的指定索引值上,如果添加的数据为空则没有效果
 指定的索引值必须在原数组的索引范围内,否则报错
 */
- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

/**
 翻转数组的排列
 */
- (void)reverse;

/**
 将数组随机排序
 */
- (void)shuffle;

/**
 判断一个索引值是否在范围内
 */
//- (BOOL)ew_containsIndex:(NSUInteger)index;


/**
 将一个数据添加到数组的最后面,如果为nil,那么不起作用
 */
- (void)addObjectOrNil:(id)anObject;

/**
 将一个数据插入到数组指定位置,如果为nil,那么不起作用
 */
- (BOOL)insertObjectOrNil:(id)anObject atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
