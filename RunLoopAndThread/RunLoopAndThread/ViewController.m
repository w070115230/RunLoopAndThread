//
//  ViewController.m
//  RunLoopAndThread
//
//  Created by vincent on 2018/9/2.
//  Copyright © 2018年 vincent. All rights reserved.
//

#import "ViewController.h"
#import "WJLoopThread.h"

@interface ViewController ()
@property (strong, nonatomic) WJLoopThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.thread = [[WJLoopThread alloc] init];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.thread executeTask:^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
    }];
}

- (IBAction)cancel {
    [self.thread stop];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
