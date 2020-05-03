# 对称二叉树

```
@author: sdubrz
@date: 2020.04.20
题号： 101
题目难度： 简单
考察内容： BFS，二叉树
原题链接 https://leetcode-cn.com/problems/symmetric-tree/
题目的著作权归领扣网络所有，商业转载请联系官方授权，非商业转载请注明出处。
解题代码转载请联系 lwyz521604#163.com
```

给定一个二叉树，检查它是否是镜像对称的。

例如，二叉树 [1,2,2,3,4,4,3] 是对称的。

```
    1
   / \
  2   2
 / \ / \
3  4 4  3
```

但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:

```
    1
   / \
  2   2
   \   \
   3    3
```

**进阶：**

你可以运用递归和迭代两种方法解决这个问题吗？

通过次数124,177  提交次数244,491

## 递归解法

递归地思路比较清楚，只需要判断左边树的右子树与右边树的左子树是否对称，以及左边树的左子树与右边数的右子树是否对称就可以了。与递归求解斐波那契数列不同，这个递归并没有大量的重复计算，因而速度应该会比较快。

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
class Solution {
    public boolean isSymmetric(TreeNode root) {
        if(root==null){
            return true;
        }

        return this.isSymmetric(root.left, root.right);
    }

    // 判断两颗树是不是互相对称
    private boolean isSymmetric(TreeNode node1, TreeNode node2){
        if(node1==null && node2==null){
            return true;
        }else if(node1==null || node2==null){
            return false;
        }

        if(node1.val!=node2.val){
            return false;
        }

        return this.isSymmetric(node1.left, node2.right) && this.isSymmetric(node1.right, node2.left);
    }
}
```

在 LeetCode 系统中提交的结果如下

```
执行结果： 通过 显示详情
执行用时 : 0 ms, 在所有 Java 提交中击败了 100.00% 的用户
内存消耗 : 37.6 MB, 在所有 Java 提交中击败了 42.50% 的用户
```