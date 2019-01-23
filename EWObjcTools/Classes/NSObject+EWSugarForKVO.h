//
//  NSObject+EWSugarForKVO.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

/**
 Observer with block (KVO).
 */
@interface NSObject (EWSugarForKVO)

/**
 * 为指定的key-path的接收者添加block来接收kvo的通知
 Registers a block to receive KVO notifications for the specified key-path
 relative to the receiver.
 
 @discussion block和block持有的对象会被retain，需要使用'removeObserverBlocksForKeyPath'和或者'removeObserverBlocks'来释放
 observe. This value must not be nil. 不能为nil
 
 @param block  kvo的通知
 */
- (void)addObserverBlockForKeyPath:(NSString*)keyPath
                             block:(void (^)(id _Nonnull obj, id _Nonnull oldVal, id _Nonnull newVal))block;

// 释放指定的key-path的监听block
- (void)removeObserverBlocksForKeyPath:(NSString*)keyPath;

/**
 移除所有的key-path的监听block
 */
- (void)removeObserverBlocks;

@end

NS_ASSUME_NONNULL_END

