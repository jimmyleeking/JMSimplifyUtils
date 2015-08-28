//
//  JMGestureDrawView.m
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/26/15.
//  Copyright © 2015 handos. All rights reserved.
//

#import "JMGestureDrawView.h"
#import "JMPoint.h"
#import "JMMathUtil.h"
#import "JMSimplifyUtils.h"
#define DEFAULT_CIRCLE_RADIUS 10

@interface JMGestureDrawView()
@end
@implementation JMGestureDrawView
{
    UIBezierPath *bezier;
    CGPoint currentPoint;
    CGPoint prePoint;
    NSMutableArray *keyPointArray;
    NSMutableArray *pointArray;
    BOOL isDrawKeyPoint;
}
-(NSInteger)getPointRadius{
    if(_pointRadius<=0)
    {
        return DEFAULT_CIRCLE_RADIUS;
    }
    return _pointRadius;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.pointRadius=DEFAULT_CIRCLE_RADIUS;
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    isDrawKeyPoint=NO;
    pointArray=[[NSMutableArray alloc]init];
    bezier=[UIBezierPath bezierPath];
    //获取点击的点
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    prePoint=currentPoint;
    currentPoint=point;
    [pointArray addObject:[JMPoint pointWithCGPoint:point]];
    [bezier moveToPoint:point];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    prePoint=currentPoint;
    currentPoint=point;
    [pointArray addObject:[JMPoint pointWithCGPoint:point]];
    [bezier addLineToPoint:point];
    [self setNeedsDisplay];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    NSLog(@"%f %f",point.x,point.y);
    [pointArray addObject:[JMPoint pointWithCGPoint:point]];
}


-(void)drawRect:(CGRect)rect{
    UIColor *color=[UIColor blueColor];
    [color setStroke];
    [bezier setLineWidth:2];
    [bezier stroke];
    if(isDrawKeyPoint&&keyPointArray)
    {
        
        [self drawCirclePoint:rect color:[UIColor orangeColor] centerPoint:keyPointArray];
        
    }
}

-(void)drawCirclePoint:(CGRect)rect color:(UIColor *)color centerPoint:(NSMutableArray *)curPoints{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for(JMPoint *point in curPoints)
    {
        
        CGFloat startX=point.x-[self getPointRadius];
        CGFloat startY=point.y-[self getPointRadius];
        CGRect frame = CGRectMake(startX, startY, [self getPointRadius], [self getPointRadius]);
        CGContextAddEllipseInRect(context,frame);
        
    }
    [color set];
    CGContextFillPath(context);
}




-(void)printArray:(NSString *)msg array:(NSArray *)array start:(NSInteger)start end:(NSInteger)end{
    
    NSLog(@"msg:%@",msg);
    for(NSInteger i=start;i<=end;i++)
    {
        JMPoint *item=array[i];
        NSLog(@"point:%f,%f",item.x,item.y);
        
    }
    
}

-(void)drawKeyPoint:(NSInteger)maxCount{
    isDrawKeyPoint=YES;
    NSMutableArray *result=[NSMutableArray arrayWithArray:[JMSimplifyUtils simplifyByAngle:[pointArray copy] maxCount:maxCount]];
    keyPointArray=[NSMutableArray arrayWithArray:result];
    [self setNeedsDisplay];
    
}






@end
