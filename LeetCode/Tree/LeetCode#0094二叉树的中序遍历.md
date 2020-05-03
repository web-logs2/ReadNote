# 二叉树的中序遍历

```
@author: sdubrz
@date: 2020.04.20
题号： 94
题目难度： 中等
考察内容： 树
原题链接 https://leetcode-cn.com/problems/binary-tree-inorder-traversal/
题目的著作权归领扣网络所有，商业转载请联系官方授权，非商业转载请注明出处。
解题代码转载请联系 lwyz521604#163.com
```

给定一个二叉树，返回它的中序 遍历。

**示例:**

```
输入: [1,null,2,3]
   1
    \
     2
    /
   3

输出: [1,3,2]
```

**进阶:** 递归算法很简单，你可以通过迭代算法完成吗？

通过次数142,613 提交次数200,668

## 递归解法

这道题的递归解法在一般的教科书上都会有介绍，是比较好写的。

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
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> list = new LinkedList<>();
        if(root==null){
            return list;
        }

        List<Integer> list1 = inorderTraversal(root.left);
        List<Integer> list2 = inorderTraversal(root.right);
        Iterator<Integer> iter1 = list1.iterator();
        Iterator<Integer> iter2 = list2.iterator();

        while(iter1.hasNext()){
            list.add(iter1.next());
        }
        list.add(root.val);
        while(iter2.hasNext()){
            list.add(iter2.next());
        }

        return list;

    }


}
```

下面是在 LeetCode 系统中的提交结果，应该是链表的复制操作耗费了一些时间。

```
执行结果： 通过 显示详情
执行用时 : 1 ms, 在所有 Java 提交中击败了 56.22% 的用户
内存消耗 : 38 MB, 在所有 Java 提交中击败了 5.79% 的用户
```