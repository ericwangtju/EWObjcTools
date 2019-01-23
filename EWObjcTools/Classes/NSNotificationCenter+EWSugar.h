//
//  NSNotificationCenter+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (EWSugar)

/**
在主线程中发送通知,如果当前线程就是主线程,那么就是同步发送,否则是异步
 如果通知为nil,那么会抛出异常
 */
- (void)postNotificationOnMainThread:(NSNotification *)notification;

/**
 在主线程发送通知,参数2表示当前线程是否要被阻塞，直到主线程将我们指定的代码块执行完.如果设置为no,那么会立即返回
 */
- (void)postNotificationOnMainThread:(NSNotification *)notification
                       waitUntilDone:(BOOL)wait;

/**
 
 在主线程发送通知
 @param name    通知的名称.
 
 @param object  发送通知的实体
 */
- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(nullable id)object;

/**
 在主线程发送通知
 @param name    通知的名称.
 
 @param object  发送通知的实体
 
 @param userInfo  通知的信息,可以为空
 */
- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(nullable id)object
                                    userInfo:(nullable NSDictionary *)userInfo;

/**
 在主线程发送通知
 @param name    通知的名称.
 
 @param object  发送通知的实体
 
 @param userInfo  通知的信息,可以为空
 
 @param wait  表示当前线程是否要被阻塞，直到主线程将我们制定的代码块执行完.如果设置为no,那么会立即返回
 */
- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(nullable id)object
                                    userInfo:(nullable NSDictionary *)userInfo
                               waitUntilDone:(BOOL)wait;

@end

NS_ASSUME_NONNULL_END
