//
//  NSURL+EWSugar.m
//  
//
//  Created by Eric on 2018/5/15.
//  Copyright © 2018年 Houtech. All rights reserved.
//

#import "NSURL+EWSugar.h"
#import "UtilsMacros.h"

@implementation NSURL (EWSugar)
- (NSDictionary *)generateParameterDictionary {
  NSString *urlStr = self.absoluteString;
  if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
    NSArray *array = [urlStr componentsSeparatedByString:@"?"];
    if (array && array.count == 2) {
      NSString *paramsStr = array[1];
      if (paramsStr.length) {
        NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
        NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
        for (NSString *param in paramArray) {
          if (param && param.length) {
            NSArray *parArr = [param componentsSeparatedByString:@"="];
            if (parArr.count == 2) {
              [paramsDict setObject:parArr[1] forKey:parArr[0]];
            }
          }
        }
        return paramsDict;
      }else{
        return nil;
      }
    }else{
      return nil;
    }
  }else{
    return nil;
  }
}

/**
 获取url中的参数并返回

 @return NSDictionary:参数字典
 */
- (NSDictionary *)getParameterDictionary {
  NSString *urlString = self.absoluteString;
  if(urlString.length==0) {
    EWLog(@"链接为空！");
    return @{};
  }

  //先截取问号
  NSArray *allElements = [urlString componentsSeparatedByString:@"?"];
  NSMutableDictionary *params = [NSMutableDictionary dictionary];//待set的参数字典

  if(allElements.count==2) {
    
    //有参数或者?后面为空
    NSString *myUrlString = allElements[0];
    NSString *paramsString = allElements[1];
    
    //获取参数对
    NSArray *paramsArray = [paramsString componentsSeparatedByString:@"&"];

    if(paramsArray.count>=2) {
      for(NSInteger i=0; i < paramsArray.count; i++) {
        NSString *singleParamString = paramsArray[i];
        NSArray *singleParamSet = [singleParamString componentsSeparatedByString:@"="];
        if(singleParamSet.count==2) {
          NSString *key = singleParamSet[0];
          NSString *value = singleParamSet[1];
          if(key.length>0|| value.length>0) {
            [params setObject:value.length>0?value:@"" forKey:key.length>0?key:@""];
          }
          
        }
        
      }
      
    }else if(paramsArray.count==1) {
      
      //无 &。url只有?后一个参数
      NSString *singleParamString = paramsArray[0];
      NSArray *singleParamSet = [singleParamString componentsSeparatedByString:@"="];
      
      
      
      if(singleParamSet.count==2) {
        NSString*key = singleParamSet[0];
        NSString*value = singleParamSet[1];
        if(key.length>0|| value.length>0) {
          [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
        }
      }else{
        //问号后面啥也没有 xxxx?  无需处理
      }
    }
    //整合url及参数
    return params;
  }else if(allElements.count>2) {
    
    EWLog(@"链接不合法！链接包含多个\"?\"");
    
    return @{};
    
  }else{
    EWLog(@"链接不包含参数！");
    return @{};
    
  }
}
@end
