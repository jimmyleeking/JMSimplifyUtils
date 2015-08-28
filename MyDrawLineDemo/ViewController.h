//
//  ViewController.h
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/26/15.
//  Copyright © 2015 handos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMGestureDrawView.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet JMGestureDrawView *bgView;

@property (weak, nonatomic) IBOutlet UITextField *textMaxCount;


@end

