//
//  JMPoint.m
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/26/15.
//  Copyright (c) 2015 handos. All rights reserved.
//

#import "JMPoint.h"

@implementation JMPoint


+(instancetype)pointWithXY:(float)x y:(float)y{
    JMPoint *point=[[JMPoint alloc]init];
    point.x=x;
    point.y=y;
    point.point=CGPointMake(x, y);
    return point;
}

+(instancetype)pointWithCGPoint:(CGPoint)point{
    JMPoint *myPoint=[[JMPoint alloc]init];
    myPoint.x=point.x;
    myPoint.y=point.y;
    myPoint.point=point;
    return myPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
