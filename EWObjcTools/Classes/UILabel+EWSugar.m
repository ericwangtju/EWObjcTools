//
//  UILabel+EWSugar.m
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import "UILabel+EWSugar.h"
#import "EWCategoriesMacro.h"

EWSYNTH_DUMMY_CLASS(UILabel_EWSugar)
@implementation UILabel (EWSugar)
+ (instancetype)ew_labelWithText:(NSString *)text fontName:(NSString *)fontName fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment {
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    if (textColor) {
        label.textColor = textColor;
    }
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    label.font = [UIFont fontWithName:fontName size:fontSize];
    
    [label sizeToFit];
    
    return label;
}

+ (instancetype)ew_labelWithText:(NSString *)text {
    return [self ew_labelWithText:text fontSize:14 textColor:[UIColor darkGrayColor] alignment:NSTextAlignmentLeft];
}

+ (instancetype)ew_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize {
    return [self ew_labelWithText:text fontSize:fontSize textColor:[UIColor darkGrayColor] alignment:NSTextAlignmentLeft];
}

+ (instancetype)ew_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor {
    return [self ew_labelWithText:text fontSize:fontSize textColor:textColor alignment:NSTextAlignmentLeft];
}

+ (instancetype)ew_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    
    [label sizeToFit];
    
    return label;
}

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}
@end
