//
//  UIControl+EWAvoidMutipleTouch.m
//  
//
//  Created by Eric on 2018/5/11.
//  Copyright © 2018年 Houtech. All rights reserved.
//

#import "UIControl+EWAvoidMutipleTouch.h"
#import <objc/runtime.h>
@implementation UIControl (EWAvoidMutipleTouch)
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

static const char *UIcontrol_ignoreEvent = "UIcontrol_ignoreEvent";

- (NSTimeInterval)ew_acceptEventInterval {
  
  return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
  
}

- (void)setEw_acceptEventInterval:(NSTimeInterval)ew_acceptEventInterval {
  
  objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(ew_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
}

- (BOOL)ew_ignoreEvent {
  
  return [objc_getAssociatedObject(self, UIcontrol_ignoreEvent) boolValue];
  
}

- (void)setEw_ignoreEvent:(BOOL)ew_ignoreEvent {
  
  objc_setAssociatedObject(self, UIcontrol_ignoreEvent, @(ew_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
}

+ (void)load {
  
  Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
  
  Method b = class_getInstanceMethod(self, @selector(__ew_sendAction:to:forEvent:));
  
  method_exchangeImplementations(a, b);
  
}

- (void)__ew_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
  
  if (self.ew_ignoreEvent) return;
  
  if (self.ew_acceptEventInterval > 0) {
    
    self.ew_ignoreEvent = YES;
    
    [self performSelector:@selector(setEw_ignoreEvent:) withObject:@(NO) afterDelay:self.ew_acceptEventInterval];
    
  }
  
  [self __ew_sendAction:action to:target forEvent:event];
  
}

@end
