//
//  JMMathUtil.h
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/26/15.
//  Copyright (c) 2015 handos. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface JMMathUtil : NSObject

//两点之间的距离
CGFloat distanceBetweenPoints (CGPoint first, CGPoint second);
//两点之间的角度
CGFloat angleBetweenPoints(CGPoint first, CGPoint second);
//两条线之间的角度
CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End);

CGFloat angleBetweenThreePoints(CGPoint pointA, CGPoint pointB, CGPoint pointC);
@end
