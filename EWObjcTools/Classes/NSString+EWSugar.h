//
//  NSString+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSString (EWSugar)

+ (NSString *)hexStringFromString:(NSString *)string;

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 返回小写的md2加密字符串
 */
- (nullable NSString *)md2String;

/**
 返回小写的md4加密字符串
 */
- (nullable NSString *)md4String;

/**
 *  计算MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @return 32个字符的MD5散列字符串
 */
- (nullable NSString *)md5String;

/**
 *  计算SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (nullable NSString *)sha1String;

/**
 *  计算SHA224散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha224
 *  @endcode
 *
 *  @return 56个字符的SHA224散列字符串
 */
- (nullable NSString *)sha224String;

/**
 *  计算SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (nullable NSString *)sha256String;

/**
 *  计算SHA 384散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha384
 *  @endcode
 *
 *  @return 96个字符的SHA 384散列字符串
 */
- (nullable NSString *)sha384String;

/**
 *  计算SHA 512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512
 *  @endcode
 *
 *  @return 128个字符的SHA 512散列字符串
 */
- (nullable NSString *)sha512String;

/**
 *  计算HMAC MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl dgst -md5 -hmac "key"
 *  @endcode
 *
 *  @return 32个字符的HMAC MD5散列字符串
 */
- (nullable NSString *)hmacMD5StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1 -hmac "key"
 *  @endcode
 *
 *  @return 40个字符的HMAC SHA1散列字符串
 */
