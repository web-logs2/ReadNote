# 不同路径

```
@author: sdubrz
@date: 2020.04.20
题号： 63
题目难度： 中等
考察内容： 动态规划
原题链接 https://leetcode-cn.com/problems/unique-paths-ii/
题目的著作权归领扣网络所有，商业转载请联系官方授权，非商业转载请注明出处。
解题代码转载请联系 lwyz521604#163.com
```

一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为“Start” ）。

机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为“Finish”）。

现在考虑网格中有障碍物。那么从左上角到右下角将会有多少条不同的路径？

![63](/images/62.png)

网格中的障碍物和空位置分别用 1 和 0 来表示。

**说明：**m 和 n 的值均不超过 100。

**示例 1:**

```
输入:
[
  [0,0,0],
  [0,1,0],
  [0,0,0]
]
输出: 2
解释:
3x3 网格的正中间有一个障碍物。
从左上角到右下角一共有 2 条不同的路径：
1. 向右 -> 向右 -> 向下 -> 向下
2. 向下 -> 向下 -> 向右 -> 向右
```

通过次数54,072 提交次数164,780

## 解法

这道题相比于第62题来说，不同之处是加了障碍物。可以对第62题的解法稍作修改。在填路径数量表之前，先判断当前网格处是否为障碍物，如果是则直接记到该网格的路径数为0，否则，按照第62题的方法计算。

```
class Solution {
    public int uniquePathsWithObstacles(int[][] obstacleGrid) {
        int n = obstacleGrid.length;
        if(n==0){
            return 0;
        }
        int m = obstacleGrid[0].length;
        if(m==0){
            return 0;
        }
        if(obstacleGrid[0][0]==1){
            return 0;
        }

        int[][] count = new int[n][m];
        boolean good = true;
        for(int i=0; i<n; i++){
            if(obstacleGrid[i][0]==1){
                good = false;
            }
            if(good){
                count[i][0] = 1;
            }else{
                count[i][0] = 0;
            }
        }

        good = true;
        for(int i=0; i<m; i++){
            if(obstacleGrid[0][i]==1){
                good = false;
            }
            if(good){
                count[0][i] = 1;
            }else{
                count[0][i] = 0;
            }
        }

        for(int i=1; i<n; i++){
            for(int j=1; j<m; j++){
                if(obstacleGrid[i][j]==1){
                    count[i][j] = 0;
                    continue;
                }

                count[i][j] = count[i-1][j]+count[i][j-1];
            }
        }

        return count[n-1][m-1];
    }
}
```

在 LeetCode 系统中提交的结果为

```
执行结果： 通过 显示详情
执行用时 : 1 ms, 在所有 Java 提交中击败了 77.92% 的用户
内存消耗 : 38.9 MB, 在所有 Java 提交中击败了 48.15% 的用户
```
