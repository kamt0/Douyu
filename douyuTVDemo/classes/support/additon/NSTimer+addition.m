//
//  NSTimer+addition.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/4/29.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "NSTimer+addition.h"

@implementation NSTimer (addition)

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
@end
