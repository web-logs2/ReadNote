@[toc](Contens)

# 04 二维数组中的查找

```
@author: sdubrz
@date: 2020.05.02
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

在一个 n * m 的二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。

**示例:**

现有矩阵 matrix 如下：

```
[
  [1,   4,  7, 11, 15],
  [2,   5,  8, 12, 19],
  [3,   6,  9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]
```

给定 target = 5，返回 true。

给定 target = 20，返回 false。

**限制：**

+ 0 <= n <= 1000

+ 0 <= m <= 1000

## 我的解法

对于给定的一个二维数组，根据题意，其最小值和最大值肯定分别在数组的开头和末尾，我们可以根据这个来初步判断目标数值是否有可能在这个数组中出现。如果有可能，则可以使用二分法进行查找。

比较数组中间位置元素与目标数值的大小，图1表示了比目标数值小的情况，图2表示了比目标数值大的情况。根据不同的情况，分别去继续探索红色、蓝色和绿色的区域。如此递归的实现。

![](E:/会读书/放在GitHub的读书笔记/ReadNote/LeetCode/剑指offer/images/4.png)

下面是具体给出的Java程序实现。

```java
class Solution {
    	public boolean findNumberIn2DArray(int[][] matrix, int target) {
		if(matrix.length==0) {
			return false;
		}
		int m = matrix[0].length;
		if(m==0) {
			return false;
		}
		
		return this.find2d(matrix, target, 0, matrix.length-1, 0, m-1);
	}
	
	/**
	 * 在矩阵中的一个矩形区域内查找是否含有目标数值
	 * @param matrix 矩阵
	 * @param target 要查找的数值
	 * @param left 矩形区域的最左边
	 * @param right 矩形区域的最右边
	 * @param up 矩形区域的最上方
	 * @param bottom 矩形区域的最下方
	 * @return
	 */
	private boolean find2d(int[][] matrix, int target, int up, int bottom, int left, int right) {
		if(left==right && up==bottom) {
			return matrix[up][left]==target;
		}
		
		if(matrix[up][left]>target) {
			return false;
		}
		
		if(matrix[bottom][right]<target) {
			return false;
		}
		
		// 如果范围比较小，直接查找
		if(bottom-up<4 && right-left<4) {
			for(int i=up; i<=bottom; i++) {
				for(int j=left; j<=right; j++) {
					if(matrix[i][j]==target) {
						return true;
					}
				}
			}
			return false;
		}
		
		// 用二分法
		int col_m = (left+right)/2;
		int row_m = (up+bottom)/2;
		
		if(matrix[row_m][col_m]==target) {
			return true;
		}
		
		if(matrix[row_m][col_m]<target) {
			boolean temp = this.find2d(matrix, target, row_m, bottom, col_m, right);
			if(temp) {
				return true;
			}
			
//			if(row_m<bottom) {
//				temp = this.find2d(matrix, target, row_m+1, bottom, col_m, col_m);
//				if(temp) {
//					return true;
//				}
//			}
			
			if(row_m<bottom && col_m>left) {
				temp = this.find2d(matrix, target, row_m+1, bottom, left, col_m-1);
				if(temp) {
					return true;
				}
			}
			if(row_m>up && col_m<right) {
				temp = this.find2d(matrix, target, up, row_m-1, col_m+1, right);
				if(temp) {
					return true;
				}
			}
		}
		
		if(matrix[row_m][col_m]>target) {
			boolean temp = this.find2d(matrix, target, up, row_m, left, col_m);
			if(temp) {
				return temp;
			}
			if(row_m<bottom && col_m>left) {
				temp = this.find2d(matrix, target, row_m+1, bottom, left, col_m-1);
				if(temp) {
					return true;
				}
			}
			if(row_m>up && col_m<right) {
				temp = this.find2d(matrix, target, up, row_m-1, col_m+1, right);
				if(temp) {
					return temp;
				}
			}
		}
		
		
		return false;
	}
}
```

在 LeetCode 系统中提交的结果如下

```
执行结果： 通过 显示详情
执行用时 : 0 ms, 在所有 Java 提交中击败了 100.00% 的用户
内存消耗 : 45.7 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

## 官方给出的线性解法

下面是官方给出的一种线性时间复杂度的方法。

![line](/images/4_1.png)

```
class Solution {
    public boolean findNumberIn2DArray(int[][] matrix, int target) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return false;
        }
        int rows = matrix.length, columns = matrix[0].length;
        int row = 0, column = columns - 1;
        while (row < rows && column >= 0) {
            int num = matrix[row][column];
            if (num == target) {
                return true;
            } else if (num > target) {
                column--;
            } else {
                row++;
            }
        }
        return false;
    }
}
```

相比较而言，官方的算法代码实现上要稍微更加优美一点。

# 05 替换空格

```
@author: sdubrz
@date: 2020.05.03
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

请实现一个函数，把字符串 s 中的每个空格替换成"%20"。

**示例 1：**

```
输入：s = "We are happy."
输出："We%20are%20happy."
```

**限制：**

```
0 <= s 的长度 <= 10000
```

## 我的解法

很明显的一种做法是遍历字符串的每个位置，判断是否是空格，然后进行替换。下面是Java程序实现。

```java
class Solution {
    public String replaceSpace(String s) {
        if(s.length()==0){
            return s;
        }

        char[] array = s.toCharArray();
        String str = "";
        for(int i=0; i<s.length(); i++){
            if(array[i]==' '){
                str = str + "%20";
            }else{
                str = str + array[i];
            }
        }

        return str;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果： 通过 显示详情
执行用时 : 8 ms, 在所有 Java 提交中击败了 5.15% 的用户
内存消耗 : 40.1 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

## 官方解法

官方解法与我的解法思路是一致的，凡是具体的实现代码有所不同。结果是官方代码运行的速度要更快。下面是官方给出的Java程序实现

```java
class Solution {
    public String replaceSpace(String s) {
        int length = s.length();
        char[] array = new char[length * 3];
        int size = 0;
        for (int i = 0; i < length; i++) {
            char c = s.charAt(i);
            if (c == ' ') {
                array[size++] = '%';
                array[size++] = '2';
                array[size++] = '0';
            } else {
                array[size++] = c;
            }
        }
        String newStr = new String(array, 0, size);
        return newStr;
    }
}
```

下面是官方程序的提交结果，明显要比我的速度快了很多。应该是Java内部字符串相加的机制的原因吧。**因为我的代码中``str=str+array[i]``这种操作非常耗时，具体可参见《Java编程思想》中字符串的相关章节。**

```
执行结果： 通过 显示详情
执行用时 : 0 ms, 在所有 Java 提交中击败了 100.00% 的用户
内存消耗 : 37.8 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

# 06 从尾到头打印链表

```
@author: sdubrz
@date: 2020.05.03
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入一个链表的头节点，从尾到头反过来返回每个节点的值（用数组返回）。

**示例 1：**

```
输入：head = [1,3,2]
输出：[2,3,1]
```

**限制：**

0 <= 链表长度 <= 10000

## 我的解法

一种比较容易想到的方法就是用栈来把顺序颠倒：

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
import java.util.*;
class Solution {
    public int[] reversePrint(ListNode head) {
        Stack<Integer> stack = new Stack<>();
        while(head!=null){
            stack.push(head.val);
            head = head.next;
        }

        int n = stack.size();
        int[] nums = new int[n];
        for(int i=0; i<n; i++){
            nums[i] = stack.pop();
        }

        return nums;
    }
}
```

在 LeetCode 系统中提交的结果如下所示

```
执行结果： 通过 显示详情
执行用时 : 2 ms, 在所有 Java 提交中击败了 57.13% 的用户
内存消耗 : 40.9 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

## 官方解法

官方给出的解法也是使用的栈。不过他的栈中存储的是链表节点，而不是链表节点的数值。但是其实际运行速度要比我的稍快一些，这或许可以作为以后解题的技巧。下面是其具体的代码实现

```java
class Solution {
    public int[] reversePrint(ListNode head) {
        Stack<ListNode> stack = new Stack<ListNode>();
        ListNode temp = head;
        while (temp != null) {
            stack.push(temp);
            temp = temp.next;
        }
        int size = stack.size();
        int[] print = new int[size];
        for (int i = 0; i < size; i++) {
            print[i] = stack.pop().val;
        }
        return print;
    }
}

```

在 LeetCode 系统中提交的结果如下，实际运行速度要比我的代码稍快。

```
执行结果： 通过 显示详情
执行用时 : 1 ms, 在所有 Java 提交中击败了 80.18% 的用户
内存消耗 : 40.1 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

# 07 重建二叉树

```
@author: sdubrz
@date: 2020.05.03
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入某二叉树的前序遍历和中序遍历的结果，请重建该二叉树。假设输入的前序遍历和中序遍历的结果中都不含重复的数字。

例如，给出

```
前序遍历 preorder = [3,9,20,15,7]
中序遍历 inorder = [9,3,15,20,7]
```

返回如下的二叉树：

```
    3
   / \
  9  20
    /  \
   15   7
```

限制：

``0 <= 节点个数 <= 5000``

## 我的解法

对于一颗二叉树，其前序遍历中第一个元素必然是根节点，并且左子树的元素位于右子树元素的前面。而在中序遍历中，左子树的元素均位于根节点元素的前面，右子树的元素均位于根节点元素的后面。下图表示了这一位置关系，其中红色元素为根节点，绿色的为左子树中的元素，蓝色的为右子树中的元素。

![二叉树](E:/会读书/放在GitHub的读书笔记/ReadNote/LeetCode/剑指offer/images/7.png)

根据这一位置关系，我们可以写出递归的解决方案，下面是具体的Java代码实现。

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        if(preorder.length==0){
            return null;
        }
        int n = preorder.length;
        TreeNode  root = this.buildTree(preorder, inorder, 0, n-1, 0, n-1);
        return root;
    }

    private TreeNode buildTree(int[] preorder, int[] inorder, int preHead, int preTail, int inHead, int inTail){
        if(preHead==preTail){ // 只有一个节点
            TreeNode node = new TreeNode(preorder[preHead]);
            return node;
        }

        TreeNode root = new TreeNode(preorder[preHead]);
        int rootIndex = -1;
        for(int i=inHead; i<=inTail; i++){
            if(inorder[i]==preorder[preHead]){
                rootIndex = i;
                break;
            }
        }
        
        int leftSize = rootIndex - inHead;  // 左子树节点数
        int rightSize = inTail - rootIndex;  // 右子树节点数
        if(leftSize>0){
            root.left = this.buildTree(preorder, inorder, preHead+1, preHead+leftSize, inHead, rootIndex-1);
        }
        if(rightSize>0){
            root.right = this.buildTree(preorder, inorder, preHead+leftSize+1, preTail, rootIndex+1, inTail);
        }
        return root;
    }

}
```

在 LeetCode 系统中提交的结果如下

```
执行结果： 通过 显示详情
执行用时 : 4 ms, 在所有 Java 提交中击败了 60.63% 的用户
内存消耗 : 40.1 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

## 官方递归解法

LeetCode 的题解中官方给出了递归和迭代两种解法。其中，递归解法的思路与我的一致，不过代码的实现略有不同。下面是官方给出的递归解法的Java代码。

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        if (preorder == null || preorder.length == 0) {
            return null;
        }
        Map<Integer, Integer> indexMap = new HashMap<Integer, Integer>();
        int length = preorder.length;
        for (int i = 0; i < length; i++) {
            indexMap.put(inorder[i], i);
        }
        TreeNode root = buildTree(preorder, 0, length - 1, inorder, 0, length - 1, indexMap);
        return root;
    }

    public TreeNode buildTree(int[] preorder, int preorderStart, int preorderEnd, int[] inorder, int inorderStart, int inorderEnd, Map<Integer, Integer> indexMap) {
        if (preorderStart > preorderEnd) {
            return null;
        }
        int rootVal = preorder[preorderStart];
        TreeNode root = new TreeNode(rootVal);
        if (preorderStart == preorderEnd) {
            return root;
        } else {
            int rootIndex = indexMap.get(rootVal);
            int leftNodes = rootIndex - inorderStart, rightNodes = inorderEnd - rootIndex;
            TreeNode leftSubtree = buildTree(preorder, preorderStart + 1, preorderStart + leftNodes, inorder, inorderStart, rootIndex - 1, indexMap);
            TreeNode rightSubtree = buildTree(preorder, preorderEnd - rightNodes + 1, preorderEnd, inorder, rootIndex + 1, inorderEnd, indexMap);
            root.left = leftSubtree;
            root.right = rightSubtree;
            return root;
        }
    }
}
```

由于使用了一个Map来存储中序遍历中每个元素与其索引的对应关系，因而在查找节点位置时，官方代码要比我的代码更快一些。

```
执行结果： 通过 显示详情
执行用时 : 3 ms, 在所有 Java 提交中击败了 81.16% 的用户
内存消耗 : 39.8 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

## 官方迭代解法

![迭代1](E:/会读书/放在GitHub的读书笔记/ReadNote/LeetCode/剑指offer/images/7_2.png)

![迭代2](E:/会读书/放在GitHub的读书笔记/ReadNote/LeetCode/剑指offer/images/7_3.png)

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        if (preorder == null || preorder.length == 0) {
            return null;
        }
        TreeNode root = new TreeNode(preorder[0]);
        int length = preorder.length;
        Stack<TreeNode> stack = new Stack<TreeNode>();
        stack.push(root);
        int inorderIndex = 0;
        for (int i = 1; i < length; i++) {
            int preorderVal = preorder[i];
            TreeNode node = stack.peek();
            if (node.val != inorder[inorderIndex]) {
                node.left = new TreeNode(preorderVal);
                stack.push(node.left);
            } else {
                while (!stack.isEmpty() && stack.peek().val == inorder[inorderIndex]) {
                    node = stack.pop();
                    inorderIndex++;
                }
                node.right = new TreeNode(preorderVal);
                stack.push(node.right);
            }
        }
        return root;
    }
}

```

下面是在 LeetCode 系统中提交的结果

```
执行结果： 通过 显示详情
执行用时 : 3 ms, 在所有 Java 提交中击败了 81.16% 的用户
内存消耗 : 39.6 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

由于每个元素都需要一次新建节点的过程，所以这三种方法的时间复杂度均为 $O(n)$。

# 09 用两个栈实现队列

```
@author: sdubrz
@date: 2020.05.04
难度： 简单
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

用两个栈实现一个队列。队列的声明如下，请实现它的两个函数 appendTail 和 deleteHead ，分别完成在队列尾部插入整数和在队列头部删除整数的功能。(若队列中没有元素，deleteHead 操作返回 -1 )

**示例 1：**

```
输入：
["CQueue","appendTail","deleteHead","deleteHead"]
[[],[3],[],[]]
输出：[null,null,3,-1]
```

**示例 2：**

```
输入：
["CQueue","deleteHead","appendTail","appendTail","deleteHead","deleteHead"]
[[],[],[5],[2],[],[]]
输出：[null,-1,null,null,5,2]
```

提示：

+ 1 <= values <= 10000
+ 最多会对 appendTail、deleteHead 进行 10000 次调用


## 我的解法

队列是先进先出的，栈是先进后出的，所以用一个栈将另一个栈的顺序颠倒一下，就可以改成先进先出的队列了。这个比较简单，下面是Java程序实现：

```java
import java.util.*;
class CQueue {
    private Stack<Integer> stack1;
    private Stack<Integer> stack2;
    public CQueue() {
        this.stack1 = new Stack<>();
        this.stack2 = new Stack<>();
    }
    
    public void appendTail(int value) {
        while(!stack2.isEmpty()){
            stack1.push(stack2.pop());
        }
        stack1.push(value);
    }
    
    public int deleteHead() {
        if(stack1.isEmpty() && stack2.isEmpty()){
            return -1;
        }

        while(!stack1.isEmpty()){
            stack2.push(stack1.pop());
        }

        return stack2.pop();
    }
}

/**
 * Your CQueue object will be instantiated and called as such:
 * CQueue obj = new CQueue();
 * obj.appendTail(value);
 * int param_2 = obj.deleteHead();
 */
```

在 LeetCode 系统中提交的结果如下

```
执行结果： 通过 显示详情
执行用时 : 198 ms, 在所有 Java 提交中击败了 39.76% 的用户
内存消耗 : 47.9 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

## 网友的解法

