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
#import "SimplifyUtils.h"
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



-(NSArray *)sortUnit:(JMPoint *)pointA b:(JMPoint *)pointB c:(JMPoint *)pointC d:(JMPoint *)pointD{
    JMPoint *midPoint=nil;
    CGFloat angleFirst=angleBetweenThreePoints(pointA.point, pointB.point, pointC.point);
    CGFloat angleSecond=angleBetweenThreePoints(pointB.point, pointC.point, pointD.point);
    if(angleFirst>angleSecond)
    {
        midPoint=pointB;
    }else{
        midPoint=pointC;
        
    }
    if(isnan(angleFirst))
    {
        midPoint=pointC;
    }
    if(isnan(angleSecond))
    {
        midPoint=pointB;
    }
    NSArray *result=[NSArray arrayWithObjects:pointA,midPoint,pointD, nil];
    return result;
}


-(NSArray *)sort:(NSArray *)array startIndex:(NSInteger)start endIndex:(NSInteger)end{
    
    NSInteger length=end-start;
    if(length<3)
    {
        if(length==0)
        {
            return [NSArray arrayWithObject:array[start]];
        }else{
            
            NSMutableArray *result=[[NSMutableArray alloc]init];
            for(NSInteger i=start;i<=end;i++)
            {
                [result addObject:array[i]];
            }
            return result;
        }
        
    }
    if(length==3)
    {
        NSArray *tempResult=[self sortUnit:array[start] b:array[start+1] c:array[start+2] d:array[start+3]];
        return tempResult;
    }else{
        
        NSInteger rightStart=(length-1)/2+start;
        if(length<7)
        {
            
            rightStart=start+3;
        }
        if(start<rightStart&&rightStart<end)
        {
            NSArray *leftTemp=[self sort:array startIndex:start endIndex:rightStart];
            NSArray *rightTemp=[self sort:array startIndex:rightStart+1 endIndex:end];
            NSMutableArray *tempAll=[[NSMutableArray alloc]init];
            [tempAll addObjectsFromArray:leftTemp];
            [tempAll addObjectsFromArray:rightTemp];
            return tempAll;
        }else{
            return nil;
        }
        
    }
    
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
    NSArray *result=nil;
    if(maxCount<=2)
    {
        if(maxCount<=0)
        {
            return;
        }
        if(maxCount==1)
        {
            result=[NSArray arrayWithObject:pointArray[0]];
        }
        if(maxCount==2)
        {
            result=[NSArray arrayWithObjects:pointArray[0],[pointArray objectAtIndex:[pointArray count]-1], nil];
        }
    }else{
        result=pointArray;
        NSInteger length=0;
        do{
            
            result=[self sort:result startIndex:0 endIndex:([result count]-1)];
            length=[result count];
        }while(length>maxCount);
        
    }
    keyPointArray=[NSMutableArray arrayWithArray:result];
    [self setNeedsDisplay];
    
}






@end
