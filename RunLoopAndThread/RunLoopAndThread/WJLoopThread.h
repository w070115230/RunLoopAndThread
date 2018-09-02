//
//  WJLoopThread.h
//  RunLoopAndThread
//
//  Created by vincent on 2018/9/2.
//  Copyright © 2018年 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^WJLoopThreadTask)(void);

@interface WJLoopThread : NSObject



/**
 在当前子线程执行一个任务
 */
- (void)executeTask:(WJLoopThreadTask)task;

/**
 结束线程
 */
- (void)stop;

@end
