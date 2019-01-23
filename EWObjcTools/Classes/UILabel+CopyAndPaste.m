//
//  UILabel+CopyAndPaste.m
//  iOS_Orange
//
//  Created by 橘子 on 2017/9/5.
//  Copyright © 2017年 Ljun. All rights reserved.
//

#import "UILabel+CopyAndPaste.h"
#import <objc/runtime.h>
#import "UIView+EWSugar.h"
@implementation UILabel (CopyAndPaste)
- (void)addTouch {
    self.userInteractionEnabled = YES;  //用户交互的总开关
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(addgesture:)];
    [self addGestureRecognizer:touch];
}
- (void)addgesture:(UILongPressGestureRecognizer*) recognizer {
    
    [self becomeFirstResponder];
    self.backgroundColor = [UIColor grayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidden) name:UIMenuControllerWillHideMenuNotification object:nil];
    if ([UIMenuController sharedMenuController].menuVisible) {
        return;
    }
    CGRect textRect  = CGRectMake(0, 0, [self calculateRowWidth:self.text]*2, 10);
    [[UIMenuController sharedMenuController] setTargetRect:textRect inView:self];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];

}
- (void)hidden{
    self.backgroundColor = [UIColor clearColor];
}
- (void)myCut:(UIMenuController *)menu{
    
}
- (void)myPaste:(UIMenuController *)menu{
    
}

// default is NO

- (BOOL)canBecomeFirstResponder {
    return YES;
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (action == @selector(copy:)) {
        return YES;
    }
    return NO;
    
}


//针对于copy的实现
- (void)copy:(UIMenuController *)menu{
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//    self.backgroundColor = [UIColor whiteColor];
    pboard.string = self.text;
    
}

- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.ew_width, 0)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}


@end
