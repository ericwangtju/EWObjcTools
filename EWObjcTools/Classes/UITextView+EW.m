//
//  UITextView+EW.m
//  
//
//  Created by Eric on 2018/7/2.
//  Copyright © 2018年 Houtech. All rights reserved.
//

#import "UITextView+EW.h"
#import <objc/runtime.h>
#import "UtilsMacros.h"

// 占位文字
static const void *EWPlaceholderViewKey = &EWPlaceholderViewKey;
// 占位文字颜色
static const void *EWPlaceholderColorKey = &EWPlaceholderColorKey;
// 最大高度
static const void *EWTextViewMaxHeightKey = &EWTextViewMaxHeightKey;
// 最小高度
static const void *EWTextViewMinHeightKey = &EWTextViewMinHeightKey;
// 高度变化的block
static const void *EWTextViewHeightDidChangedBlockKey = &EWTextViewHeightDidChangedBlockKey;
// 存储添加的图片
static const void *EWTextViewImageArrayKey = &EWTextViewImageArrayKey;
// 存储最后一次改变高度后的值
static const void *EWTextViewLastHeightKey = &EWTextViewLastHeightKey;

@interface UITextView ()

// 存储添加的图片
@property (nonatomic, strong) NSMutableArray *ew_imageArray;
// 存储最后一次改变高度后的值
@property (nonatomic, assign) CGFloat lastHeight;

@end

@implementation UITextView (EW)

#pragma mark - Swizzle Dealloc
+ (void)load {
  // 交换dealoc
  Method dealoc = class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc"));
  Method myDealloc = class_getInstanceMethod(self.class, @selector(myDealloc));
  method_exchangeImplementations(dealoc, myDealloc);
}

- (void)myDealloc {
  // 移除监听
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  UITextView *placeholderView = objc_getAssociatedObject(self, EWPlaceholderViewKey);
  
  // 如果有值才去调用，这步很重要
  if (placeholderView) {
    NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
    for (NSString *property in propertys) {
      @try {
        [self removeObserver:self forKeyPath:property];
      } @catch (NSException *exception) {}
    }
  }
  [self myDealloc];
}

