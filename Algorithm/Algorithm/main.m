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
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
