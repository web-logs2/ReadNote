# 程序员代码面试指南

## 设计 getMin 功能的栈

```
@author: sdubrz
@date: 2020.06.11
@difficulty: *
```

**题目描述**

实现一个特殊功能的栈，在实现栈的基本功能的基础上，再实现返回栈中最小元素的操作。

**输入描述:**
```
第一行输入一个整数N，表示对栈进行的操作总数。

下面N行每行输入一个字符串S，表示操作的种类。

如果S为"push"，则后面还有一个整数X表示向栈里压入整数X。

如果S为"pop"，则表示弹出栈顶操作。

如果S为"getMin"，则表示询问当前栈中的最小元素是多少。
```

**输出描述:**
```
对于每个getMin操作，输出一行表示当前栈中的最小元素是多少。
```

**示例1**

输入
```
6
push 3
push 2
push 1
getMin
pop
getMin
```

输出
```
1
2
```

**备注:**
```
1<=N<=1000000

-1000000<=X<=1000000

数据保证没有不合法的操作
```

### 我的解法

```
import java.util.*;

public class Main{
    
    public static void main(String[] args){
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        String nouse = in.nextLine();
        Stack<Integer> stack = new Stack<>();
        for(int i=0; i<n; i++){
            String str = in.nextLine();
            if(str.length()>4 && str.substring(0, 4).equals("push")){
                int a = Integer.parseInt(str.substring(5, str.length()));
                stack.push(a);
            }else if(str.equals("pop")){
                stack.pop();
            }else if(str.equals("getMin")){
                System.out.println(getMin(stack));
            }
        }
    }
    
    public static int getMin(Stack<Integer> stack){
        if(stack.isEmpty()){
            return -1;  // 这里这么写应该是不太合适的
        }
        Stack<Integer> stack2 = new Stack<>();
        int minValue = stack.pop();
        stack2.push(minValue);
        while(!stack.isEmpty()){
            int current = stack.pop();
            if(current<minValue){
                minValue = current;
            }
            stack2.push(current);
        }
        while(!stack2.isEmpty()){
            stack.push(stack2.pop());
        }
        return minValue;
    }
}
```

在牛客网的提交结果如下

解决问题 | 提交时间 | 状态 | 运行时间 | 占用内存 | 使用语言
-|-|-|-|-|-
设计getMin功能的栈 | 2020-06-11 | 答案正确 | 2592ms | 203792K | Java

