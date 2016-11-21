//
//  PlayView.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/7.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "PlayView.h"

@implementation PlayView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
+ (Class)layerClass{
    return [AVPlayerLayer class];
}
- (AVPlayer *)player{
    return [(AVPlayerLayer *)[self layer] player];
}
- (void)setPlayer:(AVPlayer *)player{
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}
@end
