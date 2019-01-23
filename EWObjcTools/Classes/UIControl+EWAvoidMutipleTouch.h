//
//  UIControl+EWAvoidMutipleTouch.h
//  
//
//  Created by Eric on 2018/5/11.
//  Copyright © 2018年 Houtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (EWAvoidMutipleTouch)
@property (nonatomic, assign) NSTimeInterval ew_acceptEventInterval;//添加点击事件的间隔时间

@property (nonatomic, assign) BOOL ew_ignoreEvent;//是否忽略点击事件,不响应点击事件
@end
