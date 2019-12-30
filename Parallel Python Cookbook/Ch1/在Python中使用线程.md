## 在Python中使用线程

下面是一个在Python中使用线程的例子：

```
from threading import Thread
from time import sleep

class CookBook(Thread):
    def __init__(self):
        Thread.__init__(self)
        self.message = "Parallel Python Cookbook"

    def print_message(self):
        print(self.message)

    def run(self):
        print("Thread starting")
        x = 0
        while x < 10:
            self.print_message()
            sleep(2)
            x += 1

if __name__ == '__main__':
    print("Process started")
    hello_python = CookBook()
    hello_python.start()
    print("Process Ended")
```

程序的运行结果如下所示

```
D:\Anaconda\python.exe E:/Code/Python/ParallelPythonCookBook/Ch1/HelloPythonWithThreads.py
Process started
Thread startingProcess Ended

Parallel Python Cookbook
Parallel Python Cookbook
Parallel Python Cookbook
Parallel Python Cookbook
Parallel Python Cookbook
Parallel Python Cookbook
Parallel Python Cookbook
Parallel Python Cookbook
Parallel Python Cookbook
Parallel Python Cookbook

Process finished with exit code 0
```

可见当主线程终止之后，开启的子线程仍然在运行，直到完成全部的10次打印。所以需要注意，不要留下意外的线程在后台默默运行。

