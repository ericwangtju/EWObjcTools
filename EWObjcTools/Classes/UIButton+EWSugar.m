//
//  UIButton+EWSugar.m
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/19.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import "UIButton+EWSugar.h"
#import "EWCategoriesMacro.h"
#import <objc/runtime.h>

EWSYNTH_DUMMY_CLASS(UIButton_EWSugar)
@interface UIButton()
/**bool 类型 YES 不允许点击   NO 允许点击   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end



@implementation UIButton (EWSugar)
+ (instancetype)ew_buttonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor {
  NSAttributedString *attributedText = [[NSAttributedString alloc]
                                        initWithString:title
                                        attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                                     NSForegroundColorAttributeName: textColor}];
  
  return [self ew_buttonWithAttributedText:attributedText];
}

+ (instancetype)ew_buttonWithAttributedText:(NSAttributedString *)attributedText {
  return [self ew_buttonWithAttributedText:attributedText imageName:nil backImageName:nil highlightSuffix:nil];
}

+ (instancetype)ew_buttonWithImageName:(NSString *)imageName highlightSuffix:(NSString *)highlightSuffix {
  
  return [self ew_buttonWithAttributedText:nil imageName:imageName backImageName:nil highlightSuffix:highlightSuffix];
}

+ (instancetype)ew_buttonWithImageName:(NSString *)imageName backImageName:(NSString *)backImageName highlightSuffix:(NSString *)highlightSuffix {
  
  return [self ew_buttonWithAttributedText:nil imageName:imageName backImageName:backImageName highlightSuffix:highlightSuffix];
}

+ (instancetype)ew_buttonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor imageName:(NSString *)imageName backImageName:(NSString *)backImageName highlightSuffix:(NSString *)highlightSuffix {
  
  NSAttributedString *attributedText = [[NSAttributedString alloc]
                                        initWithString:title
                                        attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                                     NSForegroundColorAttributeName: textColor}];
  
  return [self ew_buttonWithAttributedText:attributedText imageName:imageName backImageName:backImageName highlightSuffix:highlightSuffix];
}

+ (instancetype)ew_buttonWithAttributedText:(NSAttributedString *)attributedText imageName:(NSString *)imageName backImageName:(NSString *)backImageName highlightSuffix:(NSString *)highlightSuffix {
  
  UIButton *button = [[self alloc] init];
  
  [button setAttributedTitle:attributedText forState:UIControlStateNormal];
  
  if (imageName != nil) {
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSString *highlightedImageName = [imageName stringByAppendingString:highlightSuffix];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
  }
  
  if (backImageName != nil) {
    [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    
    NSString *highlightedImageName = [backImageName stringByAppendingString:highlightSuffix];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
  }
  
  [button sizeToFit];
  
  return button;
}

+ (instancetype)ew_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor {
  return [self ew_textButton:title fontSize:fontSize normalColor:normalColor highlightedColor:highlightedColor backgroundImageName:nil];
}

+ (instancetype)ew_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName {
  
  UIButton *button = [[self alloc] init];
  
  [button setTitle:title forState:UIControlStateNormal];
  
  [button setTitleColor:normalColor forState:UIControlStateNormal];
  [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
  
  button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
  
  if (backgroundImageName != nil) {
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    
    NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
  }
  
  [button sizeToFit];
  
  return button;
}

+ (instancetype)ew_imageButton:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName {
  
  UIButton *button = [[self alloc] init];
  
  [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
  
  NSString *imageNameHL = [imageName stringByAppendingString:@"_highlighted"];
  [button setImage:[UIImage imageNamed:imageNameHL] forState:UIControlStateHighlighted];
  
  [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
  
  NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
  [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
  
  [button sizeToFit];
  
  return button;
}




+ (void)load{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    SEL selA = @selector(sendAction:to:forEvent:);
    SEL selB = @selector(mySendAction:to:forEvent:);
    Method methodA =   class_getInstanceMethod(self,selA);
    Method methodB = class_getInstanceMethod(self, selB);
    //将 methodB的实现 添加到系统方法中 也就是说 将 methodA方法指针添加成 方法methodB的  返回值表示是否添加成功
    BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
    //添加成功了 说明 本类中不存在methodB 所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
    if (isAdd) {
      class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
    }else{
      //添加失败了 说明本类中 有methodB的实现，此时只需要将 methodA和methodB的IMP互换一下即可。
      method_exchangeImplementations(methodA, methodB);
    }
  });
}
- (NSTimeInterval)timeInterval
{
  return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
  objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
}
//当我们按钮点击事件 sendAction 时  将会执行  mySendAction
- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
  if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
    
    self.timeInterval =self.timeInterval ==0 ?defaultInterval:self.timeInterval;
    if (self.isIgnoreEvent){
      return;
    }else if (self.timeInterval > 0){
      [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
    }
  }
  //此处 methodA和methodB方法IMP互换了，实际上执行 sendAction；所以不会死循环
  self.isIgnoreEvent = YES;
  [self mySendAction:action to:target forEvent:event];
}
//runtime 动态绑定 属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
  // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
  objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
  //_cmd == @select(isIgnore); 和set方法里一致
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)resetState{
  [self setIsIgnoreEvent:NO];
}


@end
