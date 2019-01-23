//
//  UIViewController+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (EWSugar)
/**
 * 在当前视图控制器中添加子控制器，将子控制器的视图添加到 view 中
 *
 * @param childController 要添加的子控制器
 * @param view            要添加到的视图
 */
- (void)ew_addChildController:(UIViewController *)childController intoView:(UIView *)view;

- (void)ew_addChildViewController:(UIViewController *)viewController;

- (void)ew_removeChildViewController:(UIViewController *)viewController;

- (UIViewController *)topmostViewController;
@end

NS_ASSUME_NONNULL_END
