# 二叉树的右视图

```
@author: sdubrz
@date: 2020.04.22
题号： 199
题目难度： 中等
考察内容： 树
原题链接 https://leetcode-cn.com/problems/binary-tree-right-side-view/
题目及官方解法的著作权归领扣网络所有，商业转载请联系官方授权，非商业转载请注明出处。
解题代码转载请联系 lwyz521604#163.com
```

给定一棵二叉树，想象自己站在它的右侧，按照从顶部到底部的顺序，返回从右侧所能看到的节点值。

**示例:**

```
输入: [1,2,3,null,5,null,4]
输出: [1, 3, 4]
解释:

   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---
```

通过次数28,313 提交次数44,128

## 递归解法

首先，拿到这道题的初步感觉是，必须要遍历所有的节点，因而时间复杂度不太可能低于 $O(n)$。

这道题可以用递归来做。以节点A为根节点的子树的右视图可以根据它的左子树的右视图和右子树的右视图来得到。如果右子树的右视图链表长度不小于左子树的右视图链表，那么整棵树的链表直接加上右子树的链表就可以了。否则，需要加上左子树链表中后面的几个。

下面是用 Java 实现的代码

```
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
 import java.util.*;
class Solution {
    public List<Integer> rightSideView(TreeNode root) {
        List<Integer> list = new ArrayList<Integer>();
        if(root==null)
            return list;
        
        list.add(root.val);
        List<Integer> list1 = rightSideView(root.right);
        List<Integer> list2 = rightSideView(root.left);

        list.addAll(list1);

        if(list1.size()<list2.size()){
            for(int i=list1.size(); i<list2.size(); i++){
                list.add(list2.get(i));
            }
        }

        return list;
    }
}
```

下面是在 LeetCode 系统中提交的结果

```
执行结果： 通过 显示详情
执行用时 : 1 ms, 在所有 Java 提交中击败了 97.39% 的用户
内存消耗 : 38.7 MB, 在所有 Java 提交中击败了 5.00% 的用户
```

## 官方解法1：深度优先搜索

官方给出题解中也说明了由于树的形状无法提前知晓，不可能设计出由于 $O(n)$ 的算法这一点。官方分别用 DFS 和 BFS 给出了解法。下面是官方给出的解法。

**思路**

我们对树进行深度优先搜索，在搜索过程中，我们总是先访问右子树。那么对于每一层来说，我们在这层见到的第一个结点一定是最右边的结点。

**算法**

这样一来，我们可以存储在每个深度访问的第一个结点，一旦我们知道了树的层数，就可以得到最终的结果数组。

![DFS](/images/199_2.png)

上图表示了问题的一个实例。红色结点自上而下组成答案，边缘以访问顺序标号。

```
class Solution {
    public List<Integer> rightSideView(TreeNode root) {
        Map<Integer, Integer> rightmostValueAtDepth = new HashMap<Integer, Integer>();
        int max_depth = -1;

        Stack<TreeNode> nodeStack = new Stack<TreeNode>();
        Stack<Integer> depthStack = new Stack<Integer>();
        nodeStack.push(root);
        depthStack.push(0);

        while (!nodeStack.isEmpty()) {
            TreeNode node = nodeStack.pop();
            int depth = depthStack.pop();

            if (node != null) {
            	// 维护二叉树的最大深度
                max_depth = Math.max(max_depth, depth);

                // 如果不存在对应深度的节点我们才插入
                if (!rightmostValueAtDepth.containsKey(depth)) {
                    rightmostValueAtDepth.put(depth, node.val);
                }

                nodeStack.push(node.left);
                nodeStack.push(node.right);
                depthStack.push(depth+1);
                depthStack.push(depth+1);
            }
        }

        List<Integer> rightView = new ArrayList<Integer>();
        for (int depth = 0; depth <= max_depth; depth++) {
            rightView.add(rightmostValueAtDepth.get(depth));
        }

        return rightView;
    }
}
```

**复杂度分析**

+ 时间复杂度 : $O(n)$。深度优先搜索最多访问每个结点一次，因此是线性复杂度。

+ 空间复杂度 : $O(n)$。最坏情况下，栈内会包含接近树高度的结点数量，占用 $O(n)$ 的空间。

## 官方解法2：广度优先搜索

**思路**

我们可以对二叉树进行层次遍历，那么对于每层来说，最右边的结点一定是最后被遍历到的。二叉树的层次遍历可以用广度优先搜索实现。

**算法**

执行广度优先搜索，左结点排在右结点之前，这样，我们对每一层都从左到右访问。因此，只保留每个深度最后访问的结点，我们就可以在遍历完整棵树后得到每个深度最右的结点。除了将栈改成队列，并去除了rightmost_value_at_depth之前的检查外，算法没有别的改动。

![BFS](/images/199_3.png)

上图表示了同一个示例，红色结点自上而下组成答案，边缘以访问顺序标号。

```
class Solution {
    public List<Integer> rightSideView(TreeNode root) {
        Map<Integer, Integer> rightmostValueAtDepth = new HashMap<Integer, Integer>();
        int max_depth = -1;

        Queue<TreeNode> nodeQueue = new LinkedList<TreeNode>();
        Queue<Integer> depthQueue = new LinkedList<Integer>();
        nodeQueue.add(root);
        depthQueue.add(0);

        while (!nodeQueue.isEmpty()) {
            TreeNode node = nodeQueue.remove();
            int depth = depthQueue.remove();

            if (node != null) {
            	// 维护二叉树的最大深度
                max_depth = Math.max(max_depth, depth);

                // 由于每一层最后一个访问到的节点才是我们要的答案，因此不断更新对应深度的信息即可
                rightmostValueAtDepth.put(depth, node.val);

                nodeQueue.add(node.left);
                nodeQueue.add(node.right);
                depthQueue.add(depth+1);
                depthQueue.add(depth+1);
            }
        }

        List<Integer> rightView = new ArrayList<Integer>();
        for (int depth = 0; depth <= max_depth; depth++) {
            rightView.add(rightmostValueAtDepth.get(depth));
        }

        return rightView;
    }
}

```

**复杂度分析**

时间复杂度 : $O(n)$。 每个节点最多进队列一次，出队列一次，因此广度优先搜索的复杂度为线性。

空间复杂度 : $O(n)$。每个节点最多进队列一次，所以队列长度最大不不超过 $n$，所以这里的空间代价为 $O(n)$。

