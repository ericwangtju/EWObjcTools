//
//  UIViewController+EWSugar.m
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import "UIViewController+EWSugar.h"
#import "EWCategoriesMacro.h"

EWSYNTH_DUMMY_CLASS(UIViewController_EWSugar)
@implementation UIViewController (EWSugar)
- (void)ew_addChildController:(UIViewController *)childController intoView:(UIView *)view  {
    
    [self addChildViewController:childController];
    
    [view addSubview:childController.view];
    
    [childController didMoveToParentViewController:self];
}

- (void)ew_addChildViewController:(UIViewController *)viewController {
  if (viewController) {
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
  }
}

- (void)ew_removeChildViewController:(UIViewController *)viewController {
  if (viewController.parentViewController) {
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
  }
}

- (UIViewController *)topmostViewController {
  UIViewController *topmostViewController = self;
  while (topmostViewController.presentedViewController) {
    topmostViewController = topmostViewController.presentedViewController;
  }
  
  UINavigationController *nav = (UINavigationController *)topmostViewController;
  
  if ([nav isKindOfClass:[UINavigationController class]]) {
    topmostViewController = nav.topViewController;
  }
  
  return topmostViewController;
}
@end
