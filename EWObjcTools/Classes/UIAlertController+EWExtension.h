//
//  UIAlertController+EWExtension.h
//  iOS_Orange
//
//  Created by Eric Wang on 2015/11/4.
//  Copyright © 2015年 Ljun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (EWExtension)
- (void)setTitleWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize andTitleColorHex:(NSString *)colorString;

- (void)setMessageWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize andTitleColorHex:(NSString *)colorString;

@end
