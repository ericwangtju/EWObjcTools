//
//  NSTimer+EWSugar.m
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import "NSTimer+EWSugar.h"
#import "EWCategoriesMacro.h"

EWSYNTH_DUMMY_CLASS(NSTimer_EWSugar)


@implementation NSTimer (EWSugar)
+ (void)_ew_ExecBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(_ew_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(_ew_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

@end