#pragma mark - set && get
- (UITextView *)ew_placeholderView {
  
  // 为了让占位文字和textView的实际文字位置能够完全一致，这里用UITextView
  UITextView *placeholderView = objc_getAssociatedObject(self, EWPlaceholderViewKey);
  
  if (!placeholderView) {
    
    // 初始化数组
    self.ew_imageArray = [NSMutableArray array];
    
    placeholderView = [[UITextView alloc] init];
    // 动态添加属性的本质是: 让对象的某个属性与值产生关联
    objc_setAssociatedObject(self, EWPlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    placeholderView = placeholderView;
    
    // 设置基本属性
    placeholderView.scrollEnabled = placeholderView.userInteractionEnabled = NO;
    //        self.scrollEnabled = placeholderView.scrollEnabled = placeholderView.showsHorizontalScrollIndicator = placeholderView.showsVerticalScrollIndicator = placeholderView.userInteractionEnabled = NO;
    placeholderView.textColor = [UIColor lightGrayColor];
    placeholderView.backgroundColor = [UIColor clearColor];
    [self refreshPlaceholderView];
    [self addSubview:placeholderView];
    
    // 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange) name:UITextViewTextDidChangeNotification object:self];
    
    // 这些属性改变时，都要作出一定的改变，尽管已经监听了TextDidChange的通知，也要监听text属性，因为通知监听不到setText：
    NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
    
    // 监听属性
    for (NSString *property in propertys) {
      [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
    }
    
  }
  return placeholderView;
}

- (void)setEw_placeholder:(NSString *)placeholder
{
  // 为placeholder赋值
  [self ew_placeholderView].text = placeholder;
}

- (NSString *)ew_placeholder
{
  // 如果有placeholder值才去调用，这步很重要
  if (self.placeholderExist) {
    return [self ew_placeholderView].text;
  }
  return nil;
}

- (void)setEw_placeholderColor:(UIColor *)ew_placeholderColor
{
  // 如果有placeholder值才去调用，这步很重要
  if (!self.placeholderExist) {
    EWLog(@"请先设置placeholder值！");
  } else {
    self.ew_placeholderView.textColor = ew_placeholderColor;
    
    // 动态添加属性的本质是: 让对象的某个属性与值产生关联
    objc_setAssociatedObject(self, EWPlaceholderColorKey, ew_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
}

- (UIColor *)ew_placeholderColor
{
  return objc_getAssociatedObject(self, EWPlaceholderColorKey);
}

- (void)setEw_maxHeight:(CGFloat)ew_maxHeight
{
  CGFloat max = ew_maxHeight;
  
  // 如果传入的最大高度小于textView本身的高度，则让最大高度等于本身高度
  if (ew_maxHeight < self.frame.size.height) {
    max = self.frame.size.height;
  }
  
  objc_setAssociatedObject(self, EWTextViewMaxHeightKey, [NSString stringWithFormat:@"%lf", max], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)ew_maxHeight
{
  return [objc_getAssociatedObject(self, EWTextViewMaxHeightKey) doubleValue];
}

- (void)setEw_minHeight:(CGFloat)ew_minHeight
{
  objc_setAssociatedObject(self, EWTextViewMinHeightKey, [NSString stringWithFormat:@"%lf", ew_minHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)ew_minHeight
{
  return [objc_getAssociatedObject(self, EWTextViewMinHeightKey) doubleValue];
}

- (void)setEw_textViewHeightDidChanged:(textViewHeightDidChangedBlock)ew_textViewHeightDidChanged
{
  objc_setAssociatedObject(self, EWTextViewHeightDidChangedBlockKey, ew_textViewHeightDidChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (textViewHeightDidChangedBlock)ew_textViewHeightDidChanged
{
  void(^textViewHeightDidChanged)(CGFloat currentHeight) = objc_getAssociatedObject(self, EWTextViewHeightDidChangedBlockKey);
  return textViewHeightDidChanged;
}

- (NSArray *)ew_getImages
{
  return self.ew_imageArray;
}

- (void)setLastHeight:(CGFloat)lastHeight {
  objc_setAssociatedObject(self, EWTextViewLastHeightKey, [NSString stringWithFormat:@"%lf", lastHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)lastHeight {
  return [objc_getAssociatedObject(self, EWTextViewLastHeightKey) doubleValue];
}

- (void)setEw_imageArray:(NSMutableArray *)ew_imageArray {
  objc_setAssociatedObject(self, EWTextViewImageArrayKey, ew_imageArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)ew_imageArray {
  return objc_getAssociatedObject(self, EWTextViewImageArrayKey);
}

- (void)ew_autoHeightWithMaxHeight:(CGFloat)maxHeight
{
  [self ew_autoHeightWithMaxHeight:maxHeight textViewHeightDidChanged:nil];
}
// 是否启用自动高度，默认为NO
static bool autoHeight = NO;
- (void)ew_autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(textViewHeightDidChangedBlock)textViewHeightDidChanged
{
  autoHeight = YES;
  [self ew_placeholderView];
  self.ew_maxHeight = maxHeight;
  if (textViewHeightDidChanged) self.ew_textViewHeightDidChanged = textViewHeightDidChanged;
}

#pragma mark - addImage
/* 添加一张图片 */
- (void)ew_addImage:(UIImage *)image
{
  [self ew_addImage:image size:CGSizeZero];
}

/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)ew_addImage:(UIImage *)image size:(CGSize)size
{
  [self ew_insertImage:image size:size index:self.attributedText.length > 0 ? self.attributedText.length : 0];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)ew_insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index
{
  [self ew_addImage:image size:size index:index multiple:-1];
}

/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)ew_addImage:(UIImage *)image multiple:(CGFloat)multiple
{
  [self ew_addImage:image size:CGSizeZero index:self.attributedText.length > 0 ? self.attributedText.length : 0 multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)ew_insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index
{
  [self ew_addImage:image size:CGSizeZero index:index multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 multiple:放大／缩小的倍数 */
- (void)ew_addImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index multiple:(CGFloat)multiple {
  if (image) [self.ew_imageArray addObject:image];
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
  NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
  textAttachment.image = image;
  CGRect bounds = textAttachment.bounds;
  if (!CGSizeEqualToSize(size, CGSizeZero)) {
    bounds.size = size;
    textAttachment.bounds = bounds;
  } else if (multiple <= 0) {
    CGFloat oldWidth = textAttachment.image.size.width;
    CGFloat scaleFactor = oldWidth / (self.frame.size.width - 10);
    textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
  } else {
    bounds.size = image.size;
    textAttachment.bounds = bounds;
  }
  
  NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
  [attributedString replaceCharactersInRange:NSMakeRange(index, 0) withAttributedString:attrStringWithImage];
  self.attributedText = attributedString;
  [self textViewTextChange];
  [self refreshPlaceholderView];
}


#pragma mark - KVO监听属性改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  [self refreshPlaceholderView];
  if ([keyPath isEqualToString:@"text"]) [self textViewTextChange];
}

// 刷新PlaceholderView
- (void)refreshPlaceholderView {
  
  UITextView *placeholderView = objc_getAssociatedObject(self, EWPlaceholderViewKey);
  
  // 如果有值才去调用，这步很重要
  if (placeholderView) {
    self.ew_placeholderView.frame = self.bounds;
    if (self.ew_maxHeight < self.bounds.size.height) self.ew_maxHeight = self.bounds.size.height;
    self.ew_placeholderView.font = self.font;
    self.ew_placeholderView.textAlignment = self.textAlignment;
    self.ew_placeholderView.textContainerInset = self.textContainerInset;
    self.ew_placeholderView.hidden = (self.text.length > 0 && self.text);
  }
}

// 处理文字改变
- (void)textViewTextChange {
  UITextView *placeholderView = objc_getAssociatedObject(self, EWPlaceholderViewKey);
  
  // 如果有值才去调用，这步很重要
  if (placeholderView) {
    self.ew_placeholderView.hidden = (self.text.length > 0 && self.text);
  }
  // 如果没有启用自动高度，不执行以下方法
  if (!autoHeight) return;
  if (self.ew_maxHeight >= self.bounds.size.height) {
    
    // 计算高度
    NSInteger currentHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    // 如果高度有变化，调用block
    if (currentHeight != self.lastHeight) {
      // 是否可以滚动
      self.scrollEnabled = currentHeight >= self.ew_maxHeight;
      CGFloat currentTextViewHeight = currentHeight >= self.ew_maxHeight ? self.ew_maxHeight : currentHeight;
      // 改变textView的高度
      if (currentTextViewHeight >= self.ew_minHeight) {
        CGRect frame = self.frame;
        frame.size.height = currentTextViewHeight;
        self.frame = frame;
        // 调用block
        if (self.ew_textViewHeightDidChanged) self.ew_textViewHeightDidChanged(currentTextViewHeight);
        // 记录当前高度
        self.lastHeight = currentTextViewHeight;
      }
    }
  }
  
  if (!self.isFirstResponder) [self becomeFirstResponder];
}

// 判断是否有placeholder值，这步很重要
- (BOOL)placeholderExist {
  
  // 获取对应属性的值
  UITextView *placeholderView = objc_getAssociatedObject(self, EWPlaceholderViewKey);
  
  // 如果有placeholder值
  if (placeholderView) return YES;
  
  return NO;
}

#pragma mark - 过期
- (NSString *)placeholder
{
  return self.ew_placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder
{
  self.ew_placeholder = placeholder;
}

- (UIColor *)placeholderColor
{
  return self.ew_placeholderColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
  self.ew_placeholderColor = placeholderColor;
}

- (void)setMaxHeight:(CGFloat)maxHeight
{
  self.ew_maxHeight = maxHeight;
}

- (CGFloat)maxHeight
{
  return self.maxHeight;
}

- (void)setMinHeight:(CGFloat)minHeight
{
  self.ew_minHeight = minHeight;
}

- (CGFloat)minHeight
{
  return self.ew_minHeight;
}

- (void)setTextViewHeightDidChanged:(textViewHeightDidChangedBlock)textViewHeightDidChanged
{
  self.ew_textViewHeightDidChanged = textViewHeightDidChanged;
}

- (textViewHeightDidChangedBlock)textViewHeightDidChanged
{
  return self.ew_textViewHeightDidChanged;
}

- (NSArray *)getImages
{
  return self.ew_getImages;
}

- (void)autoHeightWithMaxHeight:(CGFloat)maxHeight
{
  [self ew_autoHeightWithMaxHeight:maxHeight];
}

- (void)autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(void(^)(CGFloat currentTextViewHeight))textViewHeightDidChanged
{
  [self ew_autoHeightWithMaxHeight:maxHeight textViewHeightDidChanged:textViewHeightDidChanged];
}

- (void)addImage:(UIImage *)image
{
  [self ew_addImage:image];
}

- (void)addImage:(UIImage *)image size:(CGSize)size
{
  [self ew_addImage:image size:size];
}

- (void)insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index
{
  [self ew_insertImage:image size:size index:index];
}

- (void)addImage:(UIImage *)image multiple:(CGFloat)multiple
{
  [self ew_addImage:image multiple:multiple];
}

- (void)insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index
{
  [self ew_insertImage:image multiple:multiple index:index];
}

@end
