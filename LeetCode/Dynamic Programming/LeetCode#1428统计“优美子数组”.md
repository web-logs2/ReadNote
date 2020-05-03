# 统计“优美子数组”

```
@author: sdubrz
@date: 2020.04.21
题号： 1428
题目难度： 中等
原题链接 https://leetcode-cn.com/problems/count-number-of-nice-subarrays/submissions/
题目的著作权归领扣网络所有，商业转载请联系官方授权，非商业转载请注明出处。
解题代码转载请联系 lwyz521604#163.com
```

给你一个整数数组 nums 和一个整数 k。

如果某个 连续 子数组中恰好有 k 个奇数数字，我们就认为这个子数组是**「优美子数组」**。

请返回这个数组中「优美子数组」的数目。


**示例 1：**

```
输入：nums = [1,1,2,1,1], k = 3
输出：2
解释：包含 3 个奇数的子数组是 [1,1,2,1] 和 [1,2,1,1] 。
```

**示例 2：**

```
输入：nums = [2,4,6], k = 1
输出：0
解释：数列中不包含任何奇数，所以不存在优美子数组。
```

**示例 3：**

```
输入：nums = [2,2,2,1,2,2,1,2,2,2], k = 2
输出：16
``` 

**提示：**

+ 1 <= nums.length <= 50000
+ 1 <= nums[i] <= 10^5
+ 1 <= k <= nums.length

通过次数13,516提交次数25,446

## 动态规划解法

这道题是今天的每日一题，由于不是按照标签来选的题，所以在读题之前也不知道这道题考察的是那个数据结构或算法。读完题目之后感觉这道题可以用动态规划来解决。

首先，对于输入的数组 nums ，这道题关心的只是 nums 中的每个元素是偶数还是奇数，至于具体的值是多少是不需要关心的。因而可以直接把 nums 中的数组替换为对 2 取余。替换之后，值为1表示这里是个奇数，值为0表示这里是个偶数。

接着，我们可以统计出 nums 中每个奇数出现的位置，对于 Java 来讲，可以用一个 ArrayList 来存储这个信息。在下面的程序中 label[i] 表示的是第 i 个奇数出现的位置。如果 nums 中的奇数个数小于 k 可以直接返回0。

用动态规划的思想，对于前 x 个元素组成的子数组，我们可以根据前 x-1 个元素组成的子数组中的“优美子数组”个数来推测出前 x 个元素组成的子数组中“优美子数组”的个数。根据 nums[x] 是否为奇数，可以分为两种情况：

+ 如果 nums[x] 不是奇数。会增加一定数量的包含 nums[1..x-1] 中最右端的 k 个奇数的“优美子数组”。
+ 如果 nums[x] 是奇数。会增加一定数量的包含 nums[x] 和 nums[1..x-1] 中最右端的 k-1 个奇数的“优美子数组”。

一个比较重要的事情就是确定上面提到的“一定数量”究竟是多少。以第一种情况为例，对于子数组 nums[1...x-1]来说，这个一定数量取决于最右端的 k 个奇数周围的情况。如下图所示，如果 nums[x] 为偶数，会增加一些包含目前子数组中最右端的 k 个奇数的“优美子数组”，其具体个数取决于从右边数第 k 个奇数和第 k+1 个奇数之间的偶数个数，具体为这个偶数个数加一。对于第二种情况也有类似的计算方法。

![1428](/images/1428.png)

这样，我们就可以迭代地计算整个数组中“优美子数组”的个数了，下面是具体的 Java 代码实现，整个算法的时间复杂度和空间复杂度都是 $O(n)$ 的。

```

import java.util.*;
class Solution {
    	public int numberOfSubarrays(int[] nums, int k) {
		
		int n = nums.length;
		if(n<k) {
			return 0;
		}
		
		int[] count = new int[n];
		//int[] sum = new int[n];
		ArrayList<Integer> label = new ArrayList<>();
		label.add(0);
		
		for(int i=0; i<n; i++) {
			nums[i] = nums[i]%2;
			if(nums[i]==1) {
				label.add(i);
			}
		}
		
		if(label.size()<=k) {
			return 0;
		}
		
		for(int i=0; i<label.get(k); i++) {
			count[i] = 0;
		}
		count[label.get(k)] = 1 + label.get(1);
		
		int left = 0;
		int right = label.get(1);
		int step = 1;
		for(int i=label.get(k)+1; i<n; i++) {
			if(nums[i]==0) {
				count[i] = count[i-1] + right - left + 1;
			}else {
				step++;
				left = right + 1;
				right = label.get(step);
				count[i] = count[i-1] + right-left+1;
			}
		}
		
		return count[n-1];
    }
	
	
}
```

在 LeetCode 系统中提交的结果为

```
执行结果： 通过 显示详情
执行用时 : 17 ms, 在所有 Java 提交中击败了 40.80% 的用户
内存消耗 : 48.6 MB, 在所有 Java 提交中击败了 100.00% 的用户
```

## 数学方法

这道题官方给出了两种解法，其中，第一种数学方法的思想与前面我的动态规划法类似。虽然时间复杂度也是 $O(n)$，不过，官方解法的常数要小一点，所以实际运行时间要比我的DP版本稍快。下面是官方解法的解释和代码截图。

![数学方法](/images/1428_2.png)

```
class Solution {
public:
    int numberOfSubarrays(vector<int>& nums, int k) {
        int n = (int)nums.size();
        int odd[n + 2], ans = 0, cnt = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] & 1) odd[++cnt] = i;
        }
        odd[0] = -1, odd[++cnt] = n;
        for (int i = 1; i + k <= cnt; ++i) {
            ans += (odd[i] - odd[i - 1]) * (odd[i + k] - odd[i + k - 1]); 
        }
        return ans;
    }
};
```

## 前缀和 + 差分

这是官方给出的第二种解法

![前缀和+差分](/images/1428_3.png)

```
class Solution {
    vector<int> cnt;
public:
    int numberOfSubarrays(vector<int>& nums, int k) {
        int n = (int)nums.size();
        cnt.resize(n + 1, 0);
        int odd = 0, ans = 0;
        cnt[0] = 1;
        for (int i = 0; i < n; ++i) {
            odd += nums[i] & 1;
            ans += odd >= k ? cnt[odd - k] : 0;
            cnt[odd] += 1;
        }
        return ans;
    }
};
```