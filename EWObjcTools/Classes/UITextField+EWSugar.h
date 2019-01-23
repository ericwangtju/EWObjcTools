//
//  UITextField+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UITextField`.
 */
@interface UITextField (EWSugar)

/**
 Set all text selected.
 */
- (void)selectAllText;

/**
 Set text in range selected.
 
 @param range  The range of selected text in a document.
 */
- (void)setSelectedRange:(NSRange)range;


/**
 实例化 UITextField

 @param placeHolder 占位文本
 @return <#return value description#>
 */
+ (nonnull instancetype)ew_textFieldWithPlaceHolder:(nonnull NSString *)placeHolder;

/** 跟随UITextView的脚步 */
@property (nonatomic, assign) NSRange ew_selectedRange;

/** 是否高亮 */
@property (nonatomic, readonly) BOOL ew_isHighLighted;


/**
 输入无效,将已经数据的打回原形
 
 @param curContent 希望当前的显示内容
 */
- (void)ew_invalidTextFieldCurContent:(NSString*)curContent;

@end

NS_ASSUME_NONNULL_END

