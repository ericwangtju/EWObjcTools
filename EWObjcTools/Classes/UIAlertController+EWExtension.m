//
//  UIAlertController+EWExtension.m
//  iOS_Orange
//
//  Created by Eric Wang on 2015/11/4.
//  Copyright © 2015年 Ljun. All rights reserved.
//

#import "UIAlertController+EWExtension.h"
#import "UIColor+EWSugar.h"

@implementation UIAlertController (EWExtension)
- (void)setTitleWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize andTitleColorHex:(NSString *)colorString {
    
    [self setAttributeStringWithString:self.title Attribut:@"attributedTitle" FontName:fontName fontSize:fontSize andTitleColorHex:colorString];
}


- (void)setMessageWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize andTitleColorHex:(NSString *)colorString {
    [self setAttributeStringWithString:self.message Attribut:@"attributedMessage" FontName:fontName fontSize:fontSize andTitleColorHex:colorString];
}

- (void)setAttributeStringWithString:(NSString *)str Attribut:(NSString *)attribute  FontName:(NSString *)fontName fontSize:(CGFloat)fontSize andTitleColorHex:(NSString *)colorString {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontName size:fontSize] range:NSMakeRange(0, [[attStr string] length])];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:colorString] range:NSMakeRange(0, [[attStr string] length])];
        [self setValue:attStr forKey:attribute];
}

@end
