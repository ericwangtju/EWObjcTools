//
//  NSData+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSData (EWSugar)
#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 返回小写的md2加密字符串
 */
- (NSString *)md2String;

/**
 返回小写的md2加密二进制
 */
- (NSData *)md2Data;

/**
 返回小写的md4加密字符串
 */
- (NSString *)md4String;

/**
 返回小写的md4加密二进制
 */
- (NSData *)md4Data;

/**
 *  计算文件的MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 file.dat
 *  @endcode
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)md5String;

/**
 返回小写的md5加密二进制
 */
- (NSData *)md5Data;

/**
 *  计算文件的SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha1 file.dat
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)sha1String;

/**
 返回小写的SHA1二进制
 */
- (NSData *)sha1Data;

/**
 返回小写的SHA224字符串
 */
- (NSString *)sha224String;

/**
 返回小写的SHA224二进制
 */
- (NSData *)sha224Data;

/**
 *  计算文件的SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)sha256String;

/**
 返回小写的SHA256二进制
 */
- (NSData *)sha256Data;

/**
 返回小写的SHA384字符串
 */
- (NSString *)sha384String;

/**
 返回小写的SHA384二进制
 */
- (NSData *)sha384Data;

/**
 *  计算文件的SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha512 file.dat
 *  @endcode
 *
 *  @return 128个字符的SHA512散列字符串
 */
- (NSString *)sha512String;

/**
 返回小写的SHA512二进制
 */
- (NSData *)sha512Data;

/**
 返回小写的HMAC字符串
 参数是MD5key
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

/**
 返回小写的HMAC二进制
 参数是MD5key
 */
- (NSData *)hmacMD5DataWithKey:(NSData *)key;

/**
 返回小写的HMAC字符串
 参数是SHA1key
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 返回小写的SHA1二进制
 参数是SHA1key
 */
- (NSData *)hmacSHA1DataWithKey:(NSData *)key;

/**
 返回小写的HMAC字符串
 参数是SHA224key
 */
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

/**
 返回SHA224二进制
 参数是SHA1key
 */
- (NSData *)hmacSHA224DataWithKey:(NSData *)key;

/**
 返回小写的HMAC字符串
 参数是SHA256key
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/**
 返回HMAC二进制
 参数是SHA256key
 */
- (NSData *)hmacSHA256DataWithKey:(NSData *)key;

/**
 返回小写的HMAC字符串
 参数是SHA384key
 */
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

/**
 返回HMAC二进制
 参数是SHA384key
 */
- (NSData *)hmacSHA384DataWithKey:(NSData *)key;

/**
 返回小写的HMAC字符串
 参数是SHA512key
 */
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

/**
 返回HMAC二进制
 参数是SHA512key
 */
- (NSData *)hmacSHA512DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 返回CRC32验证字符串
 */
- (NSString *)crc32String;

/**
 返回CRC验证码
 */
- (uint32_t)crc32;


#pragma mark - Encrypt and Decrypt
///=============================================================================
/// @name Encrypt and Decrypt
///=============================================================================

/**
 将二进制文件进行AES256加密
 参数1:key
 参数2:加密矢量
 */
- (nullable NSData *)aes256EncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

/**
 将二进制文件解密
 参数1:key
 参数2:加密矢量
 */
- (nullable NSData *)aes256DecryptWithkey:(NSData *)key iv:(nullable NSData *)iv;


#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 将二进制文件使用UTF8解码成字符串
 */
- (nullable NSString *)utf8String;

/**
 返回二进制大写的十六进制字符串
 
 */
- (nullable NSString *)hexString;

/**
 将一个二进制的字符串转为二进制
 当出现错误返回nil
 */
+ (nullable NSData *)dataWithHexString:(NSString *)hexString;

/**
 将二进制文件进行base64编码转为字符串
 */
- (nullable NSString *)base64EncodedString;

/**
 将base64编码转化的字符串转为二进制
 */
+ (nullable NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 将二进制进行json解码,返回NSDictionary 或是 NSArray
 */
- (nullable id)jsonValueDecoded;


#pragma mark - Inflate and deflate
///=============================================================================
/// @name Inflate and deflate
///=============================================================================

/**
 从gzip data解压缩
 */
- (nullable NSData *)gzipInflate;

/**
 将二进制文件进行gzip压缩
 */
- (nullable NSData *)gzipDeflate;

/**
 从zlib-compressed data解压缩
 */
- (nullable NSData *)zlibInflate;

/**
将二进制文件进行zlib压缩
 */
- (nullable NSData *)zlibDeflate;


#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/**
 将bundle中的一个文件生成二进制文件
 如果失败的话,返回为nil
 */
+ (nullable NSData *)dataNamed:(NSString *)name;

@end
NS_ASSUME_NONNULL_END
