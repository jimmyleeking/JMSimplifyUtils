//
//  JMPoint.h
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/26/15.
//  Copyright (c) 2015 handos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMPoint : NSObject

@property (assign) float x;
@property (assign) float y;
@property (assign) CGPoint point;
+(instancetype)pointWithXY:(float)x y:(float)y;
+(instancetype)pointWithCGPoint:(CGPoint)point;
@end
