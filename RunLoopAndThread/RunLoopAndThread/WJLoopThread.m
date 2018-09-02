//
//  WJLoopThread.m
//  RunLoopAndThread
//
//  Created by vincent on 2018/9/2.
//  Copyright © 2018年 vincent. All rights reserved.
//

#import "WJLoopThread.h"

@interface WJThread : NSThread
@end
@implementation WJThread
- (void)dealloc
{
    NSLog(@"%s", __func__);
}
@end


@interface WJLoopThread()

@property (strong, nonatomic) WJThread *innerThread;

@end

@implementation WJLoopThread

- (instancetype)init
{
    if (self = [super init]) {
        self.innerThread = [[WJThread alloc] initWithBlock:^{
            NSLog(@"begin----");
            
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext context = {0};
            
            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            
            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            
            // 销毁source
            CFRelease(source);
            
            // 启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            
            
            NSLog(@"end----");
        }];
        
        [self.innerThread start];
    }
    return self;
}


- (void)executeTask:(WJLoopThreadTask)task
{
    if (!self.innerThread || !task) return;
    
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop
{
    if (!self.innerThread) return;
    
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    
    [self stop];
}

#pragma mark - private methods
- (void)__stop
{
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(WJLoopThreadTask)task
{
    task();
}

@end
