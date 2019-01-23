//
//  UIBarButtonItem+EWSugar.m
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import "UIBarButtonItem+EWSugar.h"
#import "EWCategoriesMacro.h"
#import <objc/runtime.h>

EWSYNTH_DUMMY_CLASS(UIBarButtonItem_EWSugar)

static const int block_key;

@interface _EWUIBarButtonItemBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _EWUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end


@implementation UIBarButtonItem (EWSugar)
- (void)setActionBlock:(void (^)(id sender))block {
    _EWUIBarButtonItemBlockTarget *target = [[_EWUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id)) actionBlock {
    _EWUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}

@end
