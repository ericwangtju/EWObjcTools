//
//  NSString+EWSugar.m
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import "NSString+EWSugar.h"
#import "NSData+EWSugar.h"
#import "EWCategoriesMacro.h"
#import "NSNumber+EWSugar.h"
#import "UtilsMacros.h"
EWSYNTH_DUMMY_CLASS(NSString_EWSugar)

static inline BOOL IsEmpty(id thing) {
  return thing == nil ||
  ([thing isEqual:[NSNull null]]) ||
  ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
  ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

@implementation NSString (EWSugar)

+ (NSString *)hexStringFromString:(NSString *)string {
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

- (NSString *)md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md2String];
}

- (NSString *)md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md4String];
}

- (NSString *)md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}

- (NSString *)sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1String];
}

- (NSString *)sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha224String];
}

- (NSString *)sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha256String];
}

- (NSString *)sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha384String];
}

- (NSString *)sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha512String];
}

- (NSString *)crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] crc32String];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacMD5StringWithKey:key];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA1StringWithKey:key];
}

- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA224StringWithKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA256StringWithKey:key];
}

- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA384StringWithKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA512StringWithKey:key];
}

- (NSString *)base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [NSData dataWithBase64EncodedString:base64EncodedString];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)stringByURLEncode {
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        /**
         AFNetworking/AFURLRequestSerialization.m
         
         Returns a percent-escaped string following RFC 3986 for a query string key or value.
         RFC 3986 states that the following characters are "reserved" characters.
         - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
         - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
         In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
         query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
         should be percent-escaped in the query string.
         - parameter string: The string to be percent-escaped.
         - returns: The percent-escaped string.
         */
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < self.length) {
            NSUInteger length = MIN(self.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            // To avoid breaking up character sequences such as 👴🏻👮🏽
            range = [self rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [self substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)stringByURLDecode {
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return self;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
                case 34: esc = @"&quot;"; break;
                case 38: esc = @"&amp;"; break;
                case 39: esc = @"&apos;"; break;
                case 60: esc = @"&lt;"; break;
                case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGSize)stringSizeWithFont:(UIFont *)font {
  CGSize reSize = CGSizeZero;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
  reSize = [self sizeWithAttributes:@{ NSFontAttributeName: font }];
#else
  reSize = [self sizeWithFont:font];
#endif
  return CGSizeMake(ceil(reSize.width), ceil(reSize.height));
}

- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
         lineBreakMode:(NSLineBreakMode)lineBreakMode
             alignment:(NSTextAlignment)alignment {
  CGSize reSize = CGSizeZero;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
  NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
  paragraph.lineBreakMode = lineBreakMode;
  paragraph.alignment = alignment;
  
  NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:self
                                                                      attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraph}];
  CGSize labelsize = [attributeText boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
  reSize = CGSizeMake(ceilf(labelsize.width), ceilf(labelsize.height));
#else
  reSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#endif
  return CGSizeMake(ceil(reSize.width), ceil(reSize.height));
}

/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle font:(UIFont*)font
{
  NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
  [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
  [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
  NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
  CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
  
  //    EWLog(@"size:%@", NSStringFromCGSize(rect.size));
  
  //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
  if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
    if ([self containChinese:self]) {  //如果包含中文
      rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
    }
  }
  
  
  return CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
}



/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing
{
  NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.lineSpacing = lineSpacing;
  [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
  [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
  NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
  CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
  
  //    EWLog(@"size:%@", NSStringFromCGSize(rect.size));
  
  //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
  if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
    if ([self containChinese:self]) {  //如果包含中文
      rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
    }
  }
  
  
  return CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
}



/**
 *  计算最大行数文字高度,可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines{
  
  if (maxLines <= 0) {
    return 0;
  }
  
  CGFloat maxHeight = font.lineHeight * maxLines + lineSpacing * (maxLines - 1);
  
  CGSize orginalSize = [self boundingRectWithSize:size font:font lineSpacing:lineSpacing];
  
  if ( orginalSize.height >= maxHeight ) {
    return ceilf(maxHeight);
  }else{
    return ceilf(orginalSize.height);
  }
}

/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing{
  
  CGFloat height = [self boundingRectWithSize:size font:font lineSpacing:lineSpacing].height;
  
  if (height - lineSpacing > font.lineHeight ) {
    return YES;
  }else{
    return NO;
  }
}



//判断是否包含中文
- (BOOL)containChinese:(NSString *)str {
  for(int i=0; i< [str length];i++){
    int a = [str characterAtIndex:i];
    if( a > 0x4e00 && a < 0x9fff){
      return YES;
    }
  }
  return NO;
}
- (NSAttributedString *)attributedWithFont:(UIFont *)font
                                     color:(UIColor *)color
                                      size:(CGSize)size
                             lineBreakMode:(NSLineBreakMode)lineBreakMode
                                 alignment:(NSTextAlignment)alignment
                               lineSpacing:(CGFloat)lineSpacing
{
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  
  if ([self isMoreThanOneLineWithSize:size font:font lineSpaceing:lineSpacing]) {
    style.lineSpacing = lineSpacing;
  }
  style.lineBreakMode = lineBreakMode;
  style.alignment = alignment;
  NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:self
                                                                      attributes:@{NSFontAttributeName:font,
                                                                                   NSForegroundColorAttributeName:color,
                                                                                   NSParagraphStyleAttributeName:style}];
  return attributeText;
  
}






- (BOOL)matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:NULL];
    if (!pattern) return NO;
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}

- (void)enumerateRegexMatches:(NSString *)regex
                      options:(NSRegularExpressionOptions)options
                   usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block {
    if (regex.length == 0 || !block) return;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!regex) return;
    [pattern enumerateMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        block([self substringWithRange:result.range], result.range, stop);
    }];
}

- (NSString *)stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement; {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!pattern) return self;
    return [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
}

/**
 * 通过 regexTEXT 进行匹配
 */
- (BOOL)ew_regexMatchWithPattern:(NSString*)pattern {
  
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
  return [pred evaluateWithObject:self];
}

/**
 * 基本匹配
 */
- (BOOL)ew_regexMatchWithType:(EWRegexType)rType {
  // 默认支持空字符串返回为YES的情况
  return [self ew_regexMatchWithType:rType returnWhenEmpty:YES];
}

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 */
- (BOOL)ew_regexMatchWithType:(EWRegexType)rType returnWhenEmpty:(BOOL)empty {
  if (rType == EWRegexTypeNone) {
    // 没有任何的限制
    return YES;
  }
  
  if (self.length == 0) {
    return empty;
  }
  
  // 非空, 进行基本匹配
  NSString *regex = [self p_regexMatchesWithType:rType];
  return [self ew_regexMatchWithPattern:regex];
}

/**
 * 基本匹配: 默认支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)ew_regexMatchWithType:(EWRegexType)rType maxLimitLength:(NSUInteger)maxLimit {
  return [self ew_regexMatchWithType:rType maxLimitLength:maxLimit returnWhenEmpty:YES ];
}

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)ew_regexMatchWithType:(EWRegexType)rType maxLimitLength:(NSUInteger)maxLimit returnWhenEmpty:(BOOL)empty {
  if (self.length > maxLimit) {
    return NO;
  }
  
  return [self ew_regexMatchWithType:rType returnWhenEmpty:empty];
}

#pragma mark -
#pragma mark - private
- (NSString*)p_regexMatchesWithType:(EWRegexType)rType {
  
  NSString *regex = @"";
  if (rType & EWRegexTypeDigital) {
    // 数字
    regex = [NSString stringWithFormat:@"%@\\d", regex];
  }
  
  if (rType & EWRegexTypeChinese) {
    // 中文
    regex = [NSString stringWithFormat:@"➋➌➍➎➏➐➑➒%@\u4e00-\u9fa5", regex];
  }
  
  if (rType & EWRegexTypeCharacter) {
    // 字符
    regex = [NSString stringWithFormat:@"%@a-zA-Z", regex];
  }
  
  if (rType & EWRegexTypeSpace) {
    // 空格
    regex = [NSString stringWithFormat:@"%@ ", regex];
  }
  
  if (rType & EWRegexTypeUnderline) {
    // 下划线
    regex = [NSString stringWithFormat:@"%@_", regex];
  }
  
  if (rType & EWRegexTypeDot) {
    // 点
    regex = [NSString stringWithFormat:@"%@.", regex];
  }
  
  if (rType & EWRegexTypeAT) {
    // @
    regex = [NSString stringWithFormat:@"%@@", regex];
  }
  
  regex = [NSString stringWithFormat:@"^[%@]+$", regex];
  return regex;
}

- (NSString *)ew_replaceStringInPattern:(NSString *)pattern withString:(NSString *)toString {
  NSError *error = nil;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
  NSArray<NSTextCheckingResult *> *result = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
  NSString *retStr = [self copy];
  if (result) {
    for (int i = 0; i<result.count; i++) {
      NSTextCheckingResult *res = result[i];
      retStr = [retStr stringByReplacingOccurrencesOfString:[self substringWithRange:res.range]
                                                 withString:toString];
    }
  }
  return retStr;
}



- (char)charValue {
    return self.numberValue.charValue;
}

- (unsigned char) unsignedCharValue {
    return self.numberValue.unsignedCharValue;
}

- (short) shortValue {
    return self.numberValue.shortValue;
}

- (unsigned short) unsignedShortValue {
    return self.numberValue.unsignedShortValue;
}

- (unsigned int) unsignedIntValue {
    return self.numberValue.unsignedIntValue;
}

- (long) longValue {
    return self.numberValue.longValue;
}

- (unsigned long) unsignedLongValue {
    return self.numberValue.unsignedLongValue;
}

- (unsigned long long) unsignedLongLongValue {
    return self.numberValue.unsignedLongLongValue;
}

- (NSUInteger) unsignedIntegerValue {
    return self.numberValue.unsignedIntegerValue;
}


+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *)stringWithUTF32Char:(UTF32Char)char32 {
    char32 = NSSwapHostIntToLittle(char32);
    return [[NSString alloc] initWithBytes:&char32 length:4 encoding:NSUTF32LittleEndianStringEncoding];
}

+ (NSString *)stringWithUTF32Chars:(const UTF32Char *)char32 length:(NSUInteger)length {
    return [[NSString alloc] initWithBytes:(const void *)char32
                                    length:length * 4
                                  encoding:NSUTF32LittleEndianStringEncoding];
}

- (void)enumerateUTF32CharInRange:(NSRange)range usingBlock:(void (^)(UTF32Char char32, NSRange range, BOOL *stop))block {
    NSString *str = self;
    if (range.location != 0 || range.length != self.length) {
        str = [self substringWithRange:range];
    }
    NSUInteger len = [str lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4;
    UTF32Char *char32 = (UTF32Char *)[str cStringUsingEncoding:NSUTF32LittleEndianStringEncoding];
    if (len == 0 || char32 == NULL) return;
    
    NSUInteger location = 0;
    BOOL stop = NO;
    NSRange subRange;
    UTF32Char oneChar;
    
    for (NSUInteger i = 0; i < len; i++) {
        oneChar = char32[i];
        subRange = NSMakeRange(location, oneChar > 0xFFFF ? 2 : 1);
        block(oneChar, subRange, &stop);
        if (stop) return;
        location += subRange.length;
    }
}

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)stringByAppendingNameScale:(CGFloat)scale {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    return [self stringByAppendingFormat:@"@%@x", @(scale)];
}

- (NSString *)stringByAppendingPathScale:(CGFloat)scale {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    NSString *ext = self.pathExtension;
    NSRange extRange = NSMakeRange(self.length - ext.length, 0);
    if (ext.length > 0) extRange.location -= 1;
    NSString *scaleStr = [NSString stringWithFormat:@"@%@x", @(scale)];
    return [self stringByReplacingCharactersInRange:extRange withString:scaleStr];
}

- (CGFloat)pathScale {
    if (self.length == 0 || [self hasSuffix:@"/"]) return 1;
    NSString *name = self.stringByDeletingPathExtension;
    __block CGFloat scale = 1;
    [name enumerateRegexMatches:@"@[0-9]+\\.?[0-9]*x$" options:NSRegularExpressionAnchorsMatchLines usingBlock: ^(NSString *match, NSRange matchRange, BOOL *stop) {
        scale = [match substringWithRange:NSMakeRange(1, match.length - 2)].doubleValue;
    }];
    return scale;
}

- (BOOL)isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)containsCharacterSet:(NSCharacterSet *)set {
    if (set == nil) return NO;
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

- (NSNumber *)numberValue {
    return [NSNumber numberWithString:self];
}

- (NSData *)dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSRange)rangeOfAll {
    return NSMakeRange(0, self.length);
}

- (id)jsonValueDecoded {
    return [[self dataValue] jsonValueDecoded];
}

+ (NSString *)stringNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}

#pragma mark - 获取路径
- (NSString *)ew_documentDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:self];
}

- (NSString *)ew_cacheDirecotry {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:self];
}

- (NSString *)ew_tmpDirectory {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self];
}

#pragma mark - 把大长串的数字做单位处理
+ (NSString *)changeAsset:(id)passStr
{
    NSString *amountStr = nil;
    if ([passStr isKindOfClass:[NSNumber class]]) {
        amountStr = [NSString stringWithFormat:@"%@", passStr];
    }
    if (amountStr && ![amountStr isEqualToString:@""])
    {
        NSInteger num = [amountStr integerValue];
        if (num<10000)
        {
            return amountStr;
        }
        else
        {
            NSString *str = [NSString stringWithFormat:@"%f",num/10000.0];
            NSRange range = [str rangeOfString:@"."];
            str = [str substringToIndex:range.location+2];
            if ([str hasSuffix:@".0"])
            {
                return [NSString stringWithFormat:@"%@万",[str substringToIndex:str.length-2]];
            }
            else
                return [NSString stringWithFormat:@"%@万",str];
        }
    }
    else
        return @"0";
}

+ (NSString *)reverseString:(NSString *)strSrc
{
    NSMutableString* reverseString = [[NSMutableString alloc] init];
    NSInteger charIndex = [strSrc length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[strSrc substringWithRange:subStrRange]];
    }
    return reverseString;
}

+ (BOOL)ew_checkEmail:(NSString *)input {
    return [[self class] input:input andRegex:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"];
}

+ (BOOL)ew_checkChineseName:(NSString *)input {
    return [[self class] input:input andRegex:@"^[\u4E00-\uFA29]{2,8}$"];
}

+ (BOOL)ew_checkPhoneNumber:(NSString *)input {
    return [[self class] input:input andRegex:@"^(([0\\+]\\d{2,3}-?)?(0\\d{2,3})-?)?(\\d{7,8})"];
}

+ (BOOL)ew_checkMobileNumber:(NSString *)input {
  /**
   移动：134、135、136、137、138、139、147、150、151、152、157、158、159、182、183、184、187、188、178、147、1703、1705、1706、198、148、1440
   联通：130、131、132、155、156、185、186、176、175、145、171、1707、1708、1709、166、146
   电信：133、1349、153、189、180、181、177、173、149、1700、1701、1702、199、1410
   */
    return [[self class] input:input andRegex:@"^1[3|4|5|6|7|8|9][0-9][0-9]{8}$"];
}

+ (BOOL)ew_checkValidateCode:(NSString *)input {
    return [[self class] input:input andRegex:@"(\\d{6})"];
}
+ (BOOL)input:(NSString *)input andRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:input];
}

+ (BOOL)ew_checkPassword:(NSString *)input {
    return [[self class] input:input andRegex:@"^[a-zA-Z0-9]{6,18}"];
}

+ (BOOL)ew_checkWithDrawMoney:(NSString *)input {
    return [[self class] input:input andRegex:@"^[0-9]{3,}|[2-9][0-9]$"];
}

+ (BOOL)ew_checkCharacterIsASCII:(NSString *)input {
  NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
  NSString *filtered = [[input componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
  return [input isEqualToString:filtered];
}


+ (BOOL)isBlankString:(NSString *)Str {
  if (!Str) {
    return YES;
  }
  if ([Str isKindOfClass:[NSNull class]]) {
    return YES;
  }
  NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  NSString *trimmedStr = [Str stringByTrimmingCharactersInSet:set];
  if (!trimmedStr.length) {
    return YES;
  }
  return NO;
}

- (NSString *)transferURLString {
  return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8));
}

- (NSURL *)convertUrl{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
  return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
#pragma clang diagnostic pop
}



- (NSString *)subStringToIndexInstead:(NSInteger)index {
  if (self==nil || ![self isKindOfClass:[NSString class]] || [self isEqualToString:@""] || index <= 0) {
    return nil;
  }
  if (self.length < 10) {
    return self;
  }
  NSString *subString = [self substringToIndex:index];
  NSString *appendString = [subString stringByAppendingString:@"..."];
  return appendString;
}

- (NSString *)stringWithMaxLength:(NSUInteger)maxLen {
  NSUInteger length = [self length];
  if (length <= maxLen || length <= 3) {
    return self;
  }else {
    return [NSString stringWithFormat:@"%@...", [self substringToIndex:maxLen - 3]];
  }
}


- (NSString *)urlWithoutParameters {
  NSRange r;
  NSString *newUrl;
  
  r = [self rangeOfString:@"?" options: NSBackwardsSearch];
  if (r.length > 0)
    newUrl = [self substringToIndex: NSMaxRange (r) - 1];
  else
    newUrl = self;
  
  return newUrl;
}

- (NSString *)stringByReplacingRange:(NSRange)aRange with:(NSString *)aString {
  unsigned int bufferSize;
  unsigned int selfLen = (unsigned int)[self length];
  unsigned int aStringLen = (unsigned int)[aString length];
  unichar *buffer;
  NSRange localRange;
  NSString *result;
  
  bufferSize = selfLen + aStringLen - (unsigned int)aRange.length;
  buffer = NSAllocateMemoryPages(bufferSize*sizeof(unichar));
  
  /* Get first part into buffer */
  localRange.location = 0;
  localRange.length = aRange.location;
  [self getCharacters:buffer range:localRange];
  
  /* Get middle part into buffer */
  localRange.location = 0;
  localRange.length = aStringLen;
  [aString getCharacters:(buffer+aRange.location) range:localRange];
  
  /* Get last part into buffer */
  localRange.location = aRange.location + aRange.length;
  localRange.length = selfLen - localRange.location;
  [self getCharacters:(buffer+aRange.location+aStringLen) range:localRange];
  
  /* Build output string */
  result = [NSString stringWithCharacters:buffer length:bufferSize];
  
  NSDeallocateMemoryPages(buffer, bufferSize);
  
  return result;
}

- (NSString *)trimmedString
{
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)htmlDecodedString
{
  NSMutableString *temp = [NSMutableString stringWithString:self];
  
  [temp replaceOccurrencesOfString:@"&amp;" withString:@"&" options:0 range:NSMakeRange(0, [temp length])];
  [temp replaceOccurrencesOfString:@"&gt;" withString:@">" options:0 range:NSMakeRange(0, [temp length])];
  [temp replaceOccurrencesOfString:@"&lt;" withString:@"<" options:0 range:NSMakeRange(0, [temp length])];
  [temp replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:0 range:NSMakeRange(0, [temp length])];
  [temp replaceOccurrencesOfString:@"&apos;" withString:@"'" options:0 range:NSMakeRange(0, [temp length])];
  
  return [NSString stringWithString:temp];
}

- (NSString *)htmlEncodedString
{
  NSMutableString *temp = [NSMutableString stringWithString:self];
  
  [temp replaceOccurrencesOfString:@"&" withString:@"&amp;" options:0 range:NSMakeRange(0, [temp length])];
  [temp replaceOccurrencesOfString:@">" withString:@"&gt;" options:0 range:NSMakeRange(0, [temp length])];
  [temp replaceOccurrencesOfString:@"<" withString:@"&lt;" options:0 range:NSMakeRange(0, [temp length])];
  [temp replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:0 range:NSMakeRange(0, [temp length])];
  [temp replaceOccurrencesOfString:@"'" withString:@"&apos;" options:0 range:NSMakeRange(0, [temp length])];
  
  return [NSString stringWithString:temp];
}

- (NSString *)urldecode {
  return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)urlencode {
  NSString *encUrl = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSUInteger len = [encUrl length];
  const char *c;
  c = [encUrl UTF8String];
  NSString *ret = @"";
  for(int i = 0; i < len; i++) {
    switch (*c) {
      case '~':
        ret = [ret stringByAppendingString:@"%7E"];
        break;
      case '/':
        ret = [ret stringByAppendingString:@"%2F"];
        break;
      case '\'':
        ret = [ret stringByAppendingString:@"%27"];
        break;
      case ';':
        ret = [ret stringByAppendingString:@"%3B"];
        break;
      case '?':
        ret = [ret stringByAppendingString:@"%3F"];
        break;
      case ':':
        ret = [ret stringByAppendingString:@"%3A"];
        break;
      case '@':
        ret = [ret stringByAppendingString:@"%40"];
        break;
      case '&':
        ret = [ret stringByAppendingString:@"%26"];
        break;
      case '=':
        ret = [ret stringByAppendingString:@"%3D"];
        break;
      case '+':
        ret = [ret stringByAppendingString:@"%2B"];
        break;
      case '$':
        ret = [ret stringByAppendingString:@"%24"];
        break;
      case ',':
        ret = [ret stringByAppendingString:@"%2C"];
        break;
      case '[':
        ret = [ret stringByAppendingString:@"%5B"];
        break;
      case ']':
        ret = [ret stringByAppendingString:@"%5D"];
        break;
      case '#':
        ret = [ret stringByAppendingString:@"%23"];
        break;
      case '!':
        ret = [ret stringByAppendingString:@"%21"];
        break;
      case '(':
        ret = [ret stringByAppendingString:@"%28"];
        break;
      case ')':
        ret = [ret stringByAppendingString:@"%29"];
        break;
      case '*':
        ret = [ret stringByAppendingString:@"%2A"];
        break;
      default:
        ret = [ret stringByAppendingFormat:@"%c", *c];
    }
    c++;
  }
  
  return ret;
}

/*
 * source: http://stackoverflow.com/questions/1967399/parse-nsurl-path-and-query-iphoneos
 */
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue outterGlue:(NSString *)outterGlue {
  // Explode based on outter glue
  NSArray *firstExplode = [self componentsSeparatedByString:outterGlue];
  NSArray *secondExplode;
  
  // Explode based on inner glue
  NSInteger count = [firstExplode count];
  NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
  for (NSInteger i = 0; i < count; i++) {
    secondExplode = [(NSString *)[firstExplode objectAtIndex:i] componentsSeparatedByString:innerGlue];
    if ([secondExplode count] == 2) {
      [returnDictionary setObject:[secondExplode objectAtIndex:1] forKey:[secondExplode objectAtIndex:0]];
    }
  }
  
  return returnDictionary;
}

- (NSMutableDictionary *)explodeToDictionaryInnerGlueUTF8Decode:(NSString *)innerGlue outterGlue:(NSString *)outterGlue isCompatibleMode:(BOOL) isCompatibleMode
{
  NSMutableDictionary *srcDictionary = [self explodeToDictionaryInnerGlue:innerGlue outterGlue:outterGlue];
  
  NSEnumerator* keyEnum = [srcDictionary keyEnumerator];
  NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionary];
  id key = nil;
  NSString* src = nil;
  NSString* dec = nil;
  while (key = [keyEnum nextObject])
  {
    src = [srcDictionary objectForKey:key];
    if ([src isKindOfClass:[NSString class]])
    {
      if (isCompatibleMode)
      {
        src = [src stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
      }
      dec = [src stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      if ([dec length] > 0)
      {
        src = dec;
      }
    }
    if (key && [key lowercaseString])
    {
      [returnDictionary setObject:src forKey:[key lowercaseString]];
    }
  }
  
  return returnDictionary;
}

+ (NSString *)firstNonNsNullStringWithString:(NSString*)string, ...
{
  NSString* result = nil;
  
  id arg = nil;
  va_list argList;
  
  if (string && [string isKindOfClass:[NSString class]])
  {
    return string;
  }
  
  va_start(argList, string);
  while ((arg = va_arg(argList, id)))
  {
    if (arg && [arg isKindOfClass:[NSString class]])
    {
      result = arg;
      break;
    }
  }
  va_end(argList);
  
  
  return result;
}



- (BOOL) hasSubstring:(NSString*)substring;
{
  if(IsEmpty(substring))
    return NO;
  NSRange substringRange = [self rangeOfString:substring];
  return substringRange.location != NSNotFound && substringRange.length > 0;
}

- (NSString*) substringAfterSubstring:(NSString*)substring;
{
  if([self hasSubstring:substring])
    return [self substringFromIndex:NSMaxRange([self rangeOfString:substring])];
  return nil;
}

//Note: -isCaseInsensitiveLike should work when avalible!
- (BOOL) isEqualToStringIgnoringCase:(NSString*)otherString;
{
  if(!otherString)
    return NO;
  return NSOrderedSame == [self compare:otherString options:NSCaseInsensitiveSearch + NSWidthInsensitiveSearch];
}

- (NSString*) stringByReplacingPercentEscapesOnce;
{
  NSString *unescaped = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  //self may be a string that looks like an invalidly escaped string,
  //eg @"100%", in that case it clearly wasn't escaped,
  //so we return it as our unescaped string.
  return unescaped ? unescaped : self;
}
- (NSString*) stringByAddingPercentEscapesOnce;
{
  return [[self stringByReplacingPercentEscapesOnce] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end
