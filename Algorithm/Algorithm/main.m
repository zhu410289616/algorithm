//
//  main.m
//  Algorithm
//
//  Created by zhuruhong on 2020/3/6.
//  Copyright © 2020 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "stdlib.h"

/** 先取余，将最后一个取出来，再求整商，每次循环乘十，分离出每个数据反转 */
int64_t reverseByMod(int32_t src) {
    int32_t temp = src;
    int64_t dst = 0;
    while (temp != 0) {
        dst = dst * 10 + temp % 10;
        temp = temp / 10;
    }
    return dst;
}

int64_t reverseByString(int32_t src) {
    NSString *valueStr = [NSString stringWithFormat:@"%d", src];
    NSString *tempStr = @"";
    
    for (int i=0; i<valueStr.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *num = [valueStr substringWithRange:range];
        tempStr = [NSString stringWithFormat:@"%@%@", num, tempStr];
    }
    
    int64_t reverseValue = [tempStr integerValue];
    return reverseValue;
}

int64_t reverseFunction1(int32_t src) {
    bool isNegative = (src < 0) ? true : false;
    int32_t temp = isNegative ? (0 - src) : src;
    int64_t dst = reverseByMod(temp);
    dst = isNegative ? (0 - dst) : dst;
    return dst;
}

int64_t reverseFunction2(int32_t src) {
    bool isNegative = (src < 0) ? true : false;
    int32_t temp = isNegative ? (0 - src) : src;
    int64_t dst = reverseByString(temp);
    dst = isNegative ? (0 - dst) : dst;
    return dst;
}

/** 10进制转16进制 */
void printNum(int64_t mode) {
    if (mode == 10) {
        printf("A ");
    } else if (mode == 11) {
        printf("B ");
    } else if (mode == 12) {
        printf("C ");
    } else if (mode == 13) {
        printf("D ");
    } else if (mode == 14) {
        printf("E ");
    } else if (mode == 15) {
        printf("F ");
    } else {
        printf("%lld ", mode);
    }
}

/** 循环方法 10进制转16进制 */
void convertTen2Hex(int64_t src, int scale) {
    int64_t temp = src;
    while (temp > scale) {
        int64_t hex = temp % scale;
        printNum(hex);
        temp = temp / scale;
    }
    printf("%lld\n", temp);
}

/** 递归方法 recursion 10进制转16进制 */
void convertTen2HexRecursion(int64_t src, int scale) {
    if (src == 0) {
        return;
    }
    
    int64_t mode = src % scale;
    convertTen2HexRecursion(src / scale, scale);
    printNum(mode);
}

static int calcTimes = 0;

/**
 * 在不申请内存的情况下，调整数组顺序使奇数位于偶数前面
 * 时间复杂度 O(n)
 */
NSArray * divideGroup(NSArray *aNums) {
    
    NSMutableArray *nums = [NSMutableArray arrayWithArray:aNums];
    NSInteger lastIndex = nums.count - 1;
    //如果一直遍历到最后一个，如果是奇数，说明全部是奇数；如果是偶数，本身就不需要移动；
    for (NSInteger i=0; i<lastIndex; i++) {
        
        calcTimes++;
        
        //前后两个指针位置重叠，说明数组已经全部遍历（从前往后，从后往前）
        if (i >= lastIndex) {
            break;
        }
        
        NSNumber *first = nums[i];
        if (first.integerValue % 2 == 1) {
            continue;
        }
        
        NSNumber *last = nil;
        for (NSInteger j=lastIndex; j>i; j--) {
            calcTimes++;
            
            last = nums[j];
            if (last.integerValue % 2 == 0) {
                continue;
            }
            lastIndex = j;
            break;
        }
        
        if (last) {
            NSNumber *temp = [last copy];
            nums[lastIndex] = nums[i];
            nums[i] = temp;
            //从后面找到一个后，当前位置往前移
            lastIndex--;
        }
    }
    
    return nums;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        int32_t src = 1236987;
        int64_t reserveValue = 0;
        
        reserveValue = reverseFunction1(src);
        NSLog(@"%d ====> %lld", src, reserveValue);
        
        src = -123;
        reserveValue = reverseFunction1(src);
        NSLog(@"%d ====> %lld", src, reserveValue);
        
        src = 120;
        reserveValue = reverseFunction1(src);
        NSLog(@"%d ====> %lld", src, reserveValue);
        
        NSLog(@"------------> 10进制转换X进制");
        
        NSLog(@"------------>循环方法 10进制转换X进制");
        convertTen2Hex(3243543, 16);
        printf("\n");
        
        NSLog(@"------------>递归方法 10进制转换X进制");
        convertTen2HexRecursion(3243543, 16);
        printf("\n");
        
        NSLog(@"------------>在不申请内存的情况下，调整数组顺序使奇数位于偶数前面");
        NSArray *beforeNums = @[
            @234, @235, @24, @67, @234, @23, @78, @30,
            @234, @235, @24, @67, @234, @23, @78, @30,
            @234, @235, @24, @67, @234, @23, @78, @30,
            @234, @235, @24, @67, @234, @23, @78, @30,
            @234, @235, @24, @67, @234, @23, @78, @30
        ];
        NSArray *afterNums = divideGroup(beforeNums);
        NSLog(@"%d times, afterNums: %@", calcTimes, afterNums);
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
