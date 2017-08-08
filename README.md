# GCD-NSThreadDemo
## 多线程的初级使用，新手福利

多线程的使用可以明显的提高代码的运行效率，尤其在耗时操作时候，比如获取网络请求数据、视频解码，图片加载等等方面，下面我就把多线程的常用方法给简单介绍一下

多线程分类：

|      |  同步（sy）  | 异步（asy）  |
| :--: | :------: | :------: |
|  串行  | 同一线程挨个执行 | 其他线程挨个执行 |
|  并行  | 同一线程挨个执行 | 多个线程同时执行 |

**NSThread**的使用方法：

```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Nsthread 使用方法
    //使用方法一
    [NSThread detachNewThreadWithBlock:^{
        [self test_01];
    }];
    //使用方法二
    NSThread *thread =[[NSThread alloc]initWithTarget:self selector:@selector(test_02) object:nil];
    [thread start];
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
```

下面是控制台输出：

```
2017-08-08 09:33:21.239 Thread_GCDDeom[2467:102054] **********
2017-08-08 09:33:21.240 Thread_GCDDeom[2467:102055] ##########
2017-08-08 09:33:21.240 Thread_GCDDeom[2467:102054] **********
2017-08-08 09:33:21.240 Thread_GCDDeom[2467:102055] ##########
2017-08-08 09:33:21.240 Thread_GCDDeom[2467:102054] **********
2017-08-08 09:33:21.240 Thread_GCDDeom[2467:102055] ##########
2017-08-08 09:33:21.241 Thread_GCDDeom[2467:102054] **********
2017-08-08 09:33:21.241 Thread_GCDDeom[2467:102055] ##########
```

NSThread的其他用法还有：（这里不做解释）

```
+ (void)sleepUntilDate:(NSDate *)date;
+ (void)sleepForTimeInterval:(NSTimeInterval)ti;
+ (void)exit;
+ (double)threadPriority; 	//获取线程的优先级
+ (BOOL)setThreadPriority:(double)p; //这个是设置线程的优先级
```

*从上面的例子可以看得出，***NSThread***是苹果封装好的多线程，他是异步操作的*



**GCD**的使用方法：

```
//测试一：创建一个同步线程---串行队列(两种方法创建串行队列)
//    dispatch_queue_t queue_01 =dispatch_queue_create("queue01", NULL);
    dispatch_queue_t queue_01 =dispatch_queue_create("queue01", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue_01, ^{
        [self test_01];
    });
    dispatch_sync(queue_01, ^{
        [self test_02];
    });
```

运行结果：

```
2017-08-08 10:14:46.331 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.331 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.334 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.334 Thread_GCDDeom[2787:147269] ##########
```

------

```
//    //测试二：创建一个同步线程----并行队列
    dispatch_queue_t queue_02 =dispatch_queue_create("queue02", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue_02, ^{
        [self test_01];
    });
    dispatch_sync(queue_02, ^{
        [self test_02];
    });
```

运行结果：

```
2017-08-08 10:14:46.331 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.331 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.334 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.334 Thread_GCDDeom[2787:147269] ##########
```

------

```
    //测试三：创建一个异步线程---串行队列
    dispatch_queue_t queue_03 =dispatch_queue_create("queue03", NULL);
    dispatch_async(queue_03, ^{
        [self test_01];
    });
    dispatch_async(queue_03, ^{
        [self test_02];
    });
```

运行结果：

```
2017-08-08 10:14:46.331 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.331 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.332 Thread_GCDDeom[2787:147269] **********
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.333 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.334 Thread_GCDDeom[2787:147269] ##########
2017-08-08 10:14:46.334 Thread_GCDDeom[2787:147269] ##########
```

------

```
    dispatch_queue_t queue_04 =dispatch_queue_create("queue04", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue_04, ^{
        [self test_01];
    });
    dispatch_async(queue_04, ^{
        [self test_02];
    });
```

运行结果：

```
2017-08-08 10:23:18.687 Thread_GCDDeom[2911:154462] ##########
2017-08-08 10:23:18.687 Thread_GCDDeom[2911:154508] **********
2017-08-08 10:23:18.687 Thread_GCDDeom[2911:154462] ##########
2017-08-08 10:23:18.687 Thread_GCDDeom[2911:154508] **********
2017-08-08 10:23:18.688 Thread_GCDDeom[2911:154462] ##########
2017-08-08 10:23:18.688 Thread_GCDDeom[2911:154508] **********
2017-08-08 10:23:18.688 Thread_GCDDeom[2911:154462] ##########
2017-08-08 10:23:18.688 Thread_GCDDeom[2911:154508] **********
2017-08-08 10:23:18.688 Thread_GCDDeom[2911:154462] ##########
2017-08-08 10:23:18.688 Thread_GCDDeom[2911:154508] **********
```



> 教程到此结束，如果您需要[Demo请点击此处]()
>
> 如有疑问Email : grammermao@gmail.com
>
> 最后还是欢迎您的star(☆☆☆☆☆)，您的支持是我继续写demo的无线动力

