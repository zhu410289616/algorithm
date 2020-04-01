//
//  RHLinkedList.h
//  Algorithm
//
//  Created by zhuruhong on 2020/3/31.
//  Copyright © 2020 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

typedef struct LinkNode {
    int value;
    struct LinkNode *next;
} RHLinkNode;

@interface RHLinkedList : NSObject

/** 反转链表 */
- (RHLinkNode *)reverse:(RHLinkNode *)head;
/** 用链表表达一个整数，对两个整数（链表）求和 */
- (RHLinkNode *)sumWithValue1:(RHLinkNode *)value1 value2:(RHLinkNode *)value2;

- (void)execute;

@end

//NS_ASSUME_NONNULL_END
