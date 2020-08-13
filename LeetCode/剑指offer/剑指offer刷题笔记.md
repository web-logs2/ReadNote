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

下面是官方程序的提交结果，明显要比我的速度快了很多。应该是Java内部字符串相加的机制的原因吧。

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

拿到这道题没有想到更加有效的方法，只想起可以用深搜来暴力地寻找，应该不是比较快的方法，因为有很多重复比较的地方。很多的搜索匹配问题，在想不起更加有效的方法试，可以用深搜和广搜来当应急的方法，下面是Java程序的实现：

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