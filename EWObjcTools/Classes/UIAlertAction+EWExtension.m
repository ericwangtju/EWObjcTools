//
//  UIAlertAction+EWExtension.m
//  iOS_Orange
//
//  Created by Eric Wang on 2015/11/4.
//  Copyright © 2015年 Ljun. All rights reserved.
//

#import "UIAlertAction+EWExtension.h"
#import "UIColor+EWSugar.h"
#import <CoreText/CoreText.h>
@implementation UIAlertAction (EWExtension)
- (void)setTitleColorWithHexString:(NSString *)HexString {
    [self setValue:[UIColor colorWithHexString:HexString] forKey:@"_titleTextColor"];
}

- (void)setAttributeStringWithString:(NSString *)str Attribut:(NSString *)attribute  FontName:(NSString *)fontName fontSize:(CGFloat)fontSize andTitleColorHex:(NSString *)colorString {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontName size:kFontGeezScript] range:NSMakeRange(0, [[attStr string] length])];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:colorString] range:NSMakeRange(0, [[attStr string] length])];
    [self setValue:attStr forKey:attribute];
}
@end
