//
//  ViewController.m
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/26/15.
//  Copyright © 2015 handos. All rights reserved.
//

#import "ViewController.h"
#import "JMPoint.h"
#import "JMMathUtil.h"
#import "JMSimplifyUtils.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (IBAction)getKeyPoints:(id)sender {
    
    
    [self.bgView drawKeyPoint:[self.textMaxCount.text intValue]];
}




@end
