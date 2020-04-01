//
//  RHLinkedList.m
//  Algorithm
//
//  Created by zhuruhong on 2020/3/31.
//  Copyright © 2020 zhuruhong. All rights reserved.
//

#import "RHLinkedList.h"

@implementation RHLinkedList

/** 反转链表 */
- (RHLinkNode *)reverse:(RHLinkNode *)head
{
//    printf("reverse: ");
    RHLinkNode *current = head;
    RHLinkNode *pre = NULL;
    while (NULL != current) {
        RHLinkNode *next = current->next;
        current->next = pre;
        pre = current;
        current = next;
    }
    printf("\n");
    
    return pre;
}

- (RHLinkNode *)createLinkNode:(int)length
{
    RHLinkNode *head = NULL;
    RHLinkNode *current = NULL;
    for (int i=0; i<=length; i++) {
        RHLinkNode *node = (RHLinkNode *)malloc(sizeof(RHLinkNode));
        node->value = rand() % 10;
        node->next = NULL;
        
        if (current) {
            current->next = node;
            current = node;
        } else {
            current = node;
            head = current;
        }
    }
    return head;
}

- (void)printLinkedList:(RHLinkNode *)head
{
    printf("print: ");
    RHLinkNode *current = head;
    while (NULL != current) {
        printf("%d ", current->value);
        current = current->next;
    }
    printf("\n");
}

/** 用链表表达一个整数，对两个整数（链表）求和 */
- (RHLinkNode *)sumWithValue1:(RHLinkNode *)value1 value2:(RHLinkNode *)value2
{
    RHLinkNode *reverse1 = [self reverse:value1];
    RHLinkNode *reverse2 = [self reverse:value2];
    
    RHLinkNode *sum = NULL;
    BOOL isOver = NO;
    RHLinkNode *p1 = reverse1;
    RHLinkNode *p2 = reverse2;
    
    while (p1 && p2) {
        RHLinkNode *node = (RHLinkNode *)malloc(sizeof(RHLinkNode));
        int value = p1->value + p2->value;
        value = isOver ? (value + 1) : value;
        if (value >= 10) {
            isOver = YES;
        } else {
            isOver = NO;
        }
        node->value = isOver ? (value - 10) : value;
        node->next = NULL;
        
        node->next = sum;
        sum = node;
        
        p1 = p1->next;
        p2 = p2->next;
    }
    
    while (p1) {
        if (isOver) {
            p1->value++;
            isOver = NO;
        }
        RHLinkNode *next = p1->next;
        p1->next = sum;
        sum = p1;
        p1 = next;
    }
    
    while (p2) {
        if (isOver) {
            p1->value++;
            isOver = NO;
        }
        RHLinkNode *next = p2->next;
        p2->next = sum;
        sum = p2;
        p2 = next;
    }
    
    return sum;
}

/**
 * 将链表中的index位置开始，length长度的元素逆序，其他元素保持不变
 *
 * 思路1：当前方法，一次遍历完成，逆序串联，O(n)；但是逻辑可读性差，未处理长度超过的情况
 * 思路2：截取需要逆序长度的链表，然后逆序，将逻辑拆分，可读性更好
 */
- (void)reverseGroup:(RHLinkNode *)head index:(int)index length:(int)length
{
    RHLinkNode *p = head;
    int current = 0;
    int count = 0;
    RHLinkNode *pre = NULL;
    RHLinkNode *c = NULL;
    RHLinkNode *n = NULL;
    while (p) {
        if (current < index) {
            p = p->next;
            current++;
            continue;
        } else if (current == index) {
            pre = p;
            p = p->next;
            current++;
            continue;
        }
        
        if (count < length) {
            RHLinkNode *next = p->next;
            NSLog(@"count: %d, value: %d", count, p->value);
            
            //记录逆序链表的最后一个节点，在串联时，减少对逆序链表的搜索
            if (count == 0) {
                n = p;
            }
            
            p->next = c;
            c = p;
            
            p = next;
            count++;
            continue;
        } else if (count == length) {
            [self printLinkedList:c];
            NSLog(@"count: %d, value: %d", count, p->value);
            //串联逆序前链表
            pre->next = c;
            //串联逆序后链表
            n->next = p;
            //串联后，直接break
            count++;
            break;
        }
        
//        p = p->next;
    }
}

- (void)execute
{
    RHLinkNode *num1 = [self createLinkNode:4];
    RHLinkNode *num2 = [self createLinkNode:3];
    [self printLinkedList:num1];
    [self printLinkedList:num2];
    
    RHLinkNode *sum = [self sumWithValue1:num1 value2:num2];
    [self printLinkedList:sum];
    
    RHLinkNode *group = [self createLinkNode:10];
    [self printLinkedList:group];
    [self reverseGroup:group index:2 length:4];
    [self printLinkedList:group];
    
//    RHLinkNode *temp = [self reverse:num1];
//    [self printLinkedList:temp];
}

@end
