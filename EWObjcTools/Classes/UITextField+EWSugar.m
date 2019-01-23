//
//  UITextField+EWSugar.m
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import "UITextField+EWSugar.h"
#import "EWCategoriesMacro.h"

EWSYNTH_DUMMY_CLASS(UITextField_EWSugar)
@implementation UITextField (EWSugar)

- (void)selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

+ (instancetype)ew_textFieldWithPlaceHolder:(NSString *)placeHolder {
    
    UITextField *textField = [[self alloc] init];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = placeHolder;
    
    return textField;
}

- (NSRange)ew_selectedRange
{
  UITextPosition* beginning = self.beginningOfDocument;
  
  UITextRange* selectedRange = self.selectedTextRange;
  UITextPosition* selectionStart = selectedRange.start;
  UITextPosition* selectionEnd = selectedRange.end;
  
  const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
  const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
  
  return NSMakeRange(location, length);
}

- (void)setEw_selectedRange:(NSRange)hg_selectedRange
{
  UITextPosition* beginning = self.beginningOfDocument;
  
  UITextPosition* startPosition = [self positionFromPosition:beginning offset:hg_selectedRange.location];
  UITextPosition* endPosition = [self positionFromPosition:beginning offset:hg_selectedRange.location + hg_selectedRange.length];
  UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
  
  [self setSelectedTextRange:selectionRange];
}

- (BOOL)ew_isHighLighted {
  UITextRange *selectedRange = [self markedTextRange];
  UITextPosition *pos = [self positionFromPosition:selectedRange.start offset:0];
  return (selectedRange && pos);
  
}


/**
 输入无效,将已经数据的打回原形
 
 @param curContent 希望当前的显示内容
 */
- (void)ew_invalidTextFieldCurContent:(NSString*)curContent {
  // 保留光标的位置信息
  NSRange selectedRange = self.ew_selectedRange;
  // 保留当前文本的内容
  NSString* tmpSTR = self.text;
  
  // 设置了文本,光标到了最后
  self.text = curContent;
  
  // 重新设置光标的位置
  selectedRange.location -= (tmpSTR.length - curContent.length);
  
  [self setEw_selectedRange:selectedRange];
}


@end

