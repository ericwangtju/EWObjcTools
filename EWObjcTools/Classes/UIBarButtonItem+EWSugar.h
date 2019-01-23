//
//  UIBarButtonItem+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (EWSugar)

/**
 当item被唤醒的时候调用block。会出现引用
 @discussion 这个会与addTarget冲突
 */
@property (nullable, nonatomic, copy) void (^actionBlock)(id);

@end

NS_ASSUME_NONNULL_END

