### 35 搜索插入位置

给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。

请必须使用时间复杂度为 ``O(log n)`` 的算法。

**示例 1:**

```
输入: nums = [1,3,5,6], target = 5
输出: 2
```

**示例 2:**

```
输入: nums = [1,3,5,6], target = 2
输出: 1
```

**示例 3:**

```
输入: nums = [1,3,5,6], target = 7
输出: 4
```

**提示:**

+ ``1 <= nums.length <= 10^4``
+ ``-10^4 <= nums[i] <= 10^4``
+ ``nums ``为 **无重复元素** 的 **升序** 排列数组
+ ``-10^4 <= target <= 10^4``

来源：力扣（LeetCode）
链接：https://leetcode.cn/problems/search-insert-position
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

#### 我的解法

```java 
class Solution {
    public int searchInsert(int[] nums, int target) {
        return searchInsert(nums, 0, nums.length-1, target);
    }

    private int searchInsert(int[] nums, int left, int right, int target){
        // 判断是否在这个区间
        if(nums[left]>=target){
            return left;
        }
        if(nums[right]<target){
            return right+1;
        }

        
        if(left==right){
            if(nums[left]==target){
                return left;
            }else{
                return left+1;
            }
        }

        if(left>right){
            return left+1;
        }

        int medium = (left+right)/2;
        if(nums[medium]==target){
            return medium;
        }
        if(nums[medium]<target){
            return searchInsert(nums, medium+1, right, target);
        }else{
            return searchInsert(nums, left, medium-1, target);
        }

        
    }
}
```

提交结果如下

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：41.1 MB, 在所有 Java 提交中击败了28.02%的用户
```



### 278 第一个错误的版本

```
coder: sdu2014@126.com
date: 2022-05-15
key: binary search
```

你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。

假设你有 ``n ``个版本`` [1, 2, ..., n]``，你想找出导致之后所有版本出错的第一个错误的版本。

你可以通过调用`` bool isBadVersion(version) ``接口来判断版本号 ``version ``是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。

**示例 1：**

```
输入：n = 5, bad = 4
输出：4
解释：
调用 isBadVersion(3) -> false 
调用 isBadVersion(5) -> true 
调用 isBadVersion(4) -> true
所以，4 是第一个错误的版本。
```

**示例 2：**

```
输入：n = 1, bad = 1
输出：1
```

**提示：**

+ ``1 <= bad <= n <= 2^31 - 1``

来源：力扣（LeetCode）
链接：https://leetcode.cn/problems/first-bad-version
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

#### 我的解法

这个用二分法比较好实现，但是需要注意数据的范围，要防止产生溢出，造成错误。

```java
/* The isBadVersion API is defined in the parent class VersionControl.
      boolean isBadVersion(int version); */

public class Solution extends VersionControl {
    public int firstBadVersion(int n) {
        return (int)firstBadVersion(1, n);
    }

    private long firstBadVersion(long start, long end){
        // System.out.println("end = "+end+", start = "+start);
        long d = end - start;
        if(d<2){
            // System.out.println("end = "+end+", start = "+start);
            // System.out.println("end - start < 2 " + d);
            if(isBadVersion((int)start)){
                return start;
            }
            if(isBadVersion((int)end)){
                return end;
            }
        }
        long medium = (start + end)/2;
        if(isBadVersion((int)medium)){
            return firstBadVersion(start, medium);
        }else{
            return firstBadVersion(medium, end);
        }
    }
}
```

提交结果如下

```
执行结果：通过
执行用时：15 ms, 在所有 Java 提交中击败了23.77%的用户
内存消耗：38.2 MB, 在所有 Java 提交中击败了46.29%的用户
```



### 704 二分查找

```
coder: sdu2014@126.com
date: 2022-05-15
key: array, binary search
```

给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。

**示例 1:**

```
输入: nums = [-1,0,3,5,9,12], target = 9
输出: 4
解释: 9 出现在 nums 中并且下标为 4
```

**示例 2:**

```
输入: nums = [-1,0,3,5,9,12], target = 2
输出: -1
解释: 2 不存在 nums 中因此返回 -1
```

**提示：**

+ 你可以假设 nums 中的所有元素是不重复的。
+ n 将在 [1, 10000]之间。
+ nums 的每个元素都将在 [-9999, 9999]之间。

来源：力扣（LeetCode）
链接：https://leetcode.cn/problems/binary-search
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

#### 我的解法

长时间不写，代码写的有点啰嗦。

```java
class Solution {
    public int search(int[] nums, int target) {
        if(nums.length<1){
            return -1;
        }
        if(nums[0]==target){
            return 0;
        }

        int left = 0;
        int right = nums.length - 1;
        while (left < right){
            if(nums[left]>target | nums[right]<target){
                return -1;
            }
            if(nums[left]==target){
                return left;
            }
            if(nums[right]==target){
                return right;
            }

            int medium = (left+right)/2;
            if(medium==left){
                return -1;
            }
            if(nums[medium]==target){
                return medium;
            }else{
                if(nums[medium]<target){
                    left = medium;
                }else{
                    right = medium;
                }
            }


        }
        
        return -1;
    }
}
```

提交结果如下

```
执行用时：0 ms, 在所有 Java 提交中击败了100.00%的用户
内存消耗：42.1 MB, 在所有 Java 提交中击败了37.96%的用户
通过测试用例：47 / 47
```

### 