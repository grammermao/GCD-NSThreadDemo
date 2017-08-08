//
//  ViewController.m
//  Thread_GCDDeom
//
//  Created by yuchen_Mac on 2017/8/8.
//  Copyright © 2017年 yc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    
}


-(void)test_01{
    for (int i = 0; i<1000; i++) {
        NSLog(@"**********");
    }
}
-(void)test_02{
    for (int i = 0; i<1000; i++) {
        NSLog(@"##########");
    }
}
-(void)test_03{
    for (int i = 0; i<1000; i++) {
        NSLog(@"&&&&&&&&&&");
    }
}
-(void)test_04{
    for (int i = 0; i<1000; i++) {
        NSLog(@"$$$$$$$$$$");
    }
}


//GCD使用方法
- (IBAction)gcd_action:(id)sender {
    //测试一：创建一个同步线程---串行队列(两种方法创建串行队列)
//    dispatch_queue_t queue_01 =dispatch_queue_create("queue01", NULL);
//    dispatch_queue_t queue_01 =dispatch_queue_create("queue01", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(queue_01, ^{
//        [self test_01];
//    });
//    dispatch_sync(queue_01, ^{
//        [self test_02];
//    });
    
    //测试二：创建一个同步线程----并行队列
//    dispatch_queue_t queue_02 =dispatch_queue_create("queue02", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_sync(queue_02, ^{
//        [self test_01];
//    });
//    dispatch_sync(queue_02, ^{
//        [self test_02];
//    });

    //测试三：创建一个异步线程---串行队列
//    dispatch_queue_t queue_03 =dispatch_queue_create("queue03", NULL);
//    dispatch_async(queue_03, ^{
//        [self test_01];
//    });
//    dispatch_async(queue_03, ^{
//        [self test_02];
//    });
    

//    //测试四：创建一个异步线程----并行队列
    dispatch_queue_t queue_04 =dispatch_queue_create("queue04", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue_04, ^{
        [self test_01];
    });
    dispatch_async(queue_04, ^{
        [self test_02];
    });
    
}


//Nsthread 使用方法
- (IBAction)nsthread_action:(id)sender {

    //使用方法一
    [NSThread detachNewThreadWithBlock:^{
        [self test_01];
    }];
    //使用方法二
    NSThread *thread =[[NSThread alloc]initWithTarget:self selector:@selector(test_02) object:nil];
    [thread start];
}





@end
