//
//  UICollectionView+EWExtension.h
//  
//
//  Created by Eric Wang on 2016/1/4.
//  Copyright © 2016年 Houtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (EWExtension)

/**
 *  设置某一indexPath，用于记录
 *
 *  @param indexPath 目标indexPath
 */
-(void)setCurrentIndexPath:(NSIndexPath*)indexPath;


/**
 *  获取上述方法某一indexPath，把记录起来的拿回来用
 *
 *  @return 返回记录的indexPath
 */
-(NSIndexPath *)currentIndexPath;
@end
