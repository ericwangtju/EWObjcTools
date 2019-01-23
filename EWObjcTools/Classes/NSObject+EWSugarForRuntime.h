//
//  NSObject+EWRuntime.h
//  108-Additions
//
//  Created by Eric Wang on 17/4/11.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EWSugarForRuntime)

/**
 * 使用字典数组创建当前类对象的数组
 * @param array 字典数组
 * @return 当前类对象的数组
 */
+ (NSArray *)ew_objectsWithArray:(NSArray *)array;

/**
 * 返回当前类的属性数组
 * @return 属性数组
 */
+ (NSArray *)ew_propertiesList;

/**
 * 返回当前类的成员变量数组
 * @return 成员变量数组
 */
+ (NSArray *)ew_ivarsList;
@end
