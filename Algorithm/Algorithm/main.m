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
int64_t reverse(int32_t src) {
    int32_t temp = src;
    int64_t dst = 0;
    while (temp != 0) {
        dst = dst * 10 + temp % 10;
        temp = temp / 10;
    }
    return dst;
}

int64_t reverseFunction1(int32_t src) {
    bool isNegative = (src < 0) ? true : false;
    int32_t temp = isNegative ? (0 - src) : src;
    int64_t dst = reverse(temp);
    dst = isNegative ? (0 - dst) : dst;
    return dst;
}

/** 10进制转16进制 */
void convertTen2Hex(int64_t src, int scale) {
    
    int64_t temp = src;
    while (temp > scale) {
        int64_t hex = temp % scale;
        if (hex == 10) {
            printf("A ");
        } else if (hex == 11) {
            printf("B ");
        } else if (hex == 12) {
            printf("C ");
        } else if (hex == 13) {
            printf("D ");
        } else if (hex == 14) {
            printf("E ");
        } else if (hex == 15) {
            printf("F ");
        } else {
            printf("%lld ", hex);
        }
        temp = (temp - hex) / scale;
    }
    printf(" %lld\n", temp);
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
        convertTen2Hex(3243543, 16);
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