在我的方法中每次插入和删除都要先把所有元素放入同一个栈中。有[网友](https://leetcode-cn.com/u/jimlee1996/)指出，不需要在插入和删除时都进行顺序颠倒，例如当用 stack1 管理添加，stack2 管理删除时，在删除的时候只需要在 stack2 为空时，才将 stack1 中的元素全部转移到 stack2 即可，而在添加元素时，只需要简单地往 stack1 中添加元素即可，不用管 stack2 。这样可以减少两个栈之间不必要的元素交换。下面是根据这一思路，用Java的具体实现。

```java
class CQueue {

    public int size;
    private Stack<Integer> stack1;
    private Stack<Integer> stack2;

    public CQueue() {
        this.size = 0;
        this.stack1 = new Stack<>();
        this.stack2 = new Stack<>();
    }
    
    public void appendTail(int value) {
        stack1.push(value);
        size++;
    }
    
    public int deleteHead() {
        if(size==0){
            return -1;
        }

        if(stack2.isEmpty()){
            while(!stack1.isEmpty()){
                stack2.push(stack1.pop());
            }
        }
        size--;
        return stack2.pop();      
    }
}

/**
 * Your CQueue object will be instantiated and called as such:
 * CQueue obj = new CQueue();
 * obj.appendTail(value);
 * int param_2 = obj.deleteHead();
 */
```

在 LeetCode 系统中提交结果显示，这一方法要比我前面的方法快一些。提交结果显示，这一方法也不是所有 Java 提交中最快的方法，是因为部分网友没有真正地使用两个栈来实现，而是使用了数组或直接用的库中的队列实现，拉高了排名标准。

```
执行结果： 通过 显示详情
执行用时 : 66 ms, 在所有 Java 提交中击败了 66.77% 的用户
内存消耗 : 47.9 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

# 10 青蛙跳台阶问题

```
@author: sdubrz
@date: 2020.05.05
难度： 简单
考察内容： 动态规划
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个 n 级的台阶总共有多少种跳法。

答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。

**示例 1：**

```
输入：n = 2
输出：2
```

**示例 2：**

```
输入：n = 7
输出：21
```

**提示：**

+ 0 <= n <= 100

## 解法

这道题可以用动态规划来解。对于规模为 n 的问题，最后一阶台阶有两种走法：单独走（这时候只需要知道前n-1阶有多少种走法即可），与上一阶同一步走（这时候只需要知道前n-2阶有多少种走法即可）。所以有如下递推式

$$
f(n) = f(n-1) + f(n-2)
$$

很明显，这是一个斐波那契数列数列的应用问题。下面是具体的Java程序实现

```java
class Solution {
    public int numWays(int n) {
        if(n==0||n==1){
            return 1;
        }

        int[] count = new int[n+1];
        count[0] = 1;
        count[1] = 1;
        for(int i=2; i<=n; i++){
            count[i] = (count[i-1] + count[i-2])%1000000007;
        }

        return count[n];
    }
}
```

在 LeetCode 系统中提交的结果如下

```
执行结果： 通过 显示详情
执行用时 : 0 ms, 在所有 Java 提交中击败了 100.00% 的用户
内存消耗 : 35.9 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

# 11 旋转数组中的最小数字

```
@author: sdubrz
@date: 2020.05.06
难度： 简单
考察内容： 数组
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素。例如，数组 [3,4,5,1,2] 为 [1,2,3,4,5] 的一个旋转，该数组的最小值为1。  

**示例 1：**

```
输入：[3,4,5,1,2]
输出：1
```

**示例 2：**

```
输入：[2,2,2,0,1]
输出：0
```

通过次数22,758 提交次数48,595

## 我的解法

由于输入是一个递增排序数组的旋转，因而，一种比较容易想到的方法就是从数组的末尾开始向前遍历，如果某个位置前面的元素比它大，那么它就是整个数组中的最小元素。这样时间复杂度为 $ O(n) $。下面是Java程序的实现

```java
class Solution {
    public int minArray(int[] numbers) {
        if(numbers.length==1){
            return numbers[0];
        }

        int minIndex = numbers.length-1;
        while(minIndex-1>0){
            if(numbers[minIndex-1]>numbers[minIndex]){
                break;
            }
            minIndex--;
        }

        if(minIndex-1==0){
            return Math.min(numbers[0], numbers[1]);
        }else{
            return numbers[minIndex];
        }
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果： 通过 显示详情
执行用时 : 1 ms, 在所有 Java 提交中击败了 50.32% 的用户
内存消耗 : 39.7 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

# 12 矩阵中的路径

```
@author: sdubrz
@date: 6/14/2020 8:51:16 PM 
难度： 中等
考察内容： 数组 深度优先搜索
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

请设计一个函数，用来判断在一个矩阵中是否存在一条包含某字符串所有字符的路径。路径可以从矩阵中的任意一格开始，每一步可以在矩阵中向左、右、上、下移动一格。如果一条路径经过了矩阵的某一格，那么该路径不能再次进入该格子。例如，在下面的3×4的矩阵中包含一条字符串“bfce”的路径（路径中的字母用加粗标出）。

[["a","b","c","e"],
["s","f","c","s"],
["a","d","e","e"]]

但矩阵中不包含字符串“abfb”的路径，因为字符串的第一个字符b占据了矩阵中的第一行第二个格子之后，路径不能再次进入这个格子。

**示例 1：**

```
输入：board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
输出：true
```

**示例 2：**

```
输入：board = [["a","b"],["c","d"]], word = "abcd"
输出：false
```

**提示：**

+ 1 <= board.length <= 200
+ 1 <= board[i].length <= 200

注意：本题与LeetCode 79 题相同：https://leetcode-cn.com/problems/word-search/

通过次数24,199 提交次数55,137

## 我的解法 深度优先搜索

拿到这道题没有想到更加有效的方法，只想起可以用深搜来暴力地寻找，应该不是比较快的方法，因为有很多重复比较的地方。很多的搜索匹配问题，在想不起更加有效的方法时，可以用深搜和广搜来当应急的方法，下面是Java程序的实现：

```java
class Solution {
    public boolean exist(char[][] board, String word) {
		int n = board.length;
		if(n<1) {
			return false;
		}
		int m = board[0].length;
		if(n*m<word.length()) {
			return false;
		}
		
		char[] words = word.toCharArray();
		for(int x=0; x<n; x++) {
			for(int y=0; y<m; y++) {
				if(board[x][y]==words[0]) {
					int[][] visited = new int[n][m];
					visited[x][y] = 1;
					boolean current = this.exist(board, words, x, y, visited, 0);
					if(current) {
						return true;
					}
				}
			}
		}
		
		
		return false;
	}
	
	public boolean exist(char[][] board, char[] words, int x, int y, int[][] visited, int offset) {
		if(offset==words.length-1) {
			return true;
		}
		if(x<board.length-1 && visited[x+1][y]==0) {  // 探索下边的单元
			if(board[x+1][y]==words[offset+1]) {
				int[][] visited2 = new int[board.length][];
				for(int i=0; i<board.length; i++) {
					visited2[i] = visited[i].clone();
				}
				visited2[x+1][y] = 1;
				boolean left = this.exist(board, words, x+1, y, visited2, offset+1);
				if(left) {
					return true;
				}
			}
		}
		
		if(x>0 && visited[x-1][y]==0) {  // 探索上边的单元
			if(board[x-1][y]==words[offset+1]) {
				int[][] visited2 = new int[board.length][];
				for(int i=0; i<board.length; i++) {
					visited2[i] = visited[i].clone();
				}
				visited2[x-1][y] = 1;
				boolean left = this.exist(board, words, x-1, y, visited2, offset+1);
				if(left) {
					return true;
				}
			}
		}
		
		if(y<board[0].length-1 && visited[x][y+1]==0) {  // 探索右边的单元
			if(board[x][y+1]==words[offset+1]) {
				int[][] visited2 = new int[board.length][];
				for(int i=0; i<board.length; i++) {
					visited2[i] = visited[i].clone();
				}
				visited2[x][y+1] = 1;
				boolean left = this.exist(board, words, x, y+1, visited2, offset+1);
				if(left) {
					return true;
				}
			}
		}
		
		if(y>0 && visited[x][y-1]==0) {  // 探索左边的单元
			if(board[x][y-1]==words[offset+1]) {
				int[][] visited2 = new int[board.length][];
				for(int i=0; i<board.length; i++) {
					visited2[i] = visited[i].clone();
				}
				visited2[x][y-1] = 1;
				boolean left = this.exist(board, words, x, y-1, visited2, offset+1);
				if(left) {
					return true;
				}
			}
		}
		
		return false;
	}

}

```

在 LeetCode 系统中提交的结果如下：

```
执行结果：通过 显示详情
执行用时 :85 ms, 在所有 Java 提交中击败了5.03%的用户
内存消耗 :44 MB, 在所有 Java 提交中击败了100.00%的用户
```

## 网友的版本

下面是一个网友实现的版本，基本思想与我是一样的，不过代码实现要比我好，在系统中提交的结果显示，运行速度要快于我的代码。我的代码之所以慢，主要原因应该是在保存数组的副本的时候浪费了大量的时间。做这种编程题，除了要有正确的思路之外，编码的质量也是十分重要的。

```java
class Solution {
    public boolean exist(char[][] board, String word) {
        char[] words = word.toCharArray();
        for(int i = 0; i < board.length; i++) {
            for(int j = 0; j < board[0].length; j++) {
                if(dfs(board, words, i, j, 0)) return true;
            }
        }
        return false;
    }
    boolean dfs(char[][] board, char[] word, int i, int j, int k) {
        if(i >= board.length || i < 0 || j >= board[0].length || j < 0 || board[i][j] != word[k]) return false;
        if(k == word.length - 1) return true;
        char tmp = board[i][j];
        board[i][j] = '/';
        boolean res = dfs(board, word, i + 1, j, k + 1) || dfs(board, word, i - 1, j, k + 1) || 
                      dfs(board, word, i, j + 1, k + 1) || dfs(board, word, i , j - 1, k + 1);
        board[i][j] = tmp;
        return res;
    }
}

作者：jyd
链接：https://leetcode-cn.com/problems/ju-zhen-zhong-de-lu-jing-lcof/solution/mian-shi-ti-12-ju-zhen-zhong-de-lu-jing-shen-du-yo/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

```

# 13 机器人的运动范围

```
@author: sdubrz
@date: 6/14/2020 10:38:29 PM  
难度： 中等
考察内容： 数组 深度优先搜索
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

地上有一个m行n列的方格，从坐标 [0,0] 到坐标 [m-1,n-1] 。一个机器人从坐标 [0, 0] 的格子开始移动，它每次可以向左、右、上、下移动一格（不能移动到方格外），也不能进入行坐标和列坐标的数位之和大于k的格子。例如，当k为18时，机器人能够进入方格 [35, 37] ，因为3+5+3+7=18。但它不能进入方格 [35, 38]，因为3+5+3+8=19。请问该机器人能够到达多少个格子？

 

**示例 1：**

```
输入：m = 2, n = 3, k = 1
输出：3
```

**示例 2：**

```
输入：m = 3, n = 1, k = 0
输出：1
```

**提示：**

+ 1 <= n,m <= 100
+ 0 <= k <= 20

通过次数39,759 提交次数81,812

## 我的解法 深度优先搜索

这种搜索的题可以用深度优先搜索来暴力搜索，不过在该题中需要判断某个点是否可达。Java程序实现如下：

```java
import java.util.*;
class Solution {
    public int movingCount(int m, int n, int k) {
		int[][] visited = new int[m][n];
		int count = 0;
		Stack<Integer> stack1 = new Stack<>();
		Stack<Integer> stack2 = new Stack<>();
		
		stack1.push(0);
		stack2.push(0);
		visited[0][0] = 1;
		count++;
		
		while(!stack1.isEmpty()) {
			int x = stack1.pop();
			int y = stack2.pop();
			
			if(x>0 && visited[x-1][y]==0) {  // 尝试左边的
				if(this.available(x-1, y, k)) {
					stack1.push(x-1);
					stack2.push(y);
					visited[x-1][y] = 1;
					count++;
				}
			}
			
			if(x<m-1 && visited[x+1][y]==0) {  // 尝试右边的
				if(this.available(x+1, y, k)) {
					stack1.push(x+1);
					stack2.push(y);
					visited[x+1][y] = 1;
					count++;
				}
			}
			
			if(y>0 && visited[x][y-1]==0) {
				if(this.available(x, y-1, k)) {
					stack1.push(x);
					stack2.push(y-1);
					visited[x][y-1] = 1;
					count++;
				}
			}
			
			if(y<n-1 && visited[x][y+1]==0) {
				if(this.available(x, y+1, k)) {
					stack1.push(x);
					stack2.push(y+1);
					visited[x][y+1] = 1;
					count++;
				}
			}
		}
		
		return count;
	}
	
	private boolean available(int x, int y, int k) {
		int a = x;
		int b = y;
		int sum = 0;
		while(a>0) {
			sum += a % 10;
			a = a / 10;
		}
		while(b>0) {
			sum += b % 10;
			b = b / 10;
		}
		if(sum>k)
			return false;
		else
			return true;
	}

}
```

在 LeetCode 系统中提交的结果如下所示

```
执行结果：通过 显示详情
执行用时 :6 ms, 在所有 Java 提交中击败了24.09%的用户
内存消耗 :36.6 MB, 在所有 Java 提交中击败了100.00%的用户
```

# 14 剪绳子

```
@author: sdubrz
@date: 7/2/2020 3:46:36 PM   
难度： 中等
考察内容： 动态规划
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

给你一根长度为 n 的绳子，请把绳子剪成整数长度的 m 段（m、n都是整数，n>1并且m>1），每段绳子的长度记为 k[0],k[1]...k[m-1] 。请问 k[0]*k[1]*...*k[m-1] 可能的最大乘积是多少？例如，当绳子的长度是8时，我们把它剪成长度分别为2、3、3的三段，此时得到的最大乘积是18。

**示例 1：**

```
输入: 2
输出: 1
解释: 2 = 1 + 1, 1 × 1 = 1
```

**示例 2:**

```
输入: 10
输出: 36
解释: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36
```

**提示：**

+ 2 <= n <= 58

通过次数29,381 提交次数53,858

## 我的解法

这道题可以用动态规划来解：Java程序实现如下

```java
class Solution {
    public int cuttingRope(int n) {
        if(n==2) {
			return 1;
		}
		int[] array = new int[n+1];
		array[1] = 1;
		array[2] = 2;
		
		for(int i=3; i<n; i++) {
			int temp = i;
			for(int j=1; j<=i/2; j++) {
				int t = array[j] * array[i-j];
				if(t>temp) {
					temp = t;
				}
			}
			array[i] = temp;
		}
		
		int temp0 = array[1] * array[n-1];
		for(int i=2; i<=n/2; i++) {
			int t = array[i] * array[n-i];
			if(temp0<t) {
				temp0 = t;
			}
		}
		
		return temp0;
    }
}
```

在 LeetCode 系统中提交的结果如下所示

```
执行结果：通过 显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：36.2 MB, 在所有 Java 提交中击败了100.00%的用户
```

## 剪绳子II

```
@date: 7/16/2020 3:20:14 PM 
```

现在对题目进行修改，使 n 的取值范围扩大至 ``2<=n<=1000``。这时候就不能再使用动态规划的方法了。这道题可以用贪心的算法来解，规律是尽量分配较多的3。

下面是网友[pipi](https://leetcode-cn.com/u/pipi-3/ "pipi")给出的Java实现：

```
class Solution {
    public int cuttingRope(int n) {
         if(n == 2)
            return 1;
        if(n == 3)
            return 2;
        long res = 1;
        while(n > 4){
            res *= 3;
            res = res % 1000000007;
            n -= 3;
        }
        return (int)(res * n % 1000000007);
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：36.4 MB, 在所有 Java 提交中击败了100.00%的用户
```

这道题，真正在应试过程中从正面推导出做法可能比较困难，或许网友[KAI](https://leetcode-cn.com/u/kai1314/)给出的这种暴力找规律的思路更实用一点，或许可解燃眉之急：

```java
class Solution {
public:
    void dfs(int n, long sum, long multi, long& ans) {
        if (sum == n) {
            ans = max(ans, multi);
            return;
        } else if (sum > n) {
            return;
        }
        for (long i = 1; i < n; i++) {
            dfs(n, i+sum, i*multi, ans);
        }
        return;
    }

    int cuttingRope(int n) {
        long ans = 0;
        dfs(n, 0, 1, ans);
        return ans;
    }
};

//--->
n     乘积     子数字
2       1       1 1
3       2       1 2
4       4       2 2
5       6       2 3
6       9       3 3
7       12      2 2 3
8       18      2 3 3
9       27      3 3 3
10      36      2 2 3 3
11      54      2 3 3 3
12      81      3 3 3 3
13      108     2 2 3 3 3
14      162     2 3 3 3 3
15      243     3 3 3 3 3
16      324     2 2 3 3 3 3
17      486     2 3 3 3 3 3
18      729     3 3 3 3 3 3
19      972     2 2 3 3 3 3 3
20      1458    2 3 3 3 3 3 3
21      2187    3 3 3 3 3 3 3
22      2916    2 2 3 3 3 3 3 3
23      4374    2 3 3 3 3 3 3 3
24      6561    3 3 3 3 3 3 3 3
25      8748    2 2 3 3 3 3 3 3 3
26      13122   2 3 3 3 3 3 3 3 3
27      19683   3 3 3 3 3 3 3 3 3
28      26244   2 2 3 3 3 3 3 3 3 3
29      39366   2 3 3 3 3 3 3 3 3 3
```

# 15 二进制中1的个数

```
@author: sdubrz
@date: 7/16/2020 3:48:10 PM   
难度： 简单
考察内容： 二进制
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

请实现一个函数，输入一个整数，输出该数二进制表示中 1 的个数。例如，把 9 表示成二进制是 1001，有 2 位是 1。因此，如果输入 9，则该函数输出 2。

**示例 1：**

```
输入：00000000000000000000000000001011
输出：3
解释：输入的二进制串 00000000000000000000000000001011 中，共有三位为 '1'。
```

**示例 2：**

```
输入：00000000000000000000000010000000
输出：1
解释：输入的二进制串 00000000000000000000000010000000 中，共有一位为 '1'。
```

**示例 3：**

```
输入：11111111111111111111111111111101
输出：31
解释：输入的二进制串 11111111111111111111111111111101 中，共有 31 位为 '1'。
```

## 解法

下面是网友[Satan](https://leetcode-cn.com/u/satan/)给出的解法：

把一个整数减去1，再和原整数做与运算，会把该整数最右边一个1变成0.那么一个整数的二进制有多少个1，就可以进行多少次这样的操作。

Java代码实现如下

```java
public class Solution {
    // you need to treat n as an unsigned value
    public int hammingWeight(int n) {
        int count = 0;
        while(n!=0){
            count++;
            n = n & (n-1);
        }
        return count;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：1 ms, 在所有 Java 提交中击败了99.27%的用户
内存消耗：36.6 MB, 在所有 Java 提交中击败了100.00%的用户
```

另：Java中的无符号右移运算符为 ``>>>``

# 16 数值的整数次方

```
@author: sdubrz
@date: 8/13/2020 16:48:23 PM   
难度： 中等
考察内容： 
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

实现函数double Power(double base, int exponent)，求base的exponent次方。不得使用库函数，同时不需要考虑大数问题。

**示例 1:**

```
输入: 2.00000, 10
输出: 1024.00000
```

**示例 2:**

```
输入: 2.10000, 3
输出: 9.26100
```

**示例 3:**

```
输入: 2.00000, -2
输出: 0.25000
解释: 2^-2 = 1/2^2 = 1/4 = 0.25
```

**说明:**

+ -100.0 < x < 100.0
+ n 是 32 位有符号整数，其数值范围是 [−231, 231 − 1] 。

## 我的第一种解法

我设计的解法是通过对指数进行分析，以达到减少乘法次数的目的的。但是提交之后显示超出内存限制。

```java
class Solution {
    public double myPow(double x, int n) {
        if(n==0) {
			return 1;
		}
		boolean inv = false;
		if(n<0) {
			n = -1*n;
			inv = true;
		}
		
		ArrayList<Double> list = new ArrayList<>();
		//ArrayList<Integer> list2 = new ArrayList<>();
		//list.add(1.0);
		list.add(x);
		//list2.add(1);
		int index = 0;  // 2的指数
		int temp = 1;  // pow(2, index)
		while(temp*2<=n) {
			double current = list.get(index) * list.get(index);
			list.add(current);
			temp *= 2;
			//list2.add(temp);
			index++;
		}
		
		double result = 1.0;
		
		while(n>0) {
			result *= list.get(index);
			n = n - temp;
			while(temp>n) {
				temp /= 2;
				index--;
			}
		}
		
		// System.out.println(list);
		
		if(inv) {
			return 1.0/result;
		}else {
			return result;
		}
    }
}
```

提交结果显示超出内存限制。

## 第二种解法 递归方式

《剑指offer》书中是用的递归方式实现，可以通过提交，不过需要注意一些边界条件的处理。

```java
class Solution {
    public double myPow(double x, int n) {
        if(x==0.0){
            return 0.0;
        }
        if(n==0){
            return 1.0;
        }

        boolean inv = false;
        if(n<0){
            n = -1*n;
            inv = true;
        }

        if(n==1){
            if(inv)
                return 1 / x;
            return x;
        }

        double result = myPow(x, n/2);
        result *= result;
        if(n%2==1){
            result *= x;
        }

        if(inv && result!=0.0)
            return 1.0/result;

        return result;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：1 ms, 在所有 Java 提交中击败了94.79%的用户
内存消耗：37.1 MB, 在所有 Java 提交中击败了37.65%的用户
```



# 18 删除链表的节点

```
@author: sdubrz
@date: 7/25/2020 9:41:33 AM   
难度： 简单
考察内容： 二进制
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

给定单向链表的头指针和一个要删除的节点的值，定义一个函数删除该节点。

返回删除后的链表的头节点。

**注意：**此题对比原题有改动

**示例 1:**

```
输入: head = [4,5,1,9], val = 5
输出: [4,1,9]
解释: 给定你链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9.
```

**示例 2:**

```
输入: head = [4,5,1,9], val = 1
输出: [4,5,9]
解释: 给定你链表中值为 1 的第三个节点，那么在调用了你的函数之后，该链表应变为 4 -> 5 -> 9.
```

**说明：**

+ 题目保证链表中节点的值互不相同
+ 若使用 C 或 C++ 语言，你不需要 free 或 delete 被删除的节点

通过次数40,406提交次数68,572

## 解法

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    public ListNode deleteNode(ListNode head, int val) {
        if(head==null) {
			return null;
		}
		if(head.val==val) {
			head = head.next;
			return head;
		}
		
		ListNode pre = head;
		ListNode current = head.next;
		while(current!=null) {
			if(current.val==val) {
				pre.next = current.next;
				break;
			}else {
				pre = pre.next;
				current = current.next;
			}
		}
		
		return head;
		
    }
}
```

在LeetCode系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：39.4 MB, 在所有 Java 提交中击败了100.00%的用户
```

# 19 正则表达式匹配

```
@date: 8/18/2020 10:26:00 AM
@难度: 困难
考察内容： 字符串 动态规划
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

请实现一个函数用来匹配包含``'. '``和``'*'``的正则表达式。模式中的字符``'.'``表示任意一个字符，而``'*'``表示它前面的字符可以出现任意次（含0次）。在本题中，匹配是指字符串的所有字符匹配整个模式。例如，字符串``"aaa"``与模式``"a.a"``和``"ab*ac*a"``匹配，但与``"aa.a"``和``"ab*a"``均不匹配。

**示例 1:**

```
输入:
s = "aa"
p = "a"
输出: false
解释: "a" 无法匹配 "aa" 整个字符串。
```

**示例 2:**

```
输入:
s = "aa"
p = "a*"
输出: true
解释: 因为 '*' 代表可以匹配零个或多个前面的那一个元素, 在这里前面的元素就是 'a'。因此，字符串 "aa" 可被视为 'a' 重复了一次。
```

**示例 3:**

```
输入:
s = "ab"
p = ".*"
输出: true
解释: ".*" 表示可匹配零个或多个（'*'）任意字符（'.'）。
```

**示例 4:**

```
输入:
s = "aab"
p = "c*a*b"
输出: true
解释: 因为 '*' 表示零个或多个，这里 'c' 为 0 个, 'a' 被重复一次。因此可以匹配字符串 "aab"。
```

**示例 5:**

```
输入:
s = "mississippi"
p = "mis*is*p*."
输出: false
```



+ s 可能为空，且只包含从 a-z 的小写字母。
+ p 可能为空，且只包含从 a-z 的小写字母以及字符 . 和 *，无连续的 '*'。

## 递归解法

从示例来看，题目中的``.*``指的应该是任意的字符串，而不是只含有相同字符的字符串。这道题可以通过逐个判断模式字符串中前两个字符的情况，然后递归地来解:

```java
class Solution {
    public boolean isMatch(String s, String p) {

        return this.arrayMatch(s.toCharArray(), p.toCharArray(), 0, 0);
    }

    private boolean arrayMatch(char[] arrS, char[] arrP, int ptrS, int ptrP){
        int n1 = arrS.length;
        int n2 = arrP.length;

        if(ptrP==n2){  // 模式为空时，字符串必须为空
            return n1 == ptrS;
        }

        if(n1-ptrS==0){  // 字符串为空，模式非空时，模式必须是 某* 的形式
            if(n2-ptrP>=2 && arrP[ptrP+1]=='*'){
                return arrayMatch(arrS, arrP, ptrS, ptrP+2);
            }
            return false;
        }

        // 如果模式字符串只剩最后一个位置
        if(n2-ptrP==1){
            if(n1-ptrS==1){
                if(arrP[ptrP]=='.')
                    return true;
                else
                    return arrP[ptrP]==arrS[ptrS];
            }
            return false;
        }

        // 模式字符串还剩下两位或超过两位的情况
        if(arrP[ptrP]=='.'){
            if(arrP[ptrP+1]=='*'){
                // 题目对这种情况的意思似乎是任意的字符出现任意次
                return arrayMatch(arrS, arrP, ptrS+1, ptrP+2)
                        || arrayMatch(arrS, arrP, ptrS, ptrP+2)
                        || arrayMatch(arrS, arrP, ptrS+1, ptrP);
            }else{
                return arrayMatch(arrS, arrP, ptrS+1, ptrP+1);
            }
        }else{
            if(arrP[ptrP+1]=='*'){
                if(arrS[ptrS]==arrP[ptrP]){
                    return arrayMatch(arrS, arrP, ptrS+1, ptrP+2)
                            || arrayMatch(arrS, arrP, ptrS, ptrP+2)
                            || arrayMatch(arrS, arrP, ptrS+1, ptrP);
                }else{
                    return arrayMatch(arrS, arrP, ptrS, ptrP+2);
                }
            }else{
                if(arrS[ptrS]==arrP[ptrP]){
                    return arrayMatch(arrS, arrP, ptrS+1, ptrP+1);
                }else{
                    return false;
                }
            }
        }

    }
}
```

提交结果如下所示，时间效率并不高，原因应该是在递归调用中的几个“或”语句下面存在重复求解子问题的情况，因此可以用一个矩阵将这些子问题的求解结果存储下来，这样也就是动态规划方法了。

```
执行用时：846 ms, 在所有 Java 提交中击败了5.03%的用户
内存消耗：38.3 MB, 在所有 Java 提交中击败了59.69%的用户
```

## 自上而下的动态规划解法

前面已经提到，递归解法存在重复求解子问题的情况，因而可以在递归过程中增加备忘机制，使得时间效率大幅提高。《算法导论》中称这种思路为自上而下带备忘的动态规划方法。其具体实现如下，由于直接在上一个版本的基础上略加修改而成的，代码的书写不太优美，其实可以让``arrayMatch``函数变成``void``的。

```java
class Solution {
    public boolean isMatch(String s, String p) {

        int[][] count = new int[s.length()+1][p.length()+1];
        return this.arrayMatch(s.toCharArray(), p.toCharArray(), 0, 0, count);

    }

    private boolean arrayMatch(char[] arrS, char[] arrP, int ptrS, int ptrP, int[][] count){
        int n1 = arrS.length;
        int n2 = arrP.length;

        if(count[ptrS][ptrP]==1)
            return true;
        if(count[ptrS][ptrP]==-1)
            return false;

        if(ptrP==n2){  // 模式为空时，字符串必须为空
            if(n1 == ptrS){
                count[ptrS][ptrP] = 1;
                return true;
            }
            count[ptrS][ptrP] = -1;
            return false;
        }

        if(n1-ptrS==0){  // 字符串为空，模式非空时，模式必须是 某* 的形式
            if(n2-ptrP>=2 && arrP[ptrP+1]=='*'){
                boolean temp = arrayMatch(arrS, arrP, ptrS, ptrP+2, count);
                if(temp)
                    count[ptrS][ptrP] = 1;
                else
                    count[ptrS][ptrP] = -1;
                return temp;
            }
            count[ptrS][ptrP] = -1;
            return false;
        }

        // 如果模式字符串只剩最后一个位置
        if(n2-ptrP==1){
            if(n1-ptrS==1){
                if(arrP[ptrP]=='.') {
                    count[ptrS][ptrP] = 1;
                    return true;
                }else{
                    if(arrP[ptrP]==arrS[ptrS]){
                        count[ptrS][ptrP] = 1;
                        return true;
                    }
                    count[ptrS][ptrP] = -1;
                    return false;
                }
            }
            count[ptrS][ptrP] = -1;
            return false;
        }

        // 模式字符串还剩下两位或超过两位的情况
        if(arrP[ptrP]=='.'){
            if(arrP[ptrP+1]=='*'){
                // 题目对这种情况的意思似乎是任意的字符出现任意次
                boolean temp = arrayMatch(arrS, arrP, ptrS+1, ptrP+2, count)
                        || arrayMatch(arrS, arrP, ptrS, ptrP+2, count)
                        || arrayMatch(arrS, arrP, ptrS+1, ptrP, count);
                if(temp)
                    count[ptrS][ptrP] = 1;
                else
                    count[ptrS][ptrP] = -1;
                return temp;
            }else{
                boolean temp = arrayMatch(arrS, arrP, ptrS+1, ptrP+1, count);
                if(temp)
                    count[ptrS][ptrP] = 1;
                else
                    count[ptrS][ptrP] = -1;
                return temp;
            }
        }else{
            if(arrP[ptrP+1]=='*'){
                if(arrS[ptrS]==arrP[ptrP]){
                    boolean temp = this.arrayMatch(arrS, arrP, ptrS+1, ptrP+2, count)
                            || this.arrayMatch(arrS, arrP, ptrS, ptrP+2, count)
                            || this.arrayMatch(arrS, arrP, ptrS+1, ptrP, count);
                    if(temp)
                        count[ptrS][ptrP] = 1;
                    else
                        count[ptrS][ptrP] = -1;
                    return temp;
                }else{
                    boolean temp = arrayMatch(arrS, arrP, ptrS, ptrP+2, count);
                    if(temp)
                        count[ptrS][ptrP] = 1;
                    else
                        count[ptrS][ptrP] = -1;
                    return temp;
                }
            }else{
                if(arrS[ptrS]==arrP[ptrP]){
                    boolean temp = arrayMatch(arrS, arrP, ptrS+1, ptrP+1, count);
                    if(temp)
                        count[ptrS][ptrP] = 1;
                    else
                        count[ptrS][ptrP] = -1;
                    return temp;
                }else{
                    count[ptrS][ptrP] = -1;
                    return false;
                }
            }
        }

    }

}
```

在系统中提交的结果为

```
执行用时：2 ms, 在所有 Java 提交中击败了99.91%的用户
内存消耗：39.7 MB, 在所有 Java 提交中击败了20.39%的用户
```





# 21 调整数组顺序使奇数位于偶数前面

```
@author: sdubrz
@date: 7/25/2020 9:59:53 AM    
难度： 简单
考察内容： 数组
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数位于数组的前半部分，所有偶数位于数组的后半部分。

**示例：**

```
输入：nums = [1,2,3,4]
输出：[1,3,2,4] 
注：[3,1,2,4] 也是正确的答案之一。
```

**提示：**

+ 1 <= nums.length <= 50000
+ 1 <= nums[i] <= 10000

通过次数41,445提交次数64,453

## 解法

```java
class Solution {
    public int[] exchange(int[] nums) {
        if(nums.length<2) {
			return nums;
		}
		int pre = 0;
		int back = nums.length-1;
		
		while(pre<back) {
			while(pre<nums.length &&nums[pre]%2==1) {  // 从前往后找偶数
				pre++;
			}
			while(back>=0 &&nums[back]%2==0) {  // 从后往前找奇数
				back--;
			}
			
			if(pre<back) {
				int a = nums[pre];
				nums[pre] = nums[back];
				nums[back] = a;
			}
		}
			
		return nums;
    }
}
```

在LeetCode系统中提交的结果为

```
执行结果：通过  显示详情
执行用时：2 ms, 在所有 Java 提交中击败了99.82%的用户
内存消耗：47.6 MB, 在所有 Java 提交中击败了100.00%的用户
```

# 22 链表中倒数第k个节点

```
@author: sdubrz
@date: 7/25/2020 10:11:41 AM    
难度： 简单
考察内容： 链表
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入一个链表，输出该链表中倒数第k个节点。为了符合大多数人的习惯，本题从1开始计数，即链表的尾节点是倒数第1个节点。例如，一个链表有6个节点，从头节点开始，它们的值依次是1、2、3、4、5、6。这个链表的倒数第3个节点是值为4的节点。


**示例：**

```
给定一个链表: 1->2->3->4->5, 和 k = 2.

返回链表 4->5.
```

通过次数49,771提交次数63,088

## 解法 遍历两次链表

+ 第一次遍历获得链表的长度，计算出要返回的节点的正序位置。
+ 第二次遍历得到结果。

下面是Java程序的实现

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    public ListNode getKthFromEnd(ListNode head, int k) {
        int n = 0;
		ListNode current = head;
		// 第一次遍历，获知链表长度
		while(current!=null) {
			n++;
			current = current.next;
		}
		
		if(k>n) {  // 链表中元素个数不够
			return null;
		}
		
		int aim = n-k+1;  // 目标节点的正序次序
		int ptr = 1;
		current = head;
		// 第二次遍历到达目标节点
		while(ptr<aim) {
			current = current.next;
			ptr++;
		}
		
		return current;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：37.6 MB, 在所有 Java 提交中击败了100.00%的用户
```

# 24 反转链表

```
@author: sdubrz
@date: 7/25/2020 10:46:14 AM     
难度： 简单
考察内容： 链表
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

定义一个函数，输入一个链表的头节点，反转该链表并输出反转后链表的头节点。

**示例:**

```
输入: 1->2->3->4->5->NULL
输出: 5->4->3->2->1->NULL
```

**限制：**

0 <= 节点个数 <= 5000

## 解法一 栈

对于颠倒顺序的问题，最容易想到的解法就是用栈来实现：

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    public ListNode reverseList(ListNode head) {
        if(head==null) {
			return null;
		}
		if(head.next==null) {
			return head;
		}
		
		// 剩下的情况就是链表中至少有两个节点的情况
		Stack<ListNode> stack = new Stack<>();
		ListNode current = head;
		while(current!=null) {
			stack.push(current);
			current = current.next;
		}
		
		ListNode list2 = stack.pop();
		ListNode current2 = list2;
		while(stack.size()>1) {
			current2.next = stack.pop();
			current2 = current2.next;
		}
		ListNode lastNode = stack.pop();
		lastNode.next = null;
		current2.next = lastNode;
		
		return list2;
    }
}
```

但是对于链表的反转问题，栈的解法效率并不高。

```
执行结果：通过 显示详情
执行用时：1 ms, 在所有 Java 提交中击败了6.67%的用户
内存消耗：39.5 MB, 在所有 Java 提交中击败了100.00%的用户
```

## 解法二 一次遍历链表

遍历一次链表，并在遍历的过程中改变next的指向关系，具体实现如下：

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    public ListNode reverseList(ListNode head) {
        if(head==null) {
			return null;
		}
		if(head.next==null) {
			return head;
		}
		
		// 剩下的情况就是链表中至少有两个节点的情况
		ListNode pre = head;  // 前一个节点
		ListNode current = pre.next;  // 当前节点
		pre.next = null;
		while(current.next!=null) {
			ListNode back = current.next;
			current.next = pre;
			pre = current;
			current = back;
		}
		current.next = pre;
		
		return current;
    }
}
```

这种方法的效率要明显高于栈实现的版本：

```
执行结果：通过 显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：40 MB, 在所有 Java 提交中击败了100.00%的用户
```

# 25 合并两个排序的链表

```
@author: sdubrz
@date: 7/25/2020 3:23:12 PM    
难度： 简单
考察内容： 链表
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入两个递增排序的链表，合并这两个链表并使新链表中的节点仍然是递增排序的。

**示例1：**

```
输入：1->2->4, 1->3->4
输出：1->1->2->3->4->4
```

**限制：**

0 <= 链表长度 <= 1000

## 解法

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        if(l1==null){
            return l2;
        }
        if(l2==null){
            return l1;
        }

        ListNode head;
        ListNode ptr1;
        ListNode ptr2;
        if(l1.val>l2.val){
            head = l2;
            ptr1 = l1;
            ptr2 = l2.next;
        }else{
            head = l1;
            ptr1 = l1.next;
            ptr2 = l2;
        }

        ListNode current = head;
        while(ptr1!=null && ptr2!=null){
            if(ptr1.val>ptr2.val){
                current.next = ptr2;
                ptr2 = ptr2.next;
            }else{
                current.next = ptr1;
                ptr1 = ptr1.next;
            }
            current = current.next;
        }

        if(ptr1!=null){
            current.next = ptr1;
        }else{
            current.next = ptr2;
        }

        return head;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：1 ms, 在所有 Java 提交中击败了99.44%的用户
内存消耗：39.9 MB, 在所有 Java 提交中击败了100.00%的用户
```

# 26 树的子结构

```
@author: sdubrz
@date: 7/25/2020 4:03:31 PM   
难度： 中等
考察内容： 树
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入两棵二叉树A和B，判断B是不是A的子结构。(约定空树不是任意一个树的子结构)

B是A的子结构， 即 A中有出现和B相同的结构和节点值。

例如:

```
给定的树 A:

     3
    / \
   4   5
  / \
 1   2
给定的树 B：

   4 
  /
 1
返回 true，因为 B 与 A 的一个子树拥有相同的结构和节点值。
```

**示例 1：**

```
输入：A = [1,2,3], B = [3,1]
输出：false
```

**示例 2：**

```
输入：A = [3,4,5,1,2], B = [4,1]
输出：true
```

**限制：**

```
0 <= 节点个数 <= 10000
```

通过次数29,795提交次数64,231

## 解法

这道题做的时候需要搞清楚是判断树的子结构还是树的子树。这里是子结构，也就是说判断A中有没有一颗子树包含B，并且这颗子树可能有不属于B的其他叶子节点。

这道题我的思路是首先在A中寻找与B的根节点值相等的节点，然后在判断以这个节点为根的子树中是否包含B。下面是具体的Java实现：

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public boolean isSubStructure(TreeNode A, TreeNode B) {
        if(B==null || A==null){
            return false;
        }
        
        if(A.val==B.val){
            boolean find = isSubStructureRoot(A, B);
            if(find){
                return true;
            }
        }

        return isSubStructure(A.left, B) || isSubStructure(A.right, B);
    }

    // A和B树根相同的情况下，A是否含有B
    public boolean isSubStructureRoot(TreeNode A, TreeNode B){
        if(A==null && B!=null){
            return false;
        }
        if(B==null){
            return true;
        }
        if(A.val!=B.val){
            return false;
        }

        boolean a = isSubStructureRoot(A.left, B.left);
        if(!a){
            return false;
        }
        boolean b = isSubStructureRoot(A.right, B.right);
        if(!b){
            return false;
        }

        return true;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：41.5 MB, 在所有 Java 提交中击败了100.00%的用户
```

# 27 二叉树的镜像

```
@author: sdubrz
@date: 7/25/2020 4:18:02 PM   
难度： 简单
考察内容： 二叉树
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

请完成一个函数，输入一个二叉树，该函数输出它的镜像。

例如输入：

```
     4
   /   \
  2     7
 / \   / \
1   3 6   9
```

镜像输出：

```
     4
   /   \
  7     2
 / \   / \
9   6 3   1
```

**示例 1：**

```
输入：root = [4,2,7,1,3,6,9]
输出：[4,7,2,9,6,3,1]
```

**限制：**

```
0 <= 节点个数 <= 1000
```

## 解法

这道题比较简单了，递归大法好：

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode mirrorTree(TreeNode root) {
        if(root==null){
            return root;
        }

        TreeNode temp = root.left;
        root.left = mirrorTree(root.right);
        root.right = mirrorTree(temp);
        return root;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：37.1 MB, 在所有 Java 提交中击败了100.00%的用户
```

# 28 对称的二叉树

```
@author: sdubrz
@date: 7/25/2020 11:53:59 PM  
难度： 简单
考察内容： 二叉树
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

请实现一个函数，用来判断一棵二叉树是不是对称的。如果一棵二叉树和它的镜像一样，那么它是对称的。

例如，二叉树`` [1,2,2,3,4,4,3]`` 是对称的。

```
    1
   / \
  2   2
 / \ / \
3  4 4  3
```

但是下面这个 ``[1,2,2,null,3,null,3]`` 则不是镜像对称的:

```
    1
   / \
  2   2
   \   \
   3    3
```


**示例 1：**

```
输入：root = [1,2,2,3,4,4,3]
输出：true
```

**示例 2：**

```
输入：root = [1,2,2,null,3,null,3]
输出：false
```

**限制：**

+ 0 <= 节点个数 <= 1000

## 解法

对于这道题，当二叉树的根节点非空时，我们只需要判断根节点的左子树和右子树是否对称就可以了。而当这两个子树都不为空时，只需要判断左子树的左子树与右子树的右子树是否对称，以及左子树的右子树和右子树的左子树是否对称就可以了。如此，是一个递归的过程。

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public boolean isSymmetric(TreeNode root) {
        if(root==null){
            return true;
        }
        if(root.left==null && root.right==null){
            return true;
        }

        return isSymmetric(root.left, root.right);
    }

    // 判断两颗子树是不是对称的
    public boolean isSymmetric(TreeNode leftTree, TreeNode rightTree){
        if(leftTree==null && rightTree==null){
            return true;
        }
        if(leftTree==null || rightTree==null){
            return false;
        }
        if(leftTree.val != rightTree.val){
            return false;
        }

        return isSymmetric(leftTree.left, rightTree.right) && isSymmetric(leftTree.right, rightTree.left);

    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：38 MB, 在所有 Java 提交中击败了100.00%的用户
```

# 29 顺时针打印矩阵

```
@author: sdubrz
@date:  7/31/2020 10:50:03 AM 
难度： 简单
考察内容： 矩阵
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入一个矩阵，按照从外向里以顺时针的顺序依次打印出每一个数字。


**示例 1：**

```
输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]
输出：[1,2,3,6,9,8,7,4,5]
```

**示例 2：**

```
输入：matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
输出：[1,2,3,4,8,12,11,10,9,5,6,7]
```

**限制：**

+ 0 <= matrix.length <= 100
+ 0 <= matrix[i].length <= 100

## 解法

可以螺旋式的一层一层剥皮：

```java
class Solution {
    public int[] spiralOrder(int[][] matrix) {
        
        int n = matrix.length;
		if(n==0) {
			return new int[0];
		}
		int m = matrix[0].length;
		
        int[] result = new int[n*m];
        int direct = 1;  // 1:left, 2:down, 3:left, 4:right
        
        int count = 0;
        // int start = 0;
        int n_loop = Math.min((n+1)/2, (m+1)/2);
        for(int start=0; start<n_loop; start++) {   
        	// 一圈的上面一行
        	for(int i=start; i<m-start; i++) {
        		result[count] = matrix[start][i];
        		count++;
        	}
        	if(count>=n*m) {
        		break;
        	}
        	// 右边一列
        	for(int i=start+1; i<n-start-1; i++) {
        		result[count] = matrix[i][m-start-1];
        		count++;
        	}
        	if(count>=n*m) {
        		break;
        	}
        	// 下边一行
        	for(int i=m-start-1; i>=start; i--) {
        		result[count] = matrix[n-start-1][i];
        		count++;
        	}
        	if(count>=n*m) {
        		break;
        	}
        	// 左边一列
        	for(int i=n-start-2; i>start; i--) {
        		result[count] = matrix[i][start];
        		count++;
        	}
            if(count>=n*m) {
        		break;
        	}
        	
        }
        
        return result;

    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：1 ms, 在所有 Java 提交中击败了97.04%的用户
内存消耗：40.9 MB, 在所有 Java 提交中击败了72.20%的用户
```

# 30 包含min函数的栈

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

```java
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

# 31 栈的压入、弹出序列

```
@author: sdubrz
@date:  8/2/2020 9:02:57 AM 
难度： 中等
考察内容： 栈
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入两个整数序列，第一个序列表示栈的压入顺序，请判断第二个序列是否为该栈的弹出顺序。假设压入栈的所有数字均不相等。例如，序列 {1,2,3,4,5} 是某栈的压栈序列，序列 {4,5,3,2,1} 是该压栈序列对应的一个弹出序列，但 {4,3,5,1,2} 就不可能是该压栈序列的弹出序列。


**示例 1：**

```
输入：pushed = [1,2,3,4,5], popped = [4,5,3,2,1]
输出：true
解释：我们可以按以下顺序执行：
push(1), push(2), push(3), push(4), pop() -> 4,
push(5), pop() -> 5, pop() -> 3, pop() -> 2, pop() -> 1
```

**示例 2：**

```
输入：pushed = [1,2,3,4,5], popped = [4,3,5,1,2]
输出：false
解释：1 不能在 2 之前弹出。
```

**提示：**

+ 0 <= pushed.length == popped.length <= 1000
+ 0 <= pushed[i], popped[i] < 1000
+ pushed 是 popped 的排列。


# 解法

最容易想到的解决方法就是用一个真实的栈来进行测试。时间复杂度是 ``O(n)`` 的。

```java
class Solution {
    public boolean validateStackSequences(int[] pushed, int[] popped) {
        int n = pushed.length;
		int index2 = 0;
		
		Stack<Integer> stack = new Stack<>();
		for(int i=0; i<n; i++) {
			stack.push(pushed[i]);
			while(index2<n && (!stack.isEmpty()) && stack.peek()==popped[index2]) {
				stack.pop();
				index2++;
			}
		}
		
		if(stack.isEmpty()) {
			return true;
		}else {
			return false;
		}
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过显示详情
执行用时：3 ms, 在所有 Java 提交中击败了82.39%的用户
内存消耗：39.6 MB, 在所有 Java 提交中击败了12.36%的用户
```

# 32 从上到下打印二叉树

```
@author: sdubrz
@date:  8/2/2020 9:24:21 AM  
难度： 中等
考察内容： 二叉树
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

从上到下打印出二叉树的每个节点，同一层的节点按照从左到右的顺序打印。


例如:
给定二叉树: [3,9,20,null,null,15,7],

```
    3
   / \
  9  20
    /  \
   15   7
```

返回：

```
[3,9,20,15,7]
```

**提示：**

```
节点总数 <= 1000
```

## 解法

这个问题其实是一个广度优先搜索，可以用一个队列来实现：

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public int[] levelOrder(TreeNode root) {
        if(root==null) {
			return new int[0];
		}
		Queue<TreeNode> queue = new LinkedList<>();
		ArrayList<Integer> list = new ArrayList<>();
		queue.add(root);
		
		while(!queue.isEmpty()) {
			TreeNode current = queue.poll();
			list.add(current.val);
			if(current.left!=null) {
				queue.add(current.left);
			}
			if(current.right!=null) {
				queue.add(current.right);
			}
		}
		
		int[] result = new int[list.size()];
		Iterator<Integer> iter = list.iterator();
		int index = 0;
		while(iter.hasNext()) {
			result[index] = (int) iter.next();
			index++;
		}
		return result;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：1 ms, 在所有 Java 提交中击败了99.65%的用户
内存消耗：40 MB, 在所有 Java 提交中击败了35.23%的用户
```

# 32 从上到下打印二叉树II

```
@author: sdubrz
@date:  8/2/2020 9:42:54 AM  
难度： 简单
考察内容： 二叉树
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

从上到下按层打印二叉树，同一层的节点按从左到右的顺序打印，每一层打印到一行。

例如:
给定二叉树: [3,9,20,null,null,15,7],

```
    3
   / \
  9  20
    /  \
   15   7
```

返回其层次遍历结果：

```
[
  [3],
  [9,20],
  [15,7]
]
```

**提示：**

+ 节点总数 <= 1000

## 解法

这道题似乎比上一题要麻烦一点点，但不知道什么原因，LeetCode把上一题标记成中等难度，这道题简单难度。

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public List<List<Integer>> levelOrder(TreeNode root) {
        List<List<Integer>> list = new LinkedList<>();
		if(root==null) {
			return list;
		}
		
		LinkedList<TreeNode> currentList = new LinkedList<>();
		currentList.add(root);
		while(!currentList.isEmpty()) {
			Iterator<TreeNode> iter = currentList.iterator();
			LinkedList<TreeNode> nextList = new LinkedList<>();
			// int[] currentArray = new int[currentList.size()];
			List<Integer> subList = new LinkedList<>();
			int index = 0;
			while(iter.hasNext()) {
				TreeNode current = iter.next();
				subList.add(current.val);
				if(current.left!=null) {
					nextList.add(current.left);
				}
				if(current.right!=null) {
					nextList.add(current.right);
				}
			}
			list.add(subList);
			currentList = nextList;
		}
		
		return list;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：1 ms, 在所有 Java 提交中击败了93.41%的用户
内存消耗：39.9 MB, 在所有 Java 提交中击败了60.66%的用户
```

# 33 二叉搜索树的后序遍历序列


```
@author: sdubrz
@date:  8/2/2020 10:46:58 AM  
难度： 中等
考察内容： 二叉搜索树
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入一个整数数组，判断该数组是不是某二叉搜索树的后序遍历结果。如果是则返回 true，否则返回 false。假设输入的数组的任意两个数字都互不相同。

参考以下这颗二叉搜索树：

```
     5
    / \
   2   6
  / \
 1   3
```

**示例 1：**

```
输入: [1,6,3,2,5]
输出: false
```

**示例 2：**

```
输入: [1,3,2,6,5]
输出: true
```

**提示：**

+ 数组长度 <= 1000

通过次数25,327 提交次数48,585

## 解法

二叉搜索树的后序遍历数组中可以分为三部分：

+ 第一部分位于最左侧，是二叉搜索树根节点的左子树的元素，所有的元素都小于根节点。该部分可能为空。
+ 第二部分位于第一部分的左侧，是二叉搜索树根节点的右子树中的所有元素，均大于根节点。该部分可能为空。
+ 第三部分是最后一个元素，也就是二叉搜索树的根节点元素。

所以，这道题类似于快速排序中的思想，只需要判断给定的数组中，所有比根节点小的元素均位于比根节点大的元素的左侧就可以了。用递归的思想来做，时间复杂度为 ``O(nlog(n))``。需要注意的是，当数组中的元素不足3个的时候，一定是某个二叉搜索树的后序遍历。以下是具体的Java程序实现：

```java
class Solution {
    public boolean verifyPostorder(int[] postorder) {
		int n = postorder.length;
		if(n<3) {
			return true; 
		}
		
		return verifyPostorder(postorder, 0, n-1);
    }
	
	private boolean verifyPostorder(int[] postorder, int head, int tail) {
		if(tail-head<2) {
			return true;
		}
		
		int ptr1 = head-1; 
		int ptr2 = tail;
		while(ptr1+1<tail && postorder[ptr1+1]<postorder[tail]) {
			ptr1++;
		}
		while(ptr2-1>=head && postorder[ptr2-1]>postorder[tail]) {
			ptr2--;
		}
		
		if(ptr1==ptr2-1) {
			return verifyPostorder(postorder, head, ptr1) && verifyPostorder(postorder, ptr2, tail-1);
		}else {
			return false;
		}
	}
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：37.2 MB, 在所有 Java 提交中击败了34.81%的用户
```

# 34 二叉树中和为某一值的路径

```
@author: sdubrz
@date:  8/2/2020 2:54:10 PM   
难度： 中等
考察内容： 二叉树
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入一棵二叉树和一个整数，打印出二叉树中节点值的和为输入整数的所有路径。从树的根节点开始往下一直到叶节点所经过的节点形成一条路径。

**示例:**
给定如下二叉树，以及目标和 sum = 22，

```
              5
             / \
            4   8
           /   / \
          11  13  4
         /  \    / \
        7    2  5   1
```

返回:

```
[
   [5,4,11,2],
   [5,8,4,5]
]
```

**提示：**

+ 节点总数 <= 10000

## 解法

判断以 root 节点为根的二叉树中是否有和为 sum 的路径，就是判断 root 的左子树和右子树中是否有和为 sum-root.val 的路径。根据这一思路，可以写出递归的实现：

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public List<List<Integer>> pathSum(TreeNode root, int sum) {
        List<List<Integer>> list = new LinkedList<>();
		if(root==null) {
			return list;
		}
		
		if(root.val==sum && root.left==null && root.right==null) {
			List<Integer> tempList = new LinkedList<>();
			tempList.add(root.val);
			list.add(tempList);
			return list;
		}
		
		if(root.left!=null) {
			List<List<Integer>> leftList = pathSum(root.left, sum-root.val);
			Iterator<List<Integer>> iter = leftList.iterator();
			while(iter.hasNext()) {
				List<Integer> tempList = iter.next();
				tempList.add(0, root.val);
                list.add(tempList);
			}
		}
		if(root.right!=null) {
			List<List<Integer>> rightList = pathSum(root.right, sum-root.val);
			Iterator<List<Integer>> iter = rightList.iterator();
			while(iter.hasNext()) {
				List<Integer> tempList = iter.next();
				tempList.add(0, root.val);
                list.add(tempList);
			}
		}
		
		
		return list;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：2 ms, 在所有 Java 提交中击败了37.96%的用户
内存消耗：40 MB, 在所有 Java 提交中击败了72.31%的用户
```

# 35 复杂链表的复制

```
@author: sdubrz
@date:  8/2/2020 3:22:32 PM   
难度： 中等
考察内容： 链表
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社，图片来自LeetCode
```

请实现 copyRandomList 函数，复制一个复杂链表。在复杂链表中，每个节点除了有一个 next 指针指向下一个节点，还有一个 random 指针指向链表中的任意节点或者 null。

**示例 1：**

![](E:/会读书/放在GitHub的读书笔记/ReadNote/LeetCode/剑指offer/images/35_1.png)

```
输入：head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
输出：[[7,null],[13,0],[11,4],[10,2],[1,0]]
```

**示例 2：**

![](E:/会读书/放在GitHub的读书笔记/ReadNote/LeetCode/剑指offer/images/35_2.png)

```
输入：head = [[1,1],[2,1]]
输出：[[1,1],[2,1]]
```

**示例 3：**

![](E:/会读书/放在GitHub的读书笔记/ReadNote/LeetCode/剑指offer/images/35_3.png)

```
输入：head = [[3,null],[3,0],[3,null]]
输出：[[3,null],[3,0],[3,null]]
```

**示例 4：**

```
输入：head = []
输出：[]
解释：给定的链表为空（空指针），因此返回 null。
```

**提示：**

+ -10000 <= Node.val <= 10000
+ Node.random 为空（null）或指向链表中的节点。
+ 节点数目不超过 1000 。

## 一个错误的解法

先根据每个节点的 next 信息，复制所有的节点，然后根据节点的值逐个确定其 random 信息。这是一个时间复杂度为 ``O(n2)`` 的方法，并且当节点的取值存在重复时，无法正确确定每个节点的random信息。这是我第一时间想到的方法，提交之后运行结果错误。

```java
/*
// Definition for a Node.
class Node {
    int val;
    Node next;
    Node random;

    public Node(int val) {
        this.val = val;
        this.next = null;
        this.random = null;
    }
}
*/
class Solution {
    public Node copyRandomList(Node head) {
        if(head==null) {
        	return null;
        }
        
        Node headNode = new Node(head.val);
        Node current = headNode;
        Node ptrNode = head.next;
        while(ptrNode!=null) {
        	Node temp = new Node(ptrNode.val);
        	current.next = temp;
        	current = current.next;
        	ptrNode = ptrNode.next;
        }
        
        current = headNode;
        ptrNode = head;
        while(current!=null) {
        	if(ptrNode.random==null) {
        		ptrNode = ptrNode.next;
        		current = current.next;
        		continue;
        	}
        	
        	Node temp = headNode;
        	while(temp.val!=ptrNode.random.val) {
        		temp = temp.next;
        	}
        	current.random = temp;
        	ptrNode = ptrNode.next;
        	current = current.next;
        }
        
        return headNode;
    }
}
```

## 第二种方法 借助Map

我想到的第二种思路是将两个链表上相同位置上的节点建立映射关系，可以用HashMap帮助实现：

```java
/*
// Definition for a Node.
class Node {
    int val;
    Node next;
    Node random;

    public Node(int val) {
        this.val = val;
        this.next = null;
        this.random = null;
    }
}
*/
class Solution {
    public Node copyRandomList(Node head) {
        if(head==null) {
        	return null;
        }
		
		HashMap<Node, Node> map = new HashMap<>();
		
		Node headNode = new Node(head.val);
		map.put(head, headNode);
		Node current = headNode;
        Node ptrNode = head.next;
        while(ptrNode!=null) {
        	Node temp = new Node(ptrNode.val);
        	current.next = temp;
        	map.put(ptrNode, temp);
        	current = current.next;
        	ptrNode = ptrNode.next;
        }
        
        current = headNode;
        ptrNode = head;
        while(current!=null) {
        	if(ptrNode.random!=null) {
        		current.random = map.get(ptrNode.random);
        	}
        	current = current.next;
        	ptrNode = ptrNode.next;
        }
        
        return headNode;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果：通过 显示详情
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：39.3 MB, 在所有 Java 提交中击败了88.41%的用户
```

# 36 二叉搜索树与双向链表


```
@author: sdubrz
@date:  8/3/2020 4:22:22 PM  
难度： 中等
考察内容： 二叉搜索树 链表
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社，图片来自LeetCode
```

输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的循环双向链表。要求不能创建任何新的节点，只能调整树中节点指针的指向。

为了让您更好地理解问题，以下面的二叉搜索树为例：

![](E:/会读书/放在GitHub的读书笔记/ReadNote/LeetCode/剑指offer/images/36_1.png)

我们希望将这个二叉搜索树转化为双向循环链表。链表中的每个节点都有一个前驱和后继指针。对于双向循环链表，第一个节点的前驱是最后一个节点，最后一个节点的后继是第一个节点。

下图展示了上面的二叉搜索树转化成的链表。“head” 表示指向链表中有最小元素的节点。

![](E:/会读书/放在GitHub的读书笔记/ReadNote/LeetCode/剑指offer/images/36_2.png)

特别地，我们希望可以就地完成转换操作。当转化完成以后，树中节点的左指针需要指向前驱，树中节点的右指针需要指向后继。还需要返回链表中的第一个节点的指针。

## 解法

一种比较容易理解的思路是使用递归。在得到左子树的链表与右子树的链表之后将其与根节点合并。下面是具体的Java程序实现：

```java
/*
// Definition for a Node.
class Node {
    public int val;
    public Node left;
    public Node right;

    public Node() {}

    public Node(int _val) {
        val = _val;
    }

    public Node(int _val,Node _left,Node _right) {
        val = _val;
        left = _left;
        right = _right;
    }
};
*/
class Solution {
    public Node treeToDoublyList(Node root) {
		if(root==null) {
        	return null;
        }
        
        //System.out.println("根节点为 "+root.val);
        
        if(root.left==null && root.right==null) {
        	root.left = root;
        	root.right = root;
        	return root;
        }
        
        return treeToDoublyList0(root);
	}
	
	public Node treeToDoublyList0(Node root) {
        if(root==null) {
        	return null;
        }
        
        //System.out.println("根节点为 "+root.val);
        
        if(root.left==null && root.right==null) {
        	return root;
        }
        
        Node leftHead = null;
        Node rightHead = null;
        if(root.left!=null) {
        	leftHead = treeToDoublyList(root.left);
        }
        if(root.right!=null) {
        	rightHead = treeToDoublyList(root.right);
        }
        
        root.left = null;
        root.right = null;
        Node head = root;
        if(leftHead!=null) {
        	if(leftHead.left!=null) {  // 不是叶子节点
        		Node tempNode = leftHead.left;
        		leftHead.left = root;
        		root.left = tempNode;
        		root.right = leftHead;
        		tempNode.right = root;
        	}else {  // 叶子节点
        		leftHead.left = root;
        		leftHead.right = root;
        		root.left = leftHead;
        		root.right = leftHead;
        	}
        	head = leftHead;
        }
        
//        System.out.println("根节点为 "+root.val+" 时，加上左子树的结果");
//        printList(head);
        
        if(rightHead!=null) {
        	if(head.right==null) {  // 左子树为空
        		if(rightHead.left!=null) {  // 不是叶子节点
        			Node tempNode = rightHead.left;
        			rightHead.left = head;
        			head.right = rightHead;
        			head.left = tempNode;
        			tempNode.right = head;
        		}else {  // 是叶子节点
        			head.right = rightHead;
        			head.left = rightHead;
        			rightHead.left = head;
        			rightHead.right = head;
        		}
        	}else {  // 左子树不为空
        		if(rightHead.left!=null) {  // 不是叶子节点
        			Node tempNode1 = head.left;
        			Node tempNode2 = rightHead.left;
        			head.left = tempNode2;
        			rightHead.left = tempNode1;
        			tempNode1.right = rightHead;
        			tempNode2.right = head;
        			//System.out.println("RightHead = "+rightHead.val);
        		}else {  // 是叶子节点
        			Node tempNode = head.left;
        			head.left = rightHead;
        			rightHead.right = head;
        			rightHead.left = tempNode;
        			tempNode.right = rightHead;
        			//System.out.println("rightHead = "+rightHead.val);
        		}
        	}
        }
        
//        System.out.println("根节点为 "+root.val+" 时，加上右子树的结果");
//        printList(head);
        
        return head;
    }
}
```

下面是在LeetCode系统中提交的结果

```
执行结果：通过 显示详情
执行用时：1 ms, 在所有 Java 提交中击败了18.34%的用户
内存消耗：39.6 MB, 在所有 Java 提交中击败了11.89%的用户
```

这个方法效率不高，其实中序遍历是更好的实现思路。

# 37 序列化二叉树

```
@author: sdubrz
@date:  8/3/2020 6:47:45 PM  
难度： 困难
考察内容： 二叉树，字符串
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社，图片来自LeetCode
```

请实现两个函数，分别用来序列化和反序列化二叉树。

**示例:** 

```
你可以将以下二叉树：

    1
   / \
  2   3
     / \
    4   5

序列化为 "[1,2,3,null,null,4,5]"
```

## 我的解法

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
public class Codec {

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        // 需要先得知树的层数
    	if(root==null) {
    		return "[]";
    	}
    	Queue<TreeNode> queue1 = new LinkedList<>();
    	queue1.add(root);
    	int level = 0;
    	while(!queue1.isEmpty()) {
    		Queue<TreeNode> queue2 = new LinkedList<>();
    		while(!queue1.isEmpty()) {
    			TreeNode current = queue1.poll();
    			if(current.left!=null) {
    				queue2.add(current.left);
    			}
    			if(current.right!=null) {
    				queue2.add(current.right);
    			}
    		}
    		queue1 = queue2;
    		level++;
    	}
    	
    	int n = (int) Math.pow(2, level) - 1;
    	int[] nums = new int[n];
    	int[] labels = new int[n];
    	
    	serialize(root, nums, labels, 0);
    	String data = "[";
    	for(int i=0; i<n-1; i++) {
    		if(labels[i]==1) {
    			data = data + nums[i] + ",";
    		}else {
    			data = data + "null" + ",";
    		}
    	}
    	if(labels[n-1]==1) {
    		data = data + nums[n-1];
    	}else {
    		data = data + "null";
    	}
    	data = data + "]";
    	
    	
    	return data;
    }
    
    private void serialize(TreeNode root, int[] nums, int[] labels, int index) {
    	if(root==null) {
    		return;
    	}
    	
    	nums[index] = root.val;
    	labels[index] = 1;
    	
    	int leftIndex = index*2+1;
    	int rightIndex = index*2+2;
    	if(leftIndex<nums.length && root.left!=null) {
    		serialize(root.left, nums, labels, leftIndex);
    	}
    	if(rightIndex<nums.length && root.right!=null) {
    		serialize(root.right, nums, labels, rightIndex);
    	}
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
    	if(data.length()<3) {
    		return null;
    	}
    	String str = data.substring(1, data.length()-1);
    	String[] items = str.split(",");
    	int n = items.length;
    	int[] nums = new int[n];
    	int[] labels = new int[n];
    	for(int i=0; i<n; i++) {
    		if(!items[i].equals("null")) {
    			nums[i] = Integer.parseInt(items[i]);
    			labels[i] = 1;
    		}
    	}
    	
    	if(labels[0]!=1) {
    		return null;
    	}
    	
    	TreeNode root = new TreeNode(nums[0]);
    	root.left = getLeft(nums, labels, 0);
    	root.right = getRight(nums, labels, 0);
    	
        return root;
    }
    
    // 生成左孩子
    private TreeNode getLeft(int[] nums, int[] labels, int index) {
    	int leftIndex = index*2+1;
    	if(leftIndex>=nums.length || labels[leftIndex]==0) {
    		return null;
    	}
    	
    	TreeNode root = new TreeNode(nums[leftIndex]);
    	root.left = getLeft(nums, labels, leftIndex);
    	root.right = getRight(nums, labels, leftIndex);
    	return root;
    }
    
    // 生成右孩子
    private TreeNode getRight(int[] nums, int[] labels, int index) {
    	int rightIndex = index*2+2;
    	if(rightIndex>=nums.length || labels[rightIndex]==0) {
    		return null;
    	}
    	
    	TreeNode root = new TreeNode(nums[rightIndex]);
    	root.left = getLeft(nums, labels, rightIndex);
    	root.right = getRight(nums, labels, rightIndex);
    	return root;
    }
}

// Your Codec object will be instantiated and called as such:
// Codec codec = new Codec();
// codec.deserialize(codec.serialize(root));
```

提交后结果显示超时。

## 网友的解法

```java
public class Codec {
    public String serialize(TreeNode root) {
        if(root == null) return "[]";
        StringBuilder res = new StringBuilder("[");
        Queue<TreeNode> queue = new LinkedList<>() {{ add(root); }};
        while(!queue.isEmpty()) {
            TreeNode node = queue.poll();
            if(node != null) {
                res.append(node.val + ",");
                queue.add(node.left);
                queue.add(node.right);
            }
            else res.append("null,");
        }
        res.deleteCharAt(res.length() - 1);
        res.append("]");
        return res.toString();
    }

    public TreeNode deserialize(String data) {
        if(data.equals("[]")) return null;
        String[] vals = data.substring(1, data.length() - 1).split(",");
        TreeNode root = new TreeNode(Integer.parseInt(vals[0]));
        Queue<TreeNode> queue = new LinkedList<>() {{ add(root); }};
        int i = 1;
        while(!queue.isEmpty()) {
            TreeNode node = queue.poll();
            if(!vals[i].equals("null")) {
                node.left = new TreeNode(Integer.parseInt(vals[i]));
                queue.add(node.left);
            }
            i++;
            if(!vals[i].equals("null")) {
                node.right = new TreeNode(Integer.parseInt(vals[i]));
                queue.add(node.right);
            }
            i++;
        }
        return root;
    }
}

作者：jyd
链接：https://leetcode-cn.com/problems/xu-lie-hua-er-cha-shu-lcof/solution/mian-shi-ti-37-xu-lie-hua-er-cha-shu-ceng-xu-bian-/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
```

# 38 字符串的排列

```
@author: sdubrz
@date:  8/18/2020 16:11:58 PM  
难度： 中等
考察内容： 字符串 递归
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社
```

输入一个字符串，打印出该字符串中字符的所有排列。

你可以以任意顺序返回这个字符串数组，但里面不能有重复元素。

**示例:**

```
输入：s = "abc"
输出：["abc","acb","bac","bca","cab","cba"]
```

**限制：**

+ 1 <= s 的长度 <= 8

## 解法

就是每次判断第x位可以是什么字母。

```java
class Solution {
    List<String> res = new LinkedList<>();
    char[] c;
    public String[] permutation(String s) {
        c = s.toCharArray();
        dfs(0);
        return res.toArray(new String[res.size()]);
    }
    void dfs(int x) {
        if(x == c.length - 1) {
            res.add(String.valueOf(c)); // 添加排列方案
            return;
        }
        HashSet<Character> set = new HashSet<>();
        for(int i = x; i < c.length; i++) {
            if(set.contains(c[i])) continue; // 重复，因此剪枝
            set.add(c[i]);
            swap(i, x); // 交换，将 c[i] 固定在第 x 位 
            dfs(x + 1); // 开启固定第 x + 1 位字符
            swap(i, x); // 恢复交换
        }
    }
    void swap(int a, int b) {
        char tmp = c[a];
        c[a] = c[b];
        c[b] = tmp;
    }
}

```

提交结果为

```
执行用时：12 ms, 在所有 Java 提交中击败了66.28%的用户
内存消耗：45.4 MB, 在所有 Java 提交中击败了36.86%的用户
```

# 41 数据流中的中位数

```
@date: 2020-09-05
@difficulty: hard
```

如何得到一个数据流中的中位数？如果从数据流中读出奇数个数值，那么中位数就是所有数值排序之后位于中间的数值。如果从数据流中读出偶数个数值，那么中位数就是所有数值排序之后中间两个数的平均值。

例如，

[2,3,4] 的中位数是 3

[2,3] 的中位数是 (2 + 3) / 2 = 2.5

设计一个支持以下两种操作的数据结构：

+ void addNum(int num) - 从数据流中添加一个整数到数据结构中。
+ double findMedian() - 返回目前所有元素的中位数。

**示例 1**

```
输入：
["MedianFinder","addNum","addNum","findMedian","addNum","findMedian"]
[[],[1],[2],[],[3],[]]
输出：[null,null,null,1.50000,null,2.00000]
```

**示例 2**

```
输入：
["MedianFinder","addNum","findMedian","addNum","findMedian"]
[[],[2],[],[3],[]]
输出：[null,null,2.00000,null,2.50000]
```

**限制**

+ 最多会对 `addNum、findMedia`进行 `50000` 次调用。

## 插入排序解法

对于中位数和顺序统计量的问题，算法导论中有专门的一章来讲。对于一个长度为 n 的未排序数组，要查找它的第几大的数，或者中位数。可以基于快速排序中的分治思想实现一种期望时间复杂度为 $O(n)$ 的算法，但是，这种方法的最坏时间复杂度为 $O(n^2)$。不过一种更加复杂的方法可以将最坏时间复杂度降至$O(n)$。但是想了想，对于这个题来说，没有想出怎么用这种方式实现一种优于插入排序方法的解法。

但是基于好奇，还是想看下用插入排序的插入过程维护数组，效果怎么样。用插入排序的插入过程维持数组，就是当需要插入新数值时，每次都将其插入到正确的位置上，这样保证整个数组始终是排好序的。这样插入新数的时间复杂度为 $O(n)$，而返回中位数时，我们只需要根据数组的下标计算即可，所以时间复杂度为$O(1)$。下面是具体的Java程序实现，比较简单。

```java
public class MedianFinder {
    int[] nums;
    int size;
    public MedianFinder(){
        nums = new int[50000];
        size = 0;
    }

    public void addNum(int num){
        int ptr = size;
        while(ptr>0 && nums[ptr-1]>num){
            nums[ptr] = nums[ptr-1];
            ptr--;
        }
        nums[ptr] = num;
        size++;
    }

    public double findMedian(){
        if(size==0){
            return 0;
        }
        if(size%2==1){
            return nums[size/2];
        }else{
            return (0.0+nums[size/2]+nums[size/2-1]) / 2.0;
        }

    }
}


/**
 * Your MedianFinder object will be instantiated and called as such:
 * MedianFinder obj = new MedianFinder();
 * obj.addNum(num);
 * double param_2 = obj.findMedian();
 */
```

提交结果为

```
执行用时：215 ms, 在所有 Java 提交中击败了9.34%的用户
内存消耗：49.5 MB, 在所有 Java 提交中击败了99.21%的用户
```

从直觉上判断，这个题时间复杂的极限可能是把这个$O(n)$改为$O(logn)$。

## AVL树解法

打开《剑指offer》，才发现这个题可以用AVL树的解法来实现$O(logn)$。不过，要是用AVL树解的话，可以放弃了。无论是笔试还是面试，应该都是写不完的。因而，这里也就不放代码了，其实我也没去实现。

## 最大堆，最小堆解法

由于AVL树解法的不现实性，《剑指offer》书中给出了另一种同时使用最大堆和最小堆的方法。这个方法还是颇为巧妙的。让较大的一般放在最大堆中，较小的一半放在最小堆中，这样插入新数字的时间复杂度为$O(logn)$，获取中位数的时间复杂度为$O(1)$。妙呀。

下面是具体的Java程序实现，建议再写的时候把最大堆和最小堆单独拿出来分别作为一个新的类，我这种写法显得类有点大。

```java
public class MedianFinder {
    int size, leftSize, rightSize;
    int[] leftHeap;  // 最大堆，存放较小的一半数据
    int[] rightHeap;  // 最小堆，存放较大的一半数据
    final int MAXLENGTH = 50000;

    public MedianFinder(){
        leftHeap = new int[MAXLENGTH];
        rightHeap = new int[MAXLENGTH];
        size = 0;
        leftSize = 0;
        rightSize = 0;
    }

    public void addNum(int num){
        if(size==0){
            leftHeap[0] = num;
            size = 1;
            leftSize = 1;
            return;
        }

        if(num>leftHeap[0]){
            // 将其放入最小堆
            rightHeap[rightSize] = num;
            rightSize++;
            keepMinHeap();
        }else{
            // 将其放入最大堆
            leftHeap[leftSize] = num;
            leftSize++;
            keepMaxHeap();
        }
        size = leftSize + rightSize;
        keepMean();
    }

    public double findMedian(){
        if(size==0){
            return -1;
        }
        if(size%2==1){
            return leftHeap[0];
        }else{
            return (0.0+leftHeap[0]+rightHeap[0]) / 2.0;
        }

    }

    // 均衡最小堆与最大堆之间的元素个数，使最大堆中元素个数比最小堆多1，或相等
    private void keepMean(){
        if(leftSize==rightSize || leftSize-rightSize==1){
            return;
        }

        if(leftSize>rightSize){
            // 需要从最大堆中取出最大值，并放到最小堆中
            int temp = peekMaxHeap();
            rightHeap[rightSize] = temp;
            rightSize++;
            keepMinHeap();
        }else{
            // 需要从最小堆中取出最小值，并放到最大堆中
            int temp = peekMinHeap();
            leftHeap[leftSize] = temp;
            leftSize++;
            keepMaxHeap();
        }
    }

    // 从最小堆中取出堆顶元素
    private int peekMinHeap(){
        if(rightSize==0){
            return -1;
        }
        if(rightSize==1){
            rightSize = 0;
            return rightHeap[0];
        }
        int res = rightHeap[0];

        rightHeap[0] = rightHeap[rightSize-1];
        rightSize--;
        int current = 0;
        int leftChild = leftChildIndex(current);
        int rightChild = rightChildIndex(current);
        while(leftChild<rightSize){
            int min = current;
            if(rightHeap[leftChild]<rightHeap[min]){
                min = leftChild;
            }
            if(rightChild<rightSize && rightHeap[rightChild]<rightHeap[min]){
                min = rightChild;
            }
            if(min==leftChild){
                int temp = rightHeap[current];
                rightHeap[current] = rightHeap[leftChild];
                rightHeap[leftChild] = temp;
                current = leftChild;
            }else if(min==rightChild){
                int temp = rightHeap[current];
                rightHeap[current] = rightHeap[rightChild];
                rightHeap[rightChild] = temp;
                current = rightChild;
            }else{
                break;
            }

            leftChild = leftChildIndex(current);
            rightChild = rightChildIndex(current);
        }

        return res;
    }

    // 从最大堆中取出顶元素
    private int peekMaxHeap(){
        if(leftSize==0){
            return -1;
        }
        if(leftSize==1){
            leftSize = 0;
            return leftHeap[0];
        }

        int res = leftHeap[0];
        leftHeap[0] = leftHeap[leftSize-1];
        leftSize--;

        int current = 0;
        int leftChild = leftChildIndex(current);
        int rightChild = rightChildIndex(current);
        while(leftChild<leftSize){
            int max = current;
            if(leftHeap[leftChild]>leftHeap[max]){
                max = leftChild;
            }
            if(rightChild<leftSize && leftHeap[rightChild]>leftHeap[max]){
                max = rightChild;
            }

            if(max==leftChild){
                int temp = leftHeap[current];
                leftHeap[current] = leftHeap[leftChild];
                leftHeap[leftChild] = temp;
                current = leftChild;
            }else if(max==rightChild){
                int temp = leftHeap[current];
                leftHeap[current] = leftHeap[rightChild];
                leftHeap[rightChild] = temp;
                current = rightChild;
            }else{
                break;
            }

            leftChild = leftChildIndex(current);
            rightChild = rightChildIndex(current);
        }

        return res;
    }

    // 往最小堆中插入元素之后，调整最小堆
    private void keepMinHeap(){
        if(rightSize<=1){
            return;
        }

        int current = rightSize-1;
        while(current>0){
            int parent = parentIndex(current);
            if(rightHeap[current]<rightHeap[parent]){
                int temp = rightHeap[current];
                rightHeap[current] = rightHeap[parent];
                rightHeap[parent] = temp;
                current = parent;
            }else{
                break;
            }
        }
    }

    // 往最大堆中插入元素之后，调整最大堆
    private void keepMaxHeap(){
        if(leftSize<2){
            return;
        }

        int current = leftSize - 1;
        while(current>0){
            int parent = parentIndex(current);
            if(leftHeap[current]>leftHeap[parent]){
                int temp = leftHeap[current];
                leftHeap[current] = leftHeap[parent];
                leftHeap[parent] = temp;
                current = parent;
            }else{
                break;
            }
        }
    }

    // 计算堆中某个位置的父节点索引
    private int parentIndex(int current){
        return (current-1)/2;
    }

    private int leftChildIndex(int current){
        return current*2+1;
    }

    private int rightChildIndex(int current){
        return current*2+2;
    }
}

```

在 LeetCode 系统中提交的结果为：

```
执行用时：67 ms, 在所有 Java 提交中击败了99.41%的用户
内存消耗：50.9 MB, 在所有 Java 提交中击败了81.18%的用户
```

当数据具有一定规模时，堆的方法明显要比插入排序的方法快很多。

# 42 连续子数组的最大和

```
@author: sdubrz
@date:  8/3/2020 6:47:45 PM  
难度： 8/4/2020 10:56:03 PM 
考察内容： 动态规划，分而治之
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社，图片来自LeetCode
```

输入一个整型数组，数组中的一个或连续多个整数组成一个子数组。求所有子数组的和的最大值。

要求时间复杂度为O(n)。

**示例1:**

```
输入: nums = [-2,1,-3,4,-1,2,1,-5,4]
输出: 6
解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
```

**提示：**

+ 1 <= arr.length <= 10^5
+ -100 <= arr[i] <= 100

## 动态规划解法

凡是符合条件的子数组必定存在最后一个元素，并且最后这个元素肯定是所给的数组中的某一个元素。所以我们只需要知道以每个数组结尾的所有子数组中和最大的即可。

假设以第``i``个元素结尾的子数组中和最大的值为``f(i)``。则有``f(0)=nums[0]``。当``i>0``时，如果``f(i-1)>0``则``f(i)=f(i-1)+nums[i]``，而如果``f(i-1)<=0``，则``f(i)=nums[i]``。最后，我们从``f(0...n-1)``中选出最大的返回即可。据此可以写出时间复杂度为``O(n)``的动态规划实现：

```java
class Solution {
    public int maxSubArray(int[] nums) {
        if(nums.length==1){
            return nums[0];
        }

        int n = nums.length;
        int[] count = new int[n];
        count[0] = nums[0];
        int result = count[0];

        for(int i=1; i<n; i++){
            if(count[i-1]<0){
                count[i] = nums[i];
            }else{
                count[i] = count[i-1] + nums[i];
            }
            if(result<count[i]){
                result = count[i];
            }
        }

        return result;
    }
}
```

在 LeetCode 系统中提交的结果为：

```
执行结果：通过 显示详情
执行用时：1 ms, 在所有 Java 提交中击败了99.32%的用户
内存消耗：46.4 MB, 在所有 Java 提交中击败了58.18%的用户
```

## 分治解法

在《算法导论》中给出了一个时间复杂度同样为``O(n)``的分治解法。《算法导论》第4章 4.1节讲的最大子数组问题正文中给出了时间复杂度为``O(nlog(n))``的分治方法，在课后练习题4.1-5中又给出了线性复杂度的分治方法。其主要的思路是：对于一个数组的最大子数组，在这个最大子数组有多于两个元素的情况下，任意将这个最大子数组切分为前后两部分，这两部分各自的和必然是正的。这部分应该比较好理解，因为如果有一部分的和是负的或0，我们可以把这部分删掉，剩下的部分的和一定不小于原来的子数组。最大子数组的左右两部分的和都是正的，也就意味着左右两部分的和都要小于总的和。基于这个思路，可以写出如下代码

```java
class Solution {
    public int maxSubArray(int[] nums) {
        int tempLeft = 0;
        int tempRight = 0;
        int left = 0;
        int right = 0;
        int sum = nums[0];
        int maxSum = nums[0];

        for(int i=1; i<nums.length; i++){
            if(sum+nums[i]>nums[i]){
                sum = sum + nums[i];
                tempRight = i;
            }else{
                sum = nums[i];
                tempLeft = i;
            }

            if(maxSum<sum){
                maxSum = sum;
                left = tempLeft;
                right = tempRight;
            }
        }

        return maxSum;
    }
}
```

在LeetCode系统中提交的结果，这种方法的空间复杂度应该比前面的动态规划方法小吧，但是不知道为什么提交结果显示反而不如动态规划。

```
执行结果：通过
执行用时 : 1 ms, 在所有 Java 提交中击败了 97.36% 的用户
内存消耗 : 42.1 MB, 在所有 Java 提交中击败了 5.40% 的用户
```

# 43 1~n整数中1出现的次数

```
@date: 2020-09-13
@difficulty: medium
```

输入一个整数 n ，求1～n这n个整数的十进制表示中1出现的次数。

例如，输入12，1～12这些整数中包含1 的数字有1、10、11和12，1一共出现了5次。

**示例 1**

```
输入：n = 12
输出：5
```

**示例 2**

```
输入：n = 13
输出：6
```

**限制**

+ `1 <= n < 2^31`

## 暴力解法

这个题最容易想到的解法就是暴力求解，其实现如下所示

```java
class Solution {
    public int countDigitOne(int n) {
        if(n==0)
            return 0;
        int count = 0;
        for(int i=1; i<=n; i++){
            int temp = 0;
            int current = i;
            while(current>0){
                if(current%10==1){
                    temp++;
                }
                current /= 10;
            }
            count += temp;
        }

        return count;
    }
}
```

但是提交之后系统显示超出时间限制。

## 根据书中解法写的程序

《剑指offer》书中给出了一种从高位到低位的递归解法。具体的思路是每次删掉最高位。

用Java实现如下，但是在数据比较大的时候会出现不准的情况，可能是发生了溢出之类的事情。

```java
class Solution {
    public int countDigitOne(int n){
        if(n==0){
            return 0;
        }
        if(n<10){
            return 1;
        }

        int temp = 1;
        int m = 0;
        while(temp<=n){
            temp *= 10;
            m++;
        }

        //m--;
        int count = 0;
        temp /= 10;
        if(n/temp==1){
            count = n - temp + 1;
        }else{
            count = temp;
        }

        //System.out.println("n="+n+" temp="+temp);
        count = count + countDigitOne(n-temp*(n/temp)) + n/temp * countDigitOne(temp-1);
        return count;
    }
}
```

在输入 ``1410065408`` 时输出结果错误，感觉应该是程序里面的 ``temp`` 在计算时溢出了。

## 解决溢出问题

将``temp``改为``long``格式就可以避免这个溢出问题了。具体程序如下：

```java
class Solution {
    public int countDigitOne(int n){
        if(n==0){
            return 0;
        }
        if(n<10){
            return 1;
        }

        long n1 = (long) n;

        long temp0 = 1;
        int m = 0;
        while(temp0<=n1){
            temp0 *= 10;
            m++;
        }

        //m--;
        int count = 0;
        temp0 /= 10;
        int temp = (int) temp0;
        if(n/temp==1){
            count = n - temp + 1;
        }else{
            count = temp;
        }

        //System.out.println("n="+n+" temp="+temp);
        count = count + countDigitOne(n-temp*(n/temp)) + n/temp * countDigitOne(temp-1);
        return count;
    }

}
```

在 LeetCode 系统中提交的结果为

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：36.6 MB, 在所有 Java 提交中击败了17.00%的用户
```

# 44 数字序列中某一位的数字

数字以0123456789101112131415…的格式序列化到一个字符序列中。在这个序列中，第5位（从下标0开始计数）是5，第13位是1，第19位是4，等等。

请写一个函数，求任意第n位对应的数字。

**示例 1**

```
输入：n = 3
输出：3
```

**示例2**

```
输入：n = 11
输出：0
```

**限制**

+ $0\leq n < 2^{31}$

## 解法

我的基本思路是先算出第 n 位所属的数字有多少位，然后它是这个数字的第几位。

具体的实现有两点需要特别注意一下，一是要防止溢出，二是边界的处理要准确。

```java
class Solution {
    public int findNthDigit(int n) {
        if(n<=9){
            return n;
        }

        int length = 2;
        long start = 10;

        long tempCount = 90;
        long sum = 9 + tempCount * length;
        
        while(sum<=n){
            length++;
            start *= 10;
            tempCount *= 10;
            sum += (tempCount * length);
        }

        int last = (int)(n - (sum-tempCount*length));
        int index = last / length;

        if(last%length==0){
            int current = (int) (start + index - 1);
            return current % 10;
        }else{
            int current = (int)(start + index);
            int ptr = last % length;
            return (current / ((int) Math.pow(10, length-ptr))) % 10;
        }
    }
}
```

在LeetCode系统中提交的结果为

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：35.8 MB, 在所有 Java 提交中击败了16.27%的用户
```

# 45 把数组排成最小的数

```
@date: 2020-09-24
@difficulty: medium
```

输入一个非负整数数组，把数组里所有数字拼接起来排成一个数，打印能拼接出的所有数字中最小的一个。

**示例 1**

```
输入: [10,2]
输出: "102"
```

**示例2**

```
输入: [3,30,34,5,9]
输出: "3033459"
```

**提示**

+ `0 < nums.length <= 100`

**说明**

- 输出结果可能非常大，所以你需要返回一个字符串而不是整数
- 拼接起来的数字可能会有前导 0，最后结果不需要去掉前导 0

## 插入排序解法

可以用插入排序的思路来进行求解。对于某一个数，每步只考虑它与它前面那个数组合起来的结果，如果交换位置后两树组合结果比原来顺序的组合结果小，就交换位置。这样总的时间复杂度为$O(n^2)$

下面是具体的Java程序实现

```java
class Solution {
    public String minNumber(int[] nums) {
        int n = nums.length;
        if(n==1){
            return ""+nums[0];
        }

        int[] level = new int[n];
        for (int i = 0; i < n; i++) {
            level[i] = 1;
            int temp = 10;
            while(nums[i]>=temp){
                temp *= 10;
                level[i]++;
            }
        }

        for(int i=0; i<n-1; i++){
            for(int j=i+1; j>0; j--){
                double front = nums[j-1] * Math.pow(10, level[j]) + nums[j];
                double back = nums[j] * Math.pow(10, level[j-1]) + nums[j-1];
                if(back>=front){
                    break;
                }
                int temp1 = nums[j];
                nums[j] = nums[j-1];
                nums[j-1] = temp1;
                int temp2 = level[j];
                level[j] = level[j-1];
                level[j-1] = temp2;
            }
        }
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < n; i++) {
            builder.append(""+nums[i]);
        }

        return builder.toString();
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：10 ms, 在所有 Java 提交中击败了24.72%的用户
内存消耗：38.8 MB, 在所有 Java 提交中击败了19.70%的用户
```

这道题还有更优秀的$O(n\log n)$解法。

# 46 把数字翻译成字符串

给定一个数字，我们按照如下规则把它翻译为字符串：0 翻译成 “a” ，1 翻译成 “b”，……，11 翻译成 “l”，……，25 翻译成 “z”。一个数字可能有多个翻译。请编程实现一个函数，用来计算一个数字有多少种不同的翻译方法。

**示例1**

```
输入: 12258
输出: 5
解释: 12258有5种不同的翻译，分别是"bccfi", "bwfi", "bczi", "mcfi"和"mzi"
```

**提示**

+ $0\leq num < 2^{31}$

## 第一种解法

一种思路就是可以用动态规划的思路，前 $i$ 位的翻译方法取决于前 $i-1$ 位的翻译方法和前 $i-2$ 位的翻译方法。具体的Java程序实现如下所示

```java
class Solution {
    public int translateNum(int num) {

        if(num<10){
            return 1;
        }
        if(num<26){
            return 2;
        }

        String str = num+"";
        int n = str.length();
        char[] array = str.toCharArray();

        int[] count = new int[n];
        count[0] = 1;
        if(array[0]=='1' || array[0]=='2' && array[1]<'6'){
            count[1] = 2;
        }else{
            count[1] = 1;
        }

        for(int i=2; i<n; i++){
            if(array[i-1]=='1' || array[i-1]=='2' && array[i]<'6'){
                count[i] = count[i-1]+count[i-2];
            }else{
                count[i] = count[i-1];
            }
        }

        return count[n-1];
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：5 ms, 在所有 Java 提交中击败了9.45%的用户
内存消耗：35.8 MB, 在所有 Java 提交中击败了9.01%的用户
```





# 48 最长不含重复字符的子字符串

```
@date: 2020-09-07
@difficulty: medium
```

请从字符串中找出一个最长的不包含重复字符的子字符串，计算该最长子字符串的长度。

**示例 1**

```
输入: "abcabcbb"
输出: 3 
解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
```

**示例2**

```
输入: "bbbbb"
输出: 1
解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
```

**示例3**

```
输入: "pwwkew"
输出: 3
解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
     请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
```

**提示**

+ s.length <= 40000

## $O(n^2)$的算法

用 $f(i)$ 来表示以第 $i$ 的字符结尾的最长的无重复字符串的长度，则在计算 $f(i+1)$ 只需要从第 $i$ 个字符开始逐个往前比，最多比较 $f(i)$ 次。这种方法最坏的时间复杂复杂度为 $O(n^2)$。下面是具体的Java程序实现：

```java
class Solution {
    public int lengthOfLongestSubstring(String s) {
        if(s.length()<2){
            return s.length();
        }

        int n = s.length();
        char[] characters = s.toCharArray();
        int[] count = new int[n];
        count[0] = 1;
        for(int i=1; i<n; i++){
            count[i] = 1;
            for(int j=i-1; i-j<=count[i-1]; j--){
                if(characters[i]==characters[j]){
                    break;
                }
                count[i]++;
            }
        }

        int max = count[0];
        for(int i=1; i<n; i++){
            if(count[i]>max){
                max = count[i];
            }
        }

        return max;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：9 ms, 在所有 Java 提交中击败了41.57%的用户
内存消耗：39.6 MB, 在所有 Java 提交中击败了94.31%的用户
```

## HashMap+DP的做法

用HashMap+DP的做法，可以把时间复杂度降到 $O(n)$。具体的思路是，假设第 $i$ 个字符没有出现过，那么 $f(i)=f(i-1)+1$。如果第 $i$ 个字符出现过，那么我们如果知道它上一次出现的地方，假设它上次在第 $j$ 处出现，那么又可以分为两种情况：

+ 如果 $i-j>f(i-1)$， 那么有 $f(i)=f(i-1)+1$
+ 否则，$f(i)=i-j$

而每个字符上次出现的位置可以用 HashMap来记录和更新。下面是具体的Java程序实现

```java
import java.util.*;
class Solution {
    public int lengthOfLongestSubstring(String s) {
        if(s.length()<2){
            return s.length();
        }

        int n = s.length();
        HashMap<Character, Integer> map = new HashMap<>();
        char[] characters = s.toCharArray();
        int[] count = new int[n];
        count[0] = 1;
        map.put(characters[0], 0);
        for(int i=1; i<n; i++){
            if(map.containsKey(characters[i])){
                int last = map.get(characters[i]);
                if(i-last>count[i-1]){
                    count[i] = count[i-1]+1;
                }else{
                    count[i] = i-last;
                }    
            }else{
                count[i] = count[i-1]+1;
            }
            map.put(characters[i], i);
        }

        int max = count[0];
        for(int i=1; i<n; i++){
            if(count[i]>max){
                max = count[i];
            }
        }

        return max;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：8 ms, 在所有 Java 提交中击败了64.68%的用户
内存消耗：39.9 MB, 在所有 Java 提交中击败了50.86%的用户
```

其实，如果知道所有的字符均为26个英文字母的话，大可不必用HashMap，可以用一个数组代替之。

# 49 丑数

我们把只包含质因子 2、3 和 5 的数称作丑数（Ugly Number）。求按从小到大的顺序的第 n 个丑数。

**示例**

```
输入: n = 10
输出: 12
解释: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12 是前 10 个丑数。
```

**说明:** 

1. `1` 是丑数。
2. `n` **不超过**1690。

## HashMap实现的动态规划解法

这道题可以用动态规划来求解。如果一个数是丑数，那么它必然至少能被2，3，5中的1个整除，当然除了1之外。则target/2是丑数，target/3是丑数，target/5是丑数。

```java
class Solution {
    HashMap<Integer, Boolean> map = new HashMap<>();
    public int nthUglyNumber(int n) {
        if(n==1){
            return 1;
        }
        
        map.put(1, true);
        int count = 1;
        int current = 2;
        while(count<n){
            if(current%2==0){
                map.put(current, map.get(current/2));
            }else if(current%3==0){
                map.put(current, map.get(current/3));   
            }else if(current%5==0){
                map.put(current, map.get(current/5));
            }else{
                map.put(current, false);
            }
            if(map.get(current)){
                count++;
            }
            current++;
        }

        return --current;

    }

    
}
```

这里使用了HashMap来存储中间结果，但是提交之后显示超时。

## 用数组提高速度

将HashMap改为ArrayList可以在一定程度上提高运行速度，但是提交之后系统显示超出内存限制

```java
class Solution {  
    public int nthUglyNumber(int n) {
        if(n==1){
            return 1;
        }
        ArrayList<Integer> labels = new ArrayList<>();
        
        labels.add(0);
        labels.add(1);
        int count = 1;
        int current = 2;
        while(count<n){
            if(current%2==0){
                labels.add(labels.get(current/2));
            }else if(current%3==0){
                labels.add(labels.get(current/3));  
            }else if(current%5==0){
                labels.add(labels.get(current/5));
            }else{
                labels.add(0);
            }
            if(labels.get(current)==1){
                count++;
            }
            current++;
        }

        return --current;

    }

    
}
```

## 更快的动态规划方法

下面是一种更快的动态规划方法

```java
class Solution {
    public int nthUglyNumber(int n) {
        if(n==1){
            return 1;
        }

        int[] res = new int[n];
        res[0] = 1;
        int a = 0;
        int b = 0;
        int c = 0;

        for(int i=1; i<n; i++){
            int temp1 = res[a]*2;
            int temp2 = res[b]*3;
            int temp3 = res[c]*5;
            res[i] = Math.min(Math.min(temp1, temp2), temp3);

            //注意这三个 if 不能加 else ，因为temp1,temp2,temp3中可能会有相等的数
            if(res[i]==temp1){
                a++;
            }
            if(res[i]==temp2){
                b++;
            }
            if(res[i]==temp3){
                c++;
            }  
        }

        return res[n-1];
    }
}
```

提交结果为

```
执行用时：2 ms, 在所有 Java 提交中击败了99.26%的用户
内存消耗：37.8 MB, 在所有 Java 提交中击败了34.50%的用户
```





# 52 两个链表的第一个公共节点

```
@date: 2020-08-21
@difficulty: easy
```

输入两个链表，找出它们的第一个公共节点。

如下面的两个链表：

![](./images/52_1.png)

在节点 c1 开始相交。

**示例 1：**

![](./images/52_2.png)

```输入：intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
输出：Reference of the node with value = 8
输入解释：相交节点的值为 8 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [4,1,8,4,5]，链表 B 为 [5,0,1,8,4,5]。在 A 中，相交节点前有 2 个节点；在 B 中，相交节点前有 3 个节点。
```

**示例 2：**

![](./images/52_3.png)

```输入：intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
输出：Reference of the node with value = 2
输入解释：相交节点的值为 2 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [0,9,1,2,4]，链表 B 为 [3,2,4]。在 A 中，相交节点前有 3 个节点；在 B 中，相交节点前有 1 个节点。
```

**示例 3：**

![](./images/52_4.png)

```输入：intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
输出：null
输入解释：从各自的表头开始算起，链表 A 为 [2,6,4]，链表 B 为 [1,5]。由于这两个链表不相交，所以 intersectVal 必须为 0，而 skipA 和 skipB 可以是任意值。
解释：这两个链表不相交，因此返回 null。
```

**注意：**

+ 如果两个链表没有交点，返回 null.
+ 在返回结果后，两个链表仍须保持原有的结构。
+ 可假定整个链表结构中没有循环。
+ 程序尽量满足 O(n) 时间复杂度，且仅用 O(1) 内存。

## 用HashSet的解法

同时遍历两个链表，将遍历过的节点添加到HashSet中。这样时间复杂度是 ``O(n)``，空间复杂度也是 ``O(n)``，还打不到题目要求的``O(1)``。下面是具体的实现：

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
public class Solution {
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        if(headA==null || headB==null){
            return null;
        }
        HashSet<ListNode> set = new HashSet<>();
        ListNode ptr1 = headA;
        ListNode ptr2 = headB;
        while(ptr1!=null || ptr2!=null){
            if(ptr1!=null){
                if(!set.add(ptr1)){
                    return ptr1;
                }
                ptr1 = ptr1.next;
            }
            if(ptr2!=null){
                if(!set.add(ptr2)){
                    return ptr2;
                }
                ptr2 = ptr2.next;
            }
        }

        return null;

    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：11 ms, 在所有 Java 提交中击败了7.71%的用户
内存消耗：43.2 MB, 在所有 Java 提交中击败了5.41%的用户
```

空间和时间表现得都比较糟糕。

## 剑指offer给出的两种思路

+ 借助辅助栈。

  若两个链表具有公共节点，那么公共节点一定位于它们的尾部，所以可以使用栈来将顺序颠倒过来，然后逐个比较，直到最后一个相同的节点。这样时间复杂度与空间复杂度均为``O(n)``。

+ 空间复杂度为``O(1)``的方法

  先遍历两个链表，获得两个链表的长度，假设分别为n和m，并且n>m，则可以先遍历较长的链表n-m步，然后两个链表一起遍历。这样可以把空间复杂度也降至``O(1)``。

其实，本来这个问题就不太可能有时间复杂度优于``O(n)``的方法。



# 55 二叉树的深度

```
@author: sdubrz
@date:  8/9/2020 8:43:53 PM  
难度： 简单
考察内容： 二叉树
@e-mail: lwyz521604#163.com
题目来自《剑指offer》 电子工业出版社，图片来自LeetCode
```

输入一棵二叉树的根节点，求该树的深度。从根节点到叶节点依次经过的节点（含根、叶节点）形成树的一条路径，最长路径的长度为树的深度。

例如：

给定二叉树 [3,9,20,null,null,15,7]，

```
    3
   / \
  9  20
    /  \
   15   7
```

返回它的最大深度 3 。

**提示：**

+ 节点总数 <= 10000

## 广度优先搜索解法

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public int maxDepth(TreeNode root) {
        if(root==null){
            return 0;
        }

        int depth = 0;
        Queue<TreeNode> queue1 = new LinkedList<>();
        queue1.add(root);
        while(!queue1.isEmpty()){
            depth++;
            Queue<TreeNode> queue2 = new LinkedList<>();
            while(!queue1.isEmpty()){
                TreeNode temp = queue1.poll();
                if(temp.left!=null){
                    queue2.add(temp.left);
                }
                if(temp.right!=null){
                    queue2.add(temp.right);
                }
            }
            queue1 = queue2;
        }

        return depth;
    }
}
```

提交结果为

```
执行用时：1 ms, 在所有 Java 提交中击败了21.41%的用户
内存消耗：39.2 MB, 在所有 Java 提交中击败了98.38%的用户
```

# 50 第一个只出现一次的字符

在字符串 s 中找出第一个只出现一次的字符。如果没有，返回一个单空格。 s 只包含小写字母。

**示例:**

```
s = "abaccdeff"
返回 "b"

s = "" 
返回 " "
```

**限制：**

0 <= s 的长度 <= 50000

## 解法

首先可以肯定的是，这道题至少要完整地遍历一次字符串，所以时间复杂度至少是``O(n)``的。由于字符串中所有的字符都是小写的英文字母，所以我们可以用一个长为26的数组来存储每个字符出现的次数。具体实现如下

```java
class Solution {
    public char firstUniqChar(String s) {
        if(s.length()==0){
            return ' ';
        }

        int[] count = new int[26];
        char[] arr = s.toCharArray();
        for(int i=0; i<arr.length; i++){
            count[arr[i]-'a']++;
        }

        for(int i=0; i<arr.length; i++){
            if(count[arr[i]-'a']==1){
                return arr[i];
            }
        }

        return ' ';

    }
}
```

提交结果为

```
执行用时：4 ms, 在所有 Java 提交中击败了99.37%的用户
内存消耗：40.4 MB, 在所有 Java 提交中击败了41.13%的用户
```

# 51 数组中的逆序对

```
@date:2020-09-24
@difficulty: hard
```

在数组中的两个数字，如果前面一个数字大于后面的数字，则这两个数字组成一个逆序对。输入一个数组，求出这个数组中的逆序对的总数。

**示例1**

```
输入: [7,5,6,4]
输出: 5
```

**限制**

+ 0 <= 数组长度 <= 50000

## 暴力解法

最简单的暴力解法，时间复杂度为$O(n^2)$，但是在系统中提交显示超时。

```java
class Solution {
    public int reversePairs(int[] nums) {
        int n = nums.length;
        int count = 0;
        for(int i=0; i<n-1; i++){
            for(int j=i+1; j<n; j++){
                if(nums[i]>nums[j]){
                    count++;
                }
            }
        }
        return count;
    }
}
```

## 分治解法

用如下分治法，类似于快速排序中的分割，选择一个支点，根据每个元素与支点元素的大小关系分为3个部分。这样时间复杂度已经降到$O(n\log n)$了，但是空间复杂度较高，提交会显示超出内存要求。

```java
class Solution {
    public int reversePairs(int[] nums) {
        int n = nums.length;
        int count = reversePairs(nums, n);
        return count;
    }

    public int reversePairs(int[] nums, int n){
        if(n<=1){
            return 0;
        }
        if(n==2){
            if(nums[0]<=nums[1]){
                return 0;
            }else{
                return 1;
            }
        }

        int[] small = new int[n];
        int[] large = new int[n];
        int ptr1 = 0;
        int ptr2 = 0;
        int equal = 0;
        int count = 0;
        for(int i=0; i<n-1; i++){
            if(nums[i]<nums[n-1]){
                small[ptr1++] = nums[i];
                count += (ptr2+equal);
            }else if(nums[i]==nums[n-1]){
                equal++;
                count += ptr2;
            }else{
                large[ptr2++] = nums[i];
            }
        }
        count += ptr2;

        count = count + reversePairs(small, ptr1) + reversePairs(large, ptr2);
        return count;
    }
}
```

我在分治之前加了一个统计功能，以减小内存。但是提交显示，时间又超了：

```java
class Solution {
    public int reversePairs(int[] nums){
        int n = nums.length;
        if(n<=1){
            return 0;
        }
        if(n==2){
            if(nums[0]<=nums[1]){
                return 0;
            }else{
                return 1;
            }
        }

        // 增加一个遍历机制，减小部分内存
        int n1 = 0;
        int n2 = 0;
        for(int i=0; i<n-1; i++){
            if(nums[i]<nums[n-1]){
                n1++;
            }
            else if(nums[i]>nums[n-1]){
                n2++;
            }
        }

        int[] small = new int[n1];
        int[] large = new int[n2];
        int ptr1 = 0;
        int ptr2 = 0;
        int equal = 0;
        int count = 0;
        for(int i=0; i<n-1; i++){
            if(nums[i]<nums[n-1]){
                small[ptr1++] = nums[i];
                count += (ptr2+equal);
            }else if(nums[i]==nums[n-1]){
                equal++;
                count += ptr2;
            }else{
                large[ptr2++] = nums[i];
            }
        }
        count += ptr2;

        count = count + reversePairs(small) + reversePairs(large);
        return count;
    }
}
```

## 继续对分治进行优化

分治的归并过程不是原址的，需要借助额外的空间，为了避免再次出现内存超出限制的情况，我将额外的空间请求放在了递归之后，这样可以避免在递归栈中存在大量额外空间数组的情况，下面是具体的Java程序实现

```java
class Solution {
    public int reversePairs(int[] nums){
        int n = nums.length;
        if(n<=1){
            return 0;
        }
        if(n==2){
            if(nums[0]<=nums[1]){
                return 0;
            }else{
                return 1;
            }
        }
        return reversePairs(nums, 0, n-1);
        
    }

    public int reversePairs(int[] nums, int left, int right){
        if(left==right){
            return 0;
        }
        if(left+1==right){
            if(nums[left]<=nums[right]){
                return 0;
            }else{
                int temp = nums[left];
                nums[left] = nums[right];
                nums[right] = temp;
                return 1;
            }
        }

        int medium = (left+right)/2;
        int leftRes = reversePairs(nums, left, medium);
        int rightRes = reversePairs(nums, medium+1, right);
        int n1 = medium - left+1;
        int n2 = right - medium;
        int[] leftNums = new int[n1];
        int[] rightNums = new int[n2];
        for(int i=left; i<=medium; i++){
            leftNums[i-left] = nums[i];
        }
        for(int i=medium+1; i<=right; i++){
            rightNums[i-medium-1] = nums[i];
        }

        int count = 0;
        int ptr1 = 0;
        int ptr2 = 0;
        int ptr = left;
        while(ptr1<medium-left+1 && ptr2<right-medium){
            if(leftNums[ptr1]<=rightNums[ptr2]){
                nums[ptr++] = leftNums[ptr1++];
            }else{
                nums[ptr++] = rightNums[ptr2++];
                count = count + n1 - ptr1;
            }
        }
        if(ptr1<medium-left+1){
            while(ptr1<medium-left+1){
                nums[ptr++] = leftNums[ptr1++];
            }
        }
        if(ptr2<right-medium){
            while(ptr2<right-medium){
                nums[ptr++] = rightNums[ptr2++];  // 不用加了
            }
        }

        return count + leftRes + rightRes;

    }
}
```

这一次提交终于能够通过了

```
执行用时：46 ms, 在所有 Java 提交中击败了11.01%的用户
内存消耗：47.8 MB, 在所有 Java 提交中击败了66.37%的用户
```



# 53-I 在排序数组中查找数字 I

```
@date: 2020-08-26
```

统计一个数字在排序数组中出现的次数。

**示例 1:**

```
输入: nums = [5,7,7,8,8,10], target = 8
输出: 2
```

**示例 2:**

```
输入: nums = [5,7,7,8,8,10], target = 6
输出: 0
```



**限制：**

+ 0 <= 数组长度 <= 50000

## 二分解法

这道题应该就是用二分法来解了

```java
class Solution {
    public int search(int[] nums, int target) {
        if(nums.length==0){
            return 0;
        }
        return search(nums, target, 0, nums.length-1);
    }

    private int search(int[] nums, int target, int left, int right){
        if(right<left){
            return 0;
        }
        if(nums[left]>target){
            return 0;
        }
        if(nums[right]<target){
            return 0;
        }
        if(left==right){
            if(nums[left]==target)
                return 1;
            else
                return 0;
        }
        if(nums[left]==target && nums[right]==target){
            return right-left+1;
        }
        int mid = (left+right)/2;
        return search(nums, target, left, mid)+search(nums, target, mid+1, right);

    }
}
```

提交结果为

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：42.8 MB, 在所有 Java 提交中击败了32.61%的用户
```

# 53-II 0~n-1中缺失的数字

一个长度为n-1的递增排序数组中的所有数字都是唯一的，并且每个数字都在范围0～n-1之内。在范围0～n-1内的n个数字中有且只有一个数字不在该数组中，请找出这个数字。

**示例1**

```
输入: [0,1,3]
输出: 2
```

**示例2**

```
输入: [0,1,2,3,4,5,6,7,9]
输出: 8
```

**限制**

+ 1 <= 数组长度 <= 10000

## 解法

很明显，这道题也可以用二分法来解

```java
class Solution {
    public int missingNumber(int[] nums) {
        return missingNumber(nums, 0, nums.length);
    }

    private int missingNumber(int[] nums, int left, int right){
        if(left==right){
            return left;
        }

        if(nums[left]!=left){
            return left;
        }

        int mid = (left+right)/2;
        if(nums[mid]==mid){
            return missingNumber(nums, mid+1, right);
        }else{
            return missingNumber(nums, left, mid);
        }
    }
}
```

提交结果为

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：40.5 MB, 在所有 Java 提交中击败了35.33%的用户
```

# 54 二叉树的第k大的节点

```
@date: 2020-08-26
```

给定一棵二叉搜索树，请找出其中第k大的节点。

**示例 1**

```
输入: root = [3,1,4,null,2], k = 1
   3
  / \
 1   4
  \
   2
输出: 4
```

**示例 2**

```
输入: root = [5,3,6,2,4,null,null,1], k = 3
       5
      / \
     3   6
    / \
   2   4
  /
 1
输出: 4
```

**限制**

1 ≤ k ≤ 二叉搜索树元素个数

## 中序遍历解法

这道题最容易想到的就是用中序遍历遍历整颗树，然后取倒数第k个即可。这样需要遍历整颗树，不是最优的方法。下面是Java代码实现

```java 
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public int kthLargest(TreeNode root, int k) {
        
        Stack<Integer> stack = new Stack<>();
        midFind(stack, root);
        for(int i=k; i>1; i--){
            stack.pop();
        }
        return stack.pop();
    }

    private void midFind(Stack<Integer> stack, TreeNode root){
        if(root==null){
            return;
        }
        if(root.left!=null){
            midFind(stack, root.left);
        }
        stack.push(root.val);
        if(root.right!=null){
            midFind(stack, root.right);
        }
    }
}
```

提交结果为

```
执行用时：2 ms, 在所有 Java 提交中击败了10.59%的用户
内存消耗：40.4 MB, 在所有 Java 提交中击败了6.46%的用户
```

## 中序遍历的倒序

把中序遍历的过程倒过来，这样可以不必完成一遍完整的遍历。速度会有所提升，当然，如果用渐进记法的话，时间复杂度仍然是``O(n)``的。下面是具体的程序实现

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    int count;
    int result;
    public int kthLargest(TreeNode root, int k) {
        count = k;
        midFind(root);
        return result;
    }

    private void midFind(TreeNode root){
        if(root==null){
            return;
        }
        midFind(root.right);
        if(count==0){
            return;
        }
        count--;
        if(count==0){
            result = root.val;
            return;
        }
        midFind(root.left);
        
    }
}
```

提交结果为

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：39.5 MB, 在所有 Java 提交中击败了64.80%的用户
```

# 55-II 平衡二叉树

```
@date: 2020-08-25
```

输入一棵二叉树的根节点，判断该树是不是平衡二叉树。如果某二叉树中任意节点的左右子树的深度相差不超过1，那么它就是一棵平衡二叉树。

**示例 1:**

给定二叉树`` [3,9,20,null,null,15,7]``

        3
       / \
      9  20
        /  \
       15   7

返回 true 。

**示例 2:**

给定二叉树 ``[1,2,2,3,3,null,null,4,4]``

           1
          / \
         2   2
        / \
       3   3
      / \
     4   4

返回 false 。

**限制：**

+ 1 <= 树的结点个数 <= 10000

## 递归解法

一时间没有想到更好的解法，所以用递归先写了一下，结果有点意外，感觉应该有更好的方法吧。

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public boolean isBalanced(TreeNode root) {
        if(root==null){
            return true;
        }

        int left = depth(root.left);
        int right = depth(root.right);
        if(Math.abs(left-right)>1){
            return false;
        }

        return isBalanced(root.left) && isBalanced(root.right);
        
    }

    public int depth(TreeNode root){
        if(root==null){
            return 0;
        }

        int left = depth(root.left);
        int right = depth(root.right);
        
        return Math.max(left, right)+1;
    }
}
```

提交结果为

```
执行用时：1 ms, 在所有 Java 提交中击败了99.94%的用户
内存消耗：39.9 MB, 在所有 Java 提交中击败了39.95%的用户
```

## 后序遍历加剪枝

在评论区有人用了后序遍历加剪枝的方式来实现，使得算法的时间复杂度降到了``O(n)``，下面是具体的Java程序实现

```
class Solution {
    public boolean isBalanced(TreeNode root) {
        return recur(root) != -1;
    }

    private int recur(TreeNode root) {
        if (root == null) return 0;
        int left = recur(root.left);
        if(left == -1) return -1;
        int right = recur(root.right);
        if(right == -1) return -1;
        return Math.abs(left - right) < 2 ? Math.max(left, right) + 1 : -1;
    }
}

作者：jyd
链接：https://leetcode-cn.com/problems/ping-heng-er-cha-shu-lcof/solution/mian-shi-ti-55-ii-ping-heng-er-cha-shu-cong-di-zhi/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
```

# 56-I 数组中数字出现的次数

```
@date: 2020-08-26
```

一个整型数组 `nums` 里除两个数字之外，其他数字都出现了两次。请写程序找出这两个只出现一次的数字。要求时间复杂度是O(n)，空间复杂度是O(1)。

**示例 1**

```
输入：nums = [4,1,4,6]
输出：[1,6] 或 [6,1]
```

**示例 2**

```
输入：nums = [1,2,10,4,1,4,3,3]
输出：[2,10] 或 [10,2]
```

**限制**

+ 2 <= nums.length <= 10000

## 解法

这道题我没有想出符合题目要求复杂度的解法。后来看了官方的解法，是利用的位操作，利用的是两个相同的数的异或为0。具体的解法如下所示

```java
class Solution {
    public int[] singleNumbers(int[] nums) {
        int[] result = new int[2];
        int n = nums.length;

        int temp = nums[0];
        for(int i=1; i<n; i++){
            temp = temp^nums[i];
        }
        int ptr = 0;
        while((temp & 1) == 0){
            temp = temp>>1;
            ptr++;
        }
        
        result[0] = nums[0];
        //boolean first = true;
        for(int i=1; i<n; i++){
            int current = nums[0]^nums[i];
            for(int j=0; j<ptr; j++){
                current = current>>1;
            }
            if((current&1)==0){
                result[0] = result[0]^nums[i];
            }else{    
                result[1] = result[1]^nums[i];
                
            }
        }

        return result;
    }
}
```

提交的结果为

```
执行用时：3 ms, 在所有 Java 提交中击败了23.42%的用户
内存消耗：41.6 MB, 在所有 Java 提交中击败了18.97%的用户
```

# 56-II 数组中数字出现的次数II

```
@date: 2020-09-28
@difficulty: medium
```

在一个数组 `nums` 中除一个数字只出现一次之外，其他数字都出现了三次。请找出那个只出现一次的数字。

**示例1**

```
输入：nums = [3,4,3,3]
输出：4
```

**示例2**

```
输入：nums = [9,1,7,9,7,9,7]
输出：1
```

**限制**

- `1 <= nums.length <= 10000`
- `1 <= nums[i] < 2^31`

## 暴力解法

暴力解法代码实现如下

```java
class Solution {
    public int singleNumber(int[] nums) {
        HashMap<Integer, Boolean> map = new HashMap<>();
        for(int i=0; i<nums.length; i++){
            if(map.containsKey(nums[i])){
                map.put(nums[i], false);
            }else{
                map.put(nums[i], true);
            }
        }

        Set<Integer> set = map.keySet();
        Iterator<Integer> iter = set.iterator();
        while(iter.hasNext()){
            int x = iter.next();
            if(map.get(x)){
                return x;
            }
        }
        return -1;
    }
}
```

在LeetCode系统中提交的结果为

```
执行用时：16 ms, 在所有 Java 提交中击败了40.30%的用户
内存消耗：40.2 MB, 在所有 Java 提交中击败了10.69%的用户
```

## 剑指offer书中的解法

《剑指offer》书中给出了一种用二进制位的解法。由于除了要寻找的数之外，其他的数都出现了三次，因而，他们每一位上值为1的个数也必然可被3整除。对3取余即可找出要寻找的数。书中的解法相比于HashMap的解法，最大的优势是节省了大量的空间。

# 57 和为s的两个数字

```
@date: 2020-08-28
```

输入一个递增排序的数组和一个数字s，在数组中查找两个数，使得它们的和正好是s。如果有多对数字的和等于s，则输出任意一对即可。

**示例 1**

```
输入：nums = [2,7,11,15], target = 9
输出：[2,7] 或者 [7,2]
```

**示例 2**

```
输入：nums = [10,26,30,31,47,60], target = 40
输出：[10,30] 或者 [30,10]
```

**限制**

- `1 <= nums.length <= 10^5`
- `1 <= nums[i] <= 10^6`

## 解法

可以用前后两个指针的方法来做。保持``left``和``right``两个指针。如果 ``nums[left]+nums[right]>target`` 就让 ``right--`` ，如果小于 ``target`` 就让 ``left++``。下面是Java程序的实现

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        int[] result = new int[2];
        int left = 0;
        int right = nums.length-1;
        while(left<right){
            int temp = nums[left] + nums[right];
            if(temp==target){
                result[0] = nums[left];
                result[1] = nums[right];
                break;
            }else if(temp>target){
                right--;
            }else{
                left++;
            }
        }

        return result;
    }
}
```

提交结果为

```
执行用时：2 ms, 在所有 Java 提交中击败了98.49%的用户
内存消耗：57.3 MB, 在所有 Java 提交中击败了17.44%的用户
```

从这道题给的限制条件中看到数组可能只含有一个元素，这种情况是没有意义的。我没有想好应该怎么处理，所以就没有处理，从提交结果看也没有这种测试数据。应该是一个纰漏。

另外，这道题的指针移动或许可以用二分法来加速，但是编码会稍微复杂一些。

# 58-I 翻转单词顺序

```
@date: 2020-09-11
@difficulty: easy
```

输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。为简单起见，标点符号和普通字母一样处理。例如输入字符串"I am a student. "，则输出"student. a am I"。

**示例1：**

```
输入: "the sky is blue"
输出: "blue is sky the"
```

**示例2：**

```
输入: "  hello world!  "
输出: "world! hello"
解释: 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
```

**示例3：**

```
输入: "a good   example"
输出: "example good a"
解释: 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。
```

**说明：**

+ 无空格字符构成一个单词。
+ 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
+ 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。

## 解法

这道题要注意一些边界情况的处理

```java
class Solution {
    public String reverseWords(String s) {
        int n = s.length();
        if(n==0){
            return "";
        }
        char[] arrays = s.toCharArray();
        int left = 0;
        while(left<n && arrays[left]==' '){
            left++;
        }

        if(left==n){
            return "";
        }

        //System.out.println("hhh");

        Stack<String> stack = new Stack<>();
        String str = ""+arrays[left];
        // System.out.println(str);
        if(left==n-1){
            return ""+arrays[left];
        }

        for(int i=left+1; i<n; i++){
            if(i==n-1){
                if(arrays[i]!=' '){
                    str = str + arrays[i];
                }
                stack.push(str);
                // System.out.println(str);
                break;
            }
            if(arrays[i]==' '){
                stack.push(str);
                left = i;
                while(left<n && arrays[left]==' ')
                    left++;
                if(left==n)
                    break;
                str = ""+arrays[left];
                i = left;
            }else{
                str = str + arrays[i];
            }
        }

        StringBuilder builder = new StringBuilder();
        while(stack.size()>1){
            builder.append(stack.pop());
            builder.append(" ");
        }
        if(stack.size()>0)
            builder.append(stack.pop());

        return builder.toString();
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：24 ms, 在所有 Java 提交中击败了5.79%的用户
内存消耗：40.2 MB, 在所有 Java 提交中击败了12.11%的用户
```

# 58-II 左旋转字符串

```
@date: 2020-09-11
@difficulty: easy
```

字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。请定义一个函数实现字符串左旋转操作的功能。比如，输入字符串"abcdefg"和数字2，该函数将返回左旋转两位得到的结果"cdefgab"。

 **示例 1**

```
输入: s = "abcdefg", k = 2
输出: "cdefgab"
```

**示例 2**

```
输入: s = "lrloseumgh", k = 6
输出: "umghlrlose"
```

**限制**

+ 1 <= k < s.length <= 10000

## 解法

```java
class Solution {
    public String reverseLeftWords(String s, int n) {
        int m = s.length();
        if(n>=m){
            return s;
        }

        return s.substring(n, m)+s.substring(0, n);
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：40 MB, 在所有 Java 提交中击败了29.13%的用户
```

# 60 n个骰子的点数

把n个骰子扔在地上，所有骰子朝上一面的点数之和为s。输入n，打印出s的所有可能的值出现的概率。

你需要用一个浮点数数组返回答案，其中第 i 个元素代表这 n 个骰子所能掷出的点数集合中第 i 小的那个的概率。

**示例1：**

```
输入: 1
输出: [0.16667,0.16667,0.16667,0.16667,0.16667,0.16667]
```

**示例2：**

```
输入: 2
输出: [0.02778,0.05556,0.08333,0.11111,0.13889,0.16667,0.13889,0.11111,0.08333,0.05556,0.02778]
```

**限制**

+ 1 <= n <= 11

## 解法

投掷n个骰子，总共会有 $ 6^n$ 种可能的排列，而点数只可能是 n 到 6n 之间的整数。因而可以计算出每个整数对应着多少种排列，然后除以$6^n$ 即可。因而，问题的关键就变成了给定一个整数 $x$ 有多少种排列的和为 $x$。我们可以用公式 $f(i, x)$ 来记录投掷 $i$ 个骰子时，和为 $x$ 的排列数。则，根据第 $i$ 个骰子的数值，可以有
$$
f(i, x)=f(i-1, x-1)+f(i-1, x-2)+f(i-1, x-3)+f(i-1, x-4)+f(i-1, x-5)+f(i-1, x-6)
$$
而当$i$为1时，$f(i, x)=1$。

由此，完整的Java程序解法如下所示，要注意边界的处理。

```java
class Solution {
    public double[] twoSum(int n) {
        double[] res = new double[n*5+1];
        int[][] count = new int[n+1][6*n+1];

        for(int i=1; i<=6; i++){
            count[1][i] = 1;
        }

        for(int i=2; i<=n; i++){
            for(int j=i; j<=i*6; j++){
                for(int k=1; k<=6; k++){
                    if(j-k>=i-1){
                        count[i][j] += count[i-1][j-k];
                    }
                }
            }
        }

        double base = Math.pow(6, n);
        for(int i=n; i<=6*n; i++){
            res[i-n] = count[n][i]/base;
        }

        return res;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：37 MB, 在所有 Java 提交中击败了32.99%的用户
```

# 61 扑克牌中的顺子

从扑克牌中随机抽5张牌，判断是不是一个顺子，即这5张牌是不是连续的。2～10为数字本身，A为1，J为11，Q为12，K为13，而大、小王为 0 ，可以看成任意数字。A 不能视为 14。

**示例1**

```
输入: [1,2,3,4,5]
输出: True
```

**示例2**

```
输入: [0,0,1,2,5]
输出: True
```

**限制**

数组长度为 5 

数组的数取值为 [0, 13] .

## 解法

这道题没什么特殊的解法，先统计一下0的个数，然后判断即可。

```java
class Solution {
    public boolean isStraight(int[] nums) {
        for(int i=0; i<4; i++){
            for(int j=i+1; j>0; j--){
                if(nums[j]<nums[j-1]){
                    int temp = nums[j];
                    nums[j] = nums[j-1];
                    nums[j-1] = temp;
                }
            }
        }

        int count = 0;

        for(int i=0; i<5; i++){
            if(nums[i]==0){
                count++;
            }else{
                break;
            }
        }

        for(int i=count; i<4; i++){
            if(nums[i]==nums[i+1]){
                return false;
            }
            count = count - (nums[i+1]-nums[i]-1);
        }

        if(count>=0){
            return true;
        }else{
            return false;
        }

    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：1 ms, 在所有 Java 提交中击败了91.27%的用户
内存消耗：36.6 MB, 在所有 Java 提交中击败了13.43%的用户
```



# 63 股票的最大利润

假设把某股票的价格按照时间先后顺序存储在数组中，请问买卖该股票一次可能获得的最大利润是多少？

**示例 1:**

```
输入: [7,1,5,3,6,4]
输出: 5
解释: 在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
     注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格。
```

**示例 2:**

```
输入: [7,6,4,3,1]
输出: 0
解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
```

**限制：**

+ 0 <= 数组长度 <= 10^5

## 动态规划解法

这个问题是一个经典的动态规划例题。无论是用DP还是用分治，一般都是先把数组转化为当天价格相对于前一天的变化值。当用DP时，计算某一天出手能获得的最大利润，最后遍历数组找出获利最大的那一天的利润。总的来说，DP解法时间复杂度是$O(n)$的，下面是Java程序实现。

```java
class Solution {
    public int maxProfit(int[] prices) {
        int n = prices.length;
        if(n<=1){
            return 0;
        }

        boolean good = false;
        int[] income = new int[n]; // 今天相比昨天的价格变化
        for(int i=1; i<n; i++){
            int temp = prices[i] - prices[i-1];
            income[i] = temp;
            if(temp>0){
                good = true;
            }
        }

        if(!good){
            return 0;
        }

        int[] count = new int[n];  // 该天卖出股票能获得的最大收益
        for(int i=1; i<n; i++){
            if(count[i-1]<=0){
                count[i] = income[i];
            }else{
                count[i] = count[i-1] + income[i];
            }
        }

        int res = count[0];
        for(int i=1; i<n; i++){
            if(count[i]>res){
                res = count[i];
            }
        }

        if(res<0){
            return 0;
        }else{
            return res;
        }
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：2 ms, 在所有 Java 提交中击败了71.14%的用户
内存消耗：38.9 MB, 在所有 Java 提交中击败了29.97%的用户
```

## 问题扩展——允许买卖多次，且每次卖出需要支付手续费

前几天在面试一家公司时，面试官出了一道这道题的升级版。允许多次买入和卖出股票，且每次卖出需要支付一笔手续费，求最大的收益。

**示例**

```
输入：prices=[1, 3, 2, 8, 4, 9]  fee=2
输出：8
解释：1的时候买入，8的时候卖出，扣除手续费，收益5
     4的时候买入，9的时候卖出，扣除手续费，收益3
     所以总收益为8
```

拿到这道题的时候，第一反应是可以用动态规划解法，但是一时间并没有想出用什么子问题合适。由于面试官只给出了20分钟的时间，并且要求将代码写在纸上，所以在想了2分钟之后，就打算直接用暴力解法。但是，在写完暴力解法之后，可以很清楚地看到算法中存在重复计算一些子问题的情况，因而在最后增加了一个记忆数组。原来效率十分底下的暴力解法就变成了自顶向下的动态规划解法。具体思路如下

如果我们用 $f(i, j)$ 来表示第 $i$ 天到第 $j$ 天的最大收益，那么我们最终要计算的就是 $f(0, n)$ 的值。对于给定的一个 $i$ ，根据第 $i$ 天是否买入股票，可以分为两种情况：

+ 如果第 $i$ 天买入股票，后面必定要卖出股票，假设是在第 $k$ 天卖出股票，那么 $f(i, n)=f(i, k)+f(k+1, n)$。
+ 如果第 $i$ 天不买入股票，那么 $f(i, n)=f(i+1, n)$。

$f(i, n)$取以上两种情况的较大者。特别的，如果 $i \geq n$， 那么$f(i, n)=0$。

由此，可以写出以下Java程序，其中记忆数组``array``中的元素存贮的是只考虑从该天到第n天时的最大收益。

```java
public class HUAWEI {

    public static int[] array;  // 记忆数组

    public static void main(String[] args) {
        int[] nums = {1, 3, 2, 8, 4, 9};
        int fee = 2;
        HUAWEI obj = new HUAWEI();
        System.out.println(obj.Money(nums, fee));
    }

    public int Money(int[] nums, int fee){
        int n = nums.length;
        if(n<=1){
            return 0;
        }

        int[][] count = new int[n][n];
        array = new int[n];
        for(int i=0; i<n; i++){
            array[i] = -1;
        }

        for(int i=0; i<n; i++){
            for(int j=i+1; j<n; j++){
                count[i][j] = nums[j]-nums[i]-fee;
            }
        }

        return selectMax(count, 0);

    }

    public int selectMax(int[][] count, int start){
        int n = count.length;
        if(start==n-2){
            return Math.max(0, count[n-2][n-1]);
        }
        if(start>n-2){
            return 0;
        }
        if(array[start]!=-1){  // 表示已经计算过了
            return array[start];
        }

        int max = 0;
        for(int i=start+1; i<n; i++){
            int temp = count[start][i] + selectMax(count, i+1);
            if(temp>max){
                max = temp;
            }
        }

        array[start] = max;
        return max;
    }
}
```



# 64 求 1+2+...+n

求 1+2+...+n ，要求不能使用乘除法、for、while、if、else、switch、case等关键字及条件判断语句（A?B:C）。

**示例 1：**

```
输入: n = 3
输出: 6
```

**示例 2：**

```
输入: n = 9
输出: 45
```

**限制：**

+ 1 <= n <= 10000

## 乘方解法

不能用乘除法和循环，所以我直接用了乘方，来计算 n*n+n。但是还需要一个除以2的操作，直接使用了右移一位的方法。下面是Java语言实现。

```Java
class Solution {
    public int sumNums(int n) {
        int temp = (int)Math.pow(n, 2)+n;
        return temp>>1;

    }
}
```

提交结果为

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：36.6 MB, 在所有 Java 提交中击败了82.52%的用户
```

# 65 不用加减乘除做加法

写一个函数，求两个整数之和，要求在函数体内不得使用 “+”、“-”、“*”、“/” 四则运算符号。

**示例**

```
输入: a = 1, b = 1
输出: 2
```

**提示**

- `a`, `b` 均可能是负数或 0
- 结果不会溢出 32 位整数

## 直接调用加法

这道题应该是要借鉴我们在计组中学的加法器的。但是出于好奇，还是直接用Java自己的加法来看下是什么效果。

```java
class Solution {
    public int add(int a, int b) {
        return a+b;
    }
}
```

在LeetCode系统中提交的结果为

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：35.5 MB, 在所有 Java 提交中击败了68.06%的用户
```

空间上竟然不是最优的，还是有点意外。

# 66 构建乘积数组

```
@date: 2020-09-30
@difficulty: medium
```

给定一个数组 A[0,1,…,n-1]，请构建一个数组 B[0,1,…,n-1]，其中 B 中的元素 B[i]=A[0]×A[1]×…×A[i-1]×A[i+1]×…×A[n-1]。不能使用除法。

**示例**

```
输入: [1,2,3,4,5]
输出: [120,60,40,30,24]
```

**提示**

- 所有元素乘积之和不会溢出 32 位整数
- `a.length <= 100000`

## $O(n^2)$的解法

如果能允许使用除法，那么可以很容易地写出时间复杂度为$O(n)$的方法。在不允许使用除法的情况下，首先能够想到的是最简单的时间复杂度为$O(n^2)$的方法，其实现如下所示

```java
class Solution {
    public int[] constructArr(int[] a) {
        int n = a.length;
        int[] b = new int[n];
        for(int i=0; i<n; i++){
            b[i] = 1;
            for(int j=0; j<n; j++){
                if(i==j){
                    continue;
                }
                b[i] *= a[j];
            }
        }
        return b;
    }
}
```

但是在系统中提交结果显示超时。

## 记录中间结果

用下面的矩阵可以减少一部分时间开销，需要申请大小为$O(n^2)$的记录数组，并且，因为需要填充这个数组的一半空间，所以时间复杂度仍然是$O(n^2)$的。在系统中提交之后，结果也不太好，显示超出内存限制。

```java
class Solution {
    int[][] computered;
    int[][] count;
    int n;

    public int[] constructArr(int[] a) {
        n = a.length;
        int[] b = new int[n];
        computered = new int[n][n];
        count = new int[n][n];

        for(int i=0; i<n; i++){
            count[i][i] = a[i];
            computered[i][i] = 1;
        }

        for(int i=0; i<n; i++){
            b[i] = region(0, i-1) * region(i+1, n-1); 
        }
        return b;
    }

    private int region(int left, int right){
        if(right<left){
            return 1;
        }

        if(computered[left][right]==1){
            return count[left][right];
        }

        int m = (left+right)/2;
        count[left][right] = region(left, m) * region(m+1, right);
        computered[left][right] = 1;
        return count[left][right];
    }
}
```





# 67 把字符串转换成整数

```
@date: 2020-09-27
@difficulty: medium
```

写一个函数 StrToInt，实现把字符串转换成整数这个功能。不能使用 atoi 或者其他类似的库函数。

 

首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。

当我们寻找到的第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字组合起来，作为该整数的正负号；假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成整数。

该字符串除了有效的整数部分之后也可能会存在多余的字符，这些字符可以被忽略，它们对于函数不应该造成影响。

注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换。

在任何情况下，若函数不能进行有效的转换时，请返回 0。

**说明：**

假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为$ [−2^{31},  2^{31} − 1]$。如果数值超过这个范围，请返回 INT_MAX ($2^{31} − 1$) 或 INT_MIN ($−2^{31}$) 。

**示例1**

```
输入: "42"
输出: 42
```

**示例2**

```
输入: "   -42"
输出: -42
解释: 第一个非空白字符为 '-', 它是一个负号。
     我们尽可能将负号与后面所有连续出现的数字组合起来，最后得到 -42 。
```

**示例3**

```
输入: "4193 with words"
输出: 4193
解释: 转换截止于数字 '3' ，因为它的下一个字符不为数字。
```

**示例4**

```
输入: "words and 987"
输出: 0
解释: 第一个非空字符是 'w', 但它不是数字或正、负号。
     因此无法执行有效的转换。
```

**示例5**

```
输入: "-91283472332"
输出: -2147483648
解释: 数字 "-91283472332" 超过 32 位有符号整数范围。 
     因此返回 INT_MIN (−2^31) 。
```

## 解法

平平无奇的解法

```java
class Solution {
    public int strToInt(String str){
        int MAX = 214748364;
        int n = str.length();
        if(n==0){
            return 0;
        }

        char[] array = str.toCharArray();
        int ptr = 0;
        while(ptr<n && array[ptr]==' '){
            ptr++;
        }

        if(ptr==n){
            return 0;
        }

        if(array[ptr]=='+' || array[ptr]=='-'){
            if(ptr+1==n){
                return 0;
            }

            int res = 0;
            int i = ptr+1;
            while(i<n && isNumber(array[i])){
                if(res>MAX){
                    if(array[ptr]=='+')
                        return Integer.MAX_VALUE;
                    else
                        return Integer.MIN_VALUE;
                }
                if(res==MAX){
                    if(array[ptr]=='+' && array[i]-'0'>=7)
                        return Integer.MAX_VALUE;
                    if(array[ptr]=='-' && array[i]-'0'>=8)
                        return Integer.MIN_VALUE;
                }

                res *= 10;
                res += (array[i]-'0');
                i++;
            }

            if(array[ptr]=='-'){
                res *= -1;
            }

            return res;
        }

        if(isNumber(array[ptr])){
            int i = ptr;
            int res = 0;
            while(i<n && isNumber(array[i])){
                if(res>MAX){
                    return Integer.MAX_VALUE;
                }
                if(res==MAX && array[i]-'0'>7){
                    return Integer.MAX_VALUE;
                }
                res *= 10;
                res += (array[i]-'0');
                i++;
            }
            return res;
        }

        return 0;
    }

    public boolean isNumber(char c){
        return c-'0'<=9 && c-'0'>=0;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：3 ms, 在所有 Java 提交中击败了32.04%的用户
内存消耗：39 MB, 在所有 Java 提交中击败了18.76%的用户
```



# 68-I 二叉搜索树的最近公共祖先

```
@date: 2020-08-21
@difficulty: easy
```

给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。

百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（**一个节点也可以是它自己的祖先**）。”

例如，给定如下二叉搜索树:  root = [6,2,8,0,4,7,9,null,null,3,5]

![](.\images\68.png)

 

**示例 1:**

```
输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
输出: 6 
解释: 节点 2 和节点 8 的最近公共祖先是 6。
```

**示例 2:**

```
输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
输出: 2
解释: 节点 2 和节点 4 的最近公共祖先是 2, 因为根据定义最近公共祖先节点可以为节点本身。
```

**说明:**

+ 所有节点的值都是唯一的。
+ p、q 为不同节点且均存在于给定的二叉搜索树中。

## 解法

从根节点搜索两个节点，到分叉处的地方就是最近公共祖先了。

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        
        TreeNode current = root;
        TreeNode ptr1 = current;
        TreeNode ptr2 = current;
        while(ptr1.val==ptr2.val){
            current = ptr1;
            if(current.val==p.val || current.val==q.val){
                return current;
            }
            if(p.val>current.val){
                ptr1 = current.right;
            }else{
                ptr1 = current.left;
            }

            if(q.val>current.val){
                ptr2 = current.right;
            }else{
                ptr2 = current.left;
            }
        }
        return current;
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行用时：6 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：41.3 MB, 在所有 Java 提交中击败了17.80%的用户
```

# 68-I 二叉树的最近公共祖先

给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。

百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

例如，给定如下二叉树:  root = [3,5,1,6,2,0,8,null,null,7,4]

![](./images/68_II.png) 

**示例 1:**

```
输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
输出: 3
解释: 节点 5 和节点 1 的最近公共祖先是节点 3。
```

**示例 2:**

```输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
输出: 5
解释: 节点 5 和节点 4 的最近公共祖先是节点 5。因为根据定义最近公共祖先节点可以为节点本身。
```

**说明:**

+ 所有节点的值都是唯一的。
+ p、q 为不同节点且均存在于给定的二叉树中。

## 第一种解法

第一种方法是获得从根节点到两个目标节点的路径，然后得到两者最后一个共同的节点。实现如下，但是提交结果系统显示超时

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        List<TreeNode> list1 = findPath(root, p);
        List<TreeNode> list2 = findPath(root, q);

        Iterator<TreeNode> iter1 = list1.iterator();
        Iterator<TreeNode> iter2 = list2.iterator();
       
        TreeNode last = root;

        while(iter1.hasNext() && iter2.hasNext()){
            TreeNode ptr1 = iter1.next();
            TreeNode ptr2 = iter2.next();
            if(ptr1.val==ptr2.val){
                last = ptr1;
            }else{
                break;
            }
        }

        return last;
    }

    // 寻找从根节点到节点p之间的路径
    public List<TreeNode> findPath(TreeNode root, TreeNode p){
        List<TreeNode> list = new LinkedList<>();
        if(root==null){
            return list;
        }
        if(root.val==p.val){
            list.add(root);
            return list;
        }

        if(root.left!=null){
            List<TreeNode> list1 = findPath(root.left, p);
            if(!list1.isEmpty()){
                list.add(root);
                list.addAll(list1);
            }
            //return list;
        }

        if(root.right!=null){
            List<TreeNode> list2 = findPath(root.right, p);
            if(!list2.isEmpty()){
                list.add(root);
                list.addAll(list2);
            }
            //return list;
        }

        return list;
    }
}
```

## 第二种解法 用HashMap记录路径

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        HashMap<TreeNode, Boolean> map1 = new HashMap<>();
        HashMap<TreeNode, Boolean> map2 = new HashMap<>();

        this.findNode(map1, root, p);
        this.findNode(map2, root, q);

        TreeNode current = root;
        while(current!=null){
            if(current.left!=null){
                if(map1.get(current.left)!=null && map2.get(current.left)!=null
                && map1.get(current.left) && map2.get(current.left)){
                    current = current.left;
                    continue;
                }
            }
            
            if(current.right!=null){
                if(map1.get(current.right)!=null && map2.get(current.right)!=null
                && map1.get(current.right) && map2.get(current.right)){
                    current = current.right;
                    continue;
                }
            }

            break;
        }

        return current;

    }

    //public boolean findNode()
    public boolean findNode(HashMap<TreeNode, Boolean> map, TreeNode root, TreeNode p){      
        if(root==p){
            map.put(root, true);
            return true;
        }
        if(root.left!=null){
            if(findNode(map, root.left, p)){
                map.put(root, true);
                return true;
            }
        }
        if(root.right!=null){
            if(findNode(map, root.right, p)){
                map.put(root, true);
                return true;
            }
        }

        return false;
    }

}
```

提交结果为

```
执行用时：16 ms, 在所有 Java 提交中击败了5.43%的用户
内存消耗：42.2 MB, 在所有 Java 提交中击败了7.23%的用户
```

## 网友的解法

下面是一个网友给出的代码实现

```java
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if(root == null || root == p || root == q) return root;
        TreeNode left = lowestCommonAncestor(root.left, p, q);
        TreeNode right = lowestCommonAncestor(root.right, p, q);
        if(left == null && right == null) return null; // 1.
        if(left == null) return right; // 3.
        if(right == null) return left; // 4.
        return root; // 2. if(left != null and right != null)
    }
}
```

提交结果为

```
执行用时：8 ms, 在所有 Java 提交中击败了59.22%的用户
内存消耗：41.7 MB, 在所有 Java 提交中击败了77.73%的用户
```



