# 剑指offer 30 包含min函数的栈

```
@author: sdubrz
@date:  8/1/2020 10:48:07 PM 
难度： 简单
考察内容： 栈
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的 min 函数在该栈中，调用 min、push 及 pop 的时间复杂度都是 O(1)。

**示例:**
```
MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.min();   --> 返回 -3.
minStack.pop();
minStack.top();      --> 返回 0.
minStack.min();   --> 返回 -2.
```

**提示：**

+ 各函数的调用总次数不超过 20000 次

## 解法

可以用两个栈实现，第一个栈用于正常存储数据，第二个栈依次存储当前遇到的最小值。下面是具体的Java程序实现：

```
import java.util.*;

class MinStack {
    Stack<Integer> stack1;
    Stack<Integer> stack2;
    
    /** initialize your data structure here. */
    public MinStack() {
        stack1 = new Stack<>();
        stack2 = new Stack<>();
    }
    
    public void push(int x) {
        stack1.push(x);
        if(stack2.isEmpty() || stack2.peek()>=x){
            stack2.push(x);
        }
    }
    
    public void pop() {
        int temp = stack1.pop();
        if(temp==stack2.peek()){
            stack2.pop();
        }
    }
    
    public int top() {
        return stack1.peek();
    }
    
    public int min() {
        return stack2.peek();
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * MinStack obj = new MinStack();
 * obj.push(x);
 * obj.pop();
 * int param_3 = obj.top();
 * int param_4 = obj.min();
 */
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过显示详情
执行用时：19 ms, 在所有 Java 提交中击败了85.82%的用户
内存消耗：41.5 MB, 在所有 Java 提交中击败了85.80%的用户
```