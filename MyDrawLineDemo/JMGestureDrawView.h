//
//  JMGestureDrawView.h
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/26/15.
//  Copyright © 2015 handos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMGestureDrawView : UIView

@property (assign) NSInteger pointRadius;


-(void)drawKeyPoint:(NSInteger)maxCount;
@end
