//
//  NSDictionary+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSDictionary (EWSugar)
#pragma mark - Dictionary Convertor

/**
 将一个plist二进制文件转为字典
 */
+ (nullable NSDictionary *)dictionaryWithPlistData:(NSData *)plist;

/**
将xml字符串转为字典
 */
+ (nullable NSDictionary *)dictionaryWithPlistString:(NSString *)plist;

/**
 将一个字典序列化成为plist二进制文件
 */
- (nullable NSData *)plistData;

/**
 将一个字典序列化成为xml字符串
 */
- (nullable NSString *)plistString;

/**
 将字典的所有键提取成为一个数组,并根据key的首字母进行排序.如果字典为空,那么返回空数组
 */
- (NSArray *)allKeysSorted;

/**
 根据键的排序将值返回一个数组,如果字典为空,那么返回空数组
 */
- (NSArray *)allValuesSortedByKeys;

/**
 判断字典是否包含某一个键值
 */
- (BOOL)containsObjectForKey:(id)key;

/**
 返回一个包含指定键的实体的字典.如果键为空,那么返回空字典
 */
- (NSDictionary *)entriesForKeys:(NSArray *)keys;

/**
 将一个字典转为json字符串
 */
- (nullable NSString *)jsonStringEncoded;

/**
 将一个字典转为json字符串,并且格式化
 */
- (nullable NSString *)jsonPrettyStringEncoded;

/**
 将xml(nsdata或是nsstring)转为字典
 */
+ (nullable NSDictionary *)dictionaryWithXML:(id)xmlDataOrString;

#pragma mark - Dictionary Value Getter
// 获取一个键值对的布尔值
- (BOOL)boolValueForKey:(NSString *)key default:(BOOL)def;

// 获取一个键值对的字符值
- (char)charValueForKey:(NSString *)key default:(char)def;

// 获取无符号键值对字符
- (unsigned char)unsignedCharValueForKey:(NSString *)key default:(unsigned char)def;

// 返回短整型
- (short)shortValueForKey:(NSString *)key default:(short)def;

// 获取无符号短整型
- (unsigned short)unsignedShortValueForKey:(NSString *)key default:(unsigned short)def;

// 获取整型
- (int)intValueForKey:(NSString *)key default:(int)def;

// 获取无符号整型
- (unsigned int)unsignedIntValueForKey:(NSString *)key default:(unsigned int)def;

// 获取长整型
- (long)longValueForKey:(NSString *)key default:(long)def;

// 获取无符号长整型
- (unsigned long)unsignedLongValueForKey:(NSString *)key default:(unsigned long)def;

// 获取long long整型
- (long long)longLongValueForKey:(NSString *)key default:(long long)def;

// 获取无符号long long整型
- (unsigned long long)unsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def;

// 获取fload
- (float)floatValueForKey:(NSString *)key default:(float)def;

// 获取double
- (double)doubleValueForKey:(NSString *)key default:(double)def;

// 获取NSInteger
- (NSInteger)integerValueForKey:(NSString *)key default:(NSInteger)def;
- (NSInteger)integerValueForKey:(NSString *)key;

// 获取NSUInteger
- (NSUInteger)unsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def;

// 获取NSNumber
- (nullable NSNumber *)numberValueForKey:(NSString *)key default:(nullable NSNumber *)def;

// 获取NSString
- (nullable NSString *)stringValueForKey:(NSString *)key default:(nullable NSString *)def;
- (nullable NSString *)stringValueForKey:(NSString *)key;

// 获取NSSArray
- (NSArray *)arrayForKey:(id)aKey;
- (NSArray *)arrayForKey:(id)aKey defaultValue:(NSArray *)defaultValue;

// 获取NSDictionAry
- (NSDictionary *)dictionaryForKey:(id)aKey;
- (NSDictionary *)dictionaryForKey:(id)aKey defaultValue:(NSDictionary *)defaultValue;

// 获取NSData
- (NSData *)dataForKey:(id)aKey;
- (NSData *)dataForKey:(id)aKey defaultValue:(NSData *)defaultValue;

// 获取NSDate
- (NSDate *)dateForKey:(id)aKey;
- (NSDate *)dateForKey:(id)aKey defaultValue:(NSDate *)defaultValue;

// 获取NSURL
- (NSURL *)URLForKey:(id)aKey;
- (NSURL *)URLForKey:(id)aKey defaultValue:(NSURL *)defaultValue;

// 获取object
- (id)objectForKey:(id)aKey class:(Class)clazz;
- (id)objectForKey:(id)aKey class:(Class)clazz defaultValue:(id)defaultValue;
- (id)objectForKey:(id)aKey protocol:(Protocol *)protocol;
- (id)objectForKey:(id)aKey protocol:(Protocol *)protocol defaultValue:(id)defaultValue;
- (id)objectForKey:(id)aKey class:(Class)clazz protocol:(Protocol *)protocol;
- (id)objectForKey:(id)aKey class:(Class)clazz protocol:(Protocol *)protocol defaultValue:(id)defaultValue;

@end


/**
 * 一些可变字典的通用方法
 */
@interface NSMutableDictionary (EWSugar)

/**
 将一个plist二进制文件转为可变字典
 */
+ (nullable NSMutableDictionary *)dictionaryWithPlistData:(NSData *)plist;

/**
 将xml字符串转为可变字典
 */
+ (nullable NSMutableDictionary *)dictionaryWithPlistString:(NSString *)plist;

/**
 移除指定key的值,并将其返回
 当值为nil或是不存在则返回nil
 */
- (nullable id)popObjectForKey:(id)aKey;

/**
 将指定的keys的值删除,并将其组成一个新字典.不成功返回一个空字典
 */
- (NSDictionary *)popEntriesForKeys:(NSArray *)keys;


/**
 生成一个url参数字符串
 
 @return ?userId=afj&accessToken=1244123
 */
- (NSString *)generateUrlParameterString;

/**
 设置一个元素,可以为nil,不起作用
 */
- (void)setObjectOrNil:(id)anObject forKey:(id<NSCopying>)aKey;

@end
NS_ASSUME_NONNULL_END