- (nullable NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64个字符的HMAC SHA256散列字符串
 */
- (nullable NSString *)hmacSHA224StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512 -hmac "key"
 *  @endcode
 *
 *  @return 128个字符的HMAC SHA512散列字符串
 */
- (nullable NSString *)hmacSHA256StringWithKey:(NSString *)key;

/**
 返回小写的HMAC字符串
 参数是SHA384key
 */
- (nullable NSString *)hmacSHA384StringWithKey:(NSString *)key;

/**
 返回小写的HMAC字符串
 参数是SHA512key
 */
- (nullable NSString *)hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 返回CRC32验证字符串
 */
- (nullable NSString *)crc32String;


#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 将字符串base64编码
 */
- (nullable NSString *)base64EncodedString;

/**
 将base64的字符串转为字符串
 */
+ (nullable NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 将字符串进行utf-8编码
 */
- (NSString *)stringByURLEncode;

/**
 将字符串进行utf-8解码
 */
- (NSString *)stringByURLDecode;

/**
 Escape commmon HTML to Entity.
 Example: "a>b" will be escape to "a&gt;b".
 */
- (NSString *)stringByEscapingHTML;

#pragma mark - Drawing
///=============================================================================
/// @name Drawing
///=============================================================================

/**
 返回一个字符串的尺寸
 参数1:字体
 参数2:可以接受的最大尺寸
 参数3:换行参数
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 返回一个字符串在一行显示的宽度
 */
- (CGFloat)widthForFont:(UIFont *)font;

/**
 返回一个字符串在指定最大宽度下的高度
 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;


// FIXME: 这里是临时引入
- (CGSize)stringSizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
         lineBreakMode:(NSLineBreakMode)lineBreakMode
             alignment:(NSTextAlignment)alignment;
/**
 * 计算文字高度，可以处理计算带行间距的等属性
 */
- (CGSize)boundingRectWithSize:(CGSize)size paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle font:(UIFont*)font;
/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
/**
 * 计算最大行数文字高度，可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines;

// 判断字符串是否包含中文
- (BOOL)containChinese:(NSString *)str ;

/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing;

- (NSAttributedString *)attributedWithFont:(UIFont *)font
                                     color:(UIColor *)color
                                      size:(CGSize)size
                             lineBreakMode:(NSLineBreakMode)lineBreakMode
                                 alignment:(NSTextAlignment)alignment
                               lineSpacing:(CGFloat)lineSpacing;


#pragma mark - Regular Expression
///=============================================================================
/// @name Regular Expression
///=============================================================================

/**
 是否匹配正则
 参数1:正则表达式
 */
- (BOOL)matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options;

/**
 Match the regular expression, and executes a given block using each object in the matches.
 
 @param regex    The regular expression
 @param options  The matching options to report.
 @param block    The block to apply to elements in the array of matches.
 The block takes four arguments:
 match: The match substring.
 matchRange: The matching options.
 stop: A reference to a Boolean value. The block can set the value
 to YES to stop further processing of the array. The stop
 argument is an out-only argument. You should only ever set
 this Boolean to YES within the Block.
 */
- (void)enumerateRegexMatches:(NSString *)regex
                      options:(NSRegularExpressionOptions)options
                   usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block;

/**
 Returns a new string containing matching regular expressions replaced with the template string.
 
 @param regex       The regular expression
 @param options     The matching options to report.
 @param replacement The substitution template used when replacing matching instances.
 
 @return A string with matching regular expressions replaced by the template string.
 */
- (NSString *)stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement;


// 基本匹配 : 数字, 汉字, 字符, 空格, 下划线, 点, @
typedef NS_OPTIONS(NSUInteger, EWRegexType) {
  EWRegexTypeNone      = 0 << 0, // 未知
  EWRegexTypeDigital   = 1 << 0, // 数字
  EWRegexTypeChinese   = 1 << 1, // 汉字
  EWRegexTypeCharacter = 1 << 2, // 字符
  EWRegexTypeSpace     = 1 << 3, // 空格
  EWRegexTypeUnderline = 1 << 4, // 下划线
  EWRegexTypeDot       = 1 << 5, // 点
  EWRegexTypeAT        = 1 << 6, // @
};


/**
 * 通过 pattern 进行匹配
 */
- (BOOL)ew_regexMatchWithPattern:(NSString*)pattern;

/**
 * 基本匹配: 默认支持空字符串返回为YES的情况
 */
- (BOOL)ew_regexMatchWithType:(EWRegexType)rType;

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 */
- (BOOL)ew_regexMatchWithType:(EWRegexType)rType returnWhenEmpty:(BOOL)empty;

/**
 * 基本匹配: 默认支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)ew_regexMatchWithType:(EWRegexType)rType
               maxLimitLength:(NSUInteger)maxLimit;

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)ew_regexMatchWithType:(EWRegexType)rType maxLimitLength:(NSUInteger)maxLimit returnWhenEmpty:(BOOL)empty ;


- (NSString*)ew_replaceStringInPattern:(NSString *)pattern withString:(NSString*)toString;

#pragma mark - NSNumber Compatible
///=============================================================================
/// @name NSNumber Compatible
///=============================================================================

// Now you can use NSString as a NSNumber.
@property (readonly) char charValue;
@property (readonly) unsigned char unsignedCharValue;
@property (readonly) short shortValue;
@property (readonly) unsigned short unsignedShortValue;
@property (readonly) unsigned int unsignedIntValue;
@property (readonly) long longValue;
@property (readonly) unsigned long unsignedLongValue;
@property (readonly) unsigned long long unsignedLongLongValue;
@property (readonly) NSUInteger unsignedIntegerValue;


#pragma mark - Utilities
///=============================================================================
/// @name Utilities
///=============================================================================

/**
 返回一个UUID
 e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 */
+ (NSString *)stringWithUUID;

/**
 UTF32Char字符串转换为NSString,如果这个字符串为空,那么将返回为空
 */
+ (NSString *)stringWithUTF32Char:(UTF32Char)char32;

/**
 将一个UTF32字符数组转为NSString,参数1为UTF32字符数组的个数
 */
+ (NSString *)stringWithUTF32Chars:(const UTF32Char *)char32 length:(NSUInteger)length;

/**
 Enumerates the unicode characters (UTF-32) in the specified range of the string.
 
 @param range The range within the string to enumerate substrings.
 @param block The block executed for the enumeration. The block takes four arguments:
 char32: The unicode character.
 range: The range in receiver. If the range.length is 1, the character is in BMP;
 otherwise (range.length is 2) the character is in none-BMP Plane and stored
 by a surrogate pair in the receiver.
 stop: A reference to a Boolean value that the block can use to stop the enumeration
 by setting *stop = YES; it should not touch *stop otherwise.
 */
- (void)enumerateUTF32CharInRange:(NSRange)range usingBlock:(void (^)(UTF32Char char32, NSRange range, BOOL *stop))block;

/**
 将字符串的首尾的空格和换行去除
 */
- (NSString *)stringByTrim;

/**
 将一个字符串拼接上缩放比率
 From @"name" to @"name@2x".
 */
- (NSString *)stringByAppendingNameScale:(CGFloat)scale;

/**
 给一个文件路径添加缩放比例,如果没有后缀就不添加
 */
- (NSString *)stringByAppendingPathScale:(CGFloat)scale;

/**
 返回一个自定路径下文件的缩放比
 */
- (CGFloat)pathScale;

/**
 判断一个字符串是否为空,如果字符串仅仅是nil, @"", @"  ", @"\n"将返回NO
 */
- (BOOL)isNotBlank;


/**
 一个字符串是否包含指定的NSCharacterSet
 */
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;

/**
 Try to parse this string and returns an `NSNumber`.
 @return Returns an `NSNumber` if parse succeed, or nil if an error occurs.
 将一个字符串转为NSNumber
 如果失败了返回nil
 */
- (NSNumber *)numberValue;

/**
 将一个字符串转为NSData,使用UTF-8解码
 */
- (NSData *)dataValue;

/**
 返回字符串的range
 */
- (NSRange)rangeOfAll;

/**
 将一个json字符串进行反序列化,当转化失败返回nil
 e.g. NSString: @"{"name":"a","count":2}"  => NSDictionary: @[@"name":@"a",@"count":@2]
 */
- (id)jsonValueDecoded;

/**
 将一bundle中的文件转为字符串,使用UTF-8编码
 */
+ (NSString *)stringNamed:(NSString *)name;


#pragma mark - 拼接路径
/// 拼接了`文档目录`的全路径
@property (nullable, nonatomic, readonly) NSString *ew_documentDirectory;
/// 拼接了`缓存目录`的全路径
@property (nullable, nonatomic, readonly) NSString *ew_cacheDirecotry;
/// 拼接了临时目录的全路径
@property (nullable, nonatomic, readonly) NSString *ew_tmpDirectory;


#pragma mark - 把大长串的数字做单位处理
+ (NSString *)changeAsset:(id)passStr;


/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc;


#pragma mark - 内容
/**
 *  check the string is email
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)ew_checkEmail:(NSString *)input;

/**
 *  check the string is phone Number
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)ew_checkPhoneNumber:(NSString *)input;

/**
 *  check the string is chinese name
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)ew_checkChineseName:(NSString *)input;

/**
 *  check the string is valudate code
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)ew_checkValidateCode:(NSString *)input;

/**
 *  check the string is strong password string
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)ew_checkPassword:(NSString *)input;


/**
 *  check the string is mobile number
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)ew_checkMobileNumber:(NSString *)input;

/**
 *  check the string is validate money
 *
 *  @param input input string
 *
 *  @return true/false value
 */
+ (BOOL)ew_checkWithDrawMoney:(NSString *)input;


/**
 检查一个字符是否是ASCII码
 */
+ (BOOL)ew_checkCharacterIsASCII:(NSString *)input;


/**
 检查一个字符串是否为空

 @param Str 判断对象
 @return yes就是空,no非空
 */
+  (BOOL)isBlankString:(NSString *)Str;


- (NSString *)transferURLString;

/**
 url中文处理
 有时候我们加载的URL中可能会出现中文，需要我们手动进行转码，但是同时又要保证URL中的特殊字符保持不变

 @return 处理后的url
 */
- (NSURL *)convertUrl;



- (NSString *)subStringToIndexInstead:(NSInteger)index;




- (NSString *)stringWithMaxLength:(NSUInteger)maxLen;
- (NSString *)urlWithoutParameters;
- (NSString *)stringByReplacingRange:(NSRange)aRange with:(NSString *)aString;
- (NSString *)trimmedString;
- (NSString *)htmlDecodedString;
- (NSString *)htmlEncodedString;
- (NSString *)urlencode;
- (NSString *)urldecode;

+ (NSString *)firstNonNsNullStringWithString:(NSString*)string, ...;

// e.g. QueryString: param1=value1&param2=value2 , innerGlue:"=" , outterGlue:"&"
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue outterGlue:(NSString *)outterGlue;
- (NSMutableDictionary *)explodeToDictionaryInnerGlueUTF8Decode:(NSString *)innerGlue outterGlue:(NSString *)outterGlue isCompatibleMode:(BOOL) isCompatibleMode;


- (BOOL) hasSubstring:(NSString*)substring;


- (NSString*) substringAfterSubstring:(NSString*)substring;


//Note: -isCaseInsensitiveLike should work when avalible!
- (BOOL) isEqualToStringIgnoringCase:(NSString*)otherString;

- (NSString*) stringByReplacingPercentEscapesOnce;

- (NSString*) stringByAddingPercentEscapesOnce;



@end
NS_ASSUME_NONNULL_END
