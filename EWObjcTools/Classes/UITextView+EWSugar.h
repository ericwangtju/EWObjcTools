//
//  UITextView+EWSugar.h
//  
//
//  Created by Eric on 2018/6/4.
//  Copyright © 2018年 Houtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (EWSugar)
/**
 * 获取高亮部分
 */
- (NSInteger)ew_getInputLengthWithText:(NSString *)text;

/** 是否高亮 */
@property (nonatomic, readonly) BOOL ew_isHighLighted;


/**
 输入无效,将已经数据的打回原形
 
 @param curContent 希望当前的显示内容
 */
- (void)ew_invalidTextFieldCurContent:(NSString*)curContent;
@end
