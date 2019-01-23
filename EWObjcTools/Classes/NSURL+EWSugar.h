//
//  NSURL+EWSugar.h
//  
//
//  Created by Eric on 2018/5/15.
//  Copyright © 2018年 Houtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (EWSugar)

/**
 获取url中的参数并返回  --1
 
 @return NSDictionary:参数字典
 */
- (NSDictionary *)generateParameterDictionary;

/**
 获取url中的参数并返回  --2
 
 @return NSDictionary:参数字典
 */
- (NSDictionary *)getParameterDictionary;
@end
