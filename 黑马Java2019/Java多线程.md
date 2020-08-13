# 线程实现方式

```
传智播客 黑马Java的学习笔记
@date: 2020-08-11
```



## 多线程原理 随机打印结果

下面这个例子相当于在``main``线程之外，又新建了一个线程，所以输出结果中可以看到两个线程的输出交叉存在

```java
public class MyThread extends Thread{
    public void run(){
        for(int i=0; i<20; i++){
            System.out.println("run: "+i);
        }
    }
}
```

```java
public class Demo01Thread {
    public static void main(String[] args) {
        MyThread mt = new MyThread();
        mt.start();

        for(int i=0; i<20; i++){
            System.out.println("main: "+i);
        }
    }
}
```

输出结果为

```
run: 0
run: 1
run: 2
main: 0
run: 3
main: 1
run: 4
main: 2
run: 5
main: 3
run: 6
main: 4
run: 7
main: 5
run: 8
main: 6
run: 9
main: 7
run: 10
main: 8
run: 11
main: 9
run: 12
main: 10
run: 13
main: 11
run: 14
main: 12
run: 15
main: 13
run: 16
main: 14
run: 17
main: 15
run: 18
main: 16
main: 17
main: 18
main: 19
run: 19
```

而如果将``main``方法中的``mt.start()``改为``mt.run()``则并不会新建线程，程序会顺序执行，其输出结果为

```
run: 0
run: 1
run: 2
run: 3
run: 4
run: 5
run: 6
run: 7
run: 8
run: 9
run: 10
run: 11
run: 12
run: 13
run: 14
run: 15
run: 16
run: 17
run: 18
run: 19
main: 0
main: 1
main: 2
main: 3
main: 4
main: 5
main: 6
main: 7
main: 8
main: 9
main: 10
main: 11
main: 12
main: 13
main: 14
main: 15
main: 16
main: 17
main: 18
main: 19
```

## 创建多线程的第二种方式 实现Runnable接口

除了继承Thread类之外，也可以通过实现Runable接口来实现多线程。如

```java
public class RunableImp implements Runnable{
    @Override
    public void run() {
        for(int i=0; i<20; i++){
            System.out.println(Thread.currentThread().getName()+"-->"+i);
        }
    }
}
```

```java
public class Demo01Thread {
    public static void main(String[] args) {
        RunableImp obj = new RunableImp();
        Thread t = new Thread(obj);
        t.start();

        for (int i = 0; i < 20; i++) {
            System.out.println(Thread.currentThread().getName()+"-->"+i);
        }
    }
}
```

该程序的输出结果为

```
main-->0
Thread-0-->0
main-->1
Thread-0-->1
main-->2
Thread-0-->2
main-->3
Thread-0-->3
main-->4
Thread-0-->4
main-->5
Thread-0-->5
main-->6
Thread-0-->6
main-->7
Thread-0-->7
main-->8
Thread-0-->8
main-->9
Thread-0-->9
main-->10
Thread-0-->10
main-->11
Thread-0-->11
main-->12
Thread-0-->12
main-->13
Thread-0-->13
main-->14
Thread-0-->14
main-->15
Thread-0-->15
main-->16
Thread-0-->16
main-->17
Thread-0-->17
main-->18
Thread-0-->18
main-->19
Thread-0-->19
```

## Thread 与 Runable 的区别

使用``Runable``接口创建多线程程序的好处：

+ 避免了单继承的局限性
  + 一个类智能继承一个类，类继承了``Thread``类就不能继承其他类
  + 实现了``Runable``接口，还可以继承其他的类，实现其他的接口

+ 增强了程序的扩展性，降低了程序的耦合性
  + 实现``Runable``接口的方式，把设置线程任务和开启新线程进行了分离
  + 实现类中，重写了``run ``方法：用来设置线程任务
  + 创建``Thread``类对象，调用``strat``方法：用来开启新线程

## 并发与并行

**并发**：指两个或多个事件在同一个时间段内发生。

**并行**：指两个或多个事件在同一时刻发生（同时发生）。

# 线程同步机制

