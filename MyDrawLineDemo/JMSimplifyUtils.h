//
//  SimplifyUtils.h
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/27/15.
//  Copyright (c) 2015 handos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMPoint.h"
@interface JMSimplifyUtils : NSObject



+(NSMutableArray *)simplifyByRDP:(NSArray *)pointArray tolerance:(double)tolerance;

+(NSMutableArray *)simplifyByAngle:(NSArray *)pointArray maxCount:(NSInteger)maxCount;
//计算点到之间的距离

+(double)pointToLineDistance:(JMPoint *)point lineFrom:(JMPoint *)from lineTo:(JMPoint *)to;

//计算两点之间的距离
+(double)getDistance:(JMPoint *)from to:(JMPoint *)to;
@end
