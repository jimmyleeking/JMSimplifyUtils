//
//  SimplifyUtils.m
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/27/15.
//  Copyright (c) 2015 handos. All rights reserved.
//

#import "JMSimplifyUtils.h"
#import "JMMathUtil.h"
#import "Math.h"
@implementation JMSimplifyUtils


+(NSArray *)sortUnit:(JMPoint *)pointA b:(JMPoint *)pointB c:(JMPoint *)pointC d:(JMPoint *)pointD{
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


+(NSArray *)sort:(NSArray *)array startIndex:(NSInteger)start endIndex:(NSInteger)end{
    
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
        NSArray *tempResult=[JMSimplifyUtils sortUnit:array[start] b:array[start+1] c:array[start+2] d:array[start+3]];
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



+(NSArray *)simplifyByAngle:(NSArray *)pointArray maxCount:(NSInteger)maxCount{
 
    NSArray *result=nil;
    if(maxCount<=2)
    {
        if(maxCount<=0)
        {
            return nil;
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
            
            result=[JMSimplifyUtils sort:result startIndex:0 endIndex:([result count]-1)];
            length=[result count];
        }while(length>maxCount);
    }
    return result;
}



+(NSMutableArray *)simplifyByRDP:(NSArray *)pointArray tolerance:(double)tolerance{
    int index = 0;
    double dmax = 0;
    double squareTolerance = tolerance * tolerance;
    NSInteger lastIndex = [pointArray count] - 1;
    
    // Find the point with the maximum distance
    for (int i = 1; i < [pointArray count] - 1; i++) {
        
        double d =[JMSimplifyUtils pointToLineDistance:pointArray[0] lineFrom:pointArray[lastIndex] lineTo:pointArray[i]];
        if (d > dmax) {
            index = i;
            dmax = d;
        }
    }
    
    // If max distance is greater than epsilon, recursively simplify
    
    NSMutableArray *ResultList=[[NSMutableArray alloc]init];
    if (dmax > squareTolerance) {
        
    
        
            // Recursive ca5
        
        NSMutableArray *recResults1=[JMSimplifyUtils simplifyByRDP:[pointArray subarrayWithRange:NSMakeRange(0, index+1)] tolerance:tolerance];
        NSInteger rightLength=(lastIndex+1-index);
        NSMutableArray *recResults2=[JMSimplifyUtils simplifyByRDP:[pointArray subarrayWithRange:NSMakeRange(index, rightLength)] tolerance:tolerance];
    
        // Build the result list
        
        [recResults1 removeObjectAtIndex:([recResults1 count]- 1)];
        
        //recResults1.remove();
        [ResultList addObjectsFromArray:recResults1];
        [ResultList addObjectsFromArray:recResults2];
      
    } else {
        [ResultList addObject:pointArray[0]];
        [ResultList addObject:pointArray[lastIndex]];
    }
    
    // Return the result
    return ResultList;
}


+(double)pointToLineDistance:(JMPoint *)point lineFrom:(JMPoint *)from lineTo:(JMPoint *)to{
    
    double x0, y0, x1, y1, x2, y2, dx, dy, t;
    
    x1 = from.x;
    y1 = from.y;
    x2 = to.x;
    y2 = to.y;
    x0 = point.x;
    y0 = point.y;
    
    dx = x2 - x1;
    dy = y2 - y1;
    
    if (dx != 0.0 || dy != 0.0) {
        t = ((x0 - x1) * dx + (y0 - y1) * dy) / (dx * dx + dy * dy);
        
        if (t > 1.0) {
            x1 = x2;
            y1 = y2;
        } else if (t > 0.0) {
            x1 += dx * t;
            y1 += dy * t;
        }
    }
    
    dx = x0 - x1;
    dy = y0 - y1;
    
    return dx * dx + dy * dy;
    
    return 0.0;
}

+(double)getDistance:(JMPoint *)from to:(JMPoint *)to{
    double distance=sqrt((from.y-to.y)*(from.y-to.y)+(from.x-to.x)*(from.x-to.x));
    return distance;
}

@end
