//
//  SingTonManger.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/13.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "SingTonManger.h"
#import "AppDelegate.h"
#import "SingTonManger.h"


typedef NS_ENUM(NSInteger, SaveFlowSettingType) {
    
    SaveFlowSettingTypeAllNetWorking,
    
    SaveFlowSettingTypeOnlyWiFi,
    
    SaveFlowSettingTypeClose,
    
};

@implementation SingTonManger

+(instancetype)sharedSingTonManger{
    static  SingTonManger *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[[self class] alloc]init];
    });
    return manger;
    
}
#pragma mark ---根据设置类型加载图片 (所有网络,仅WiFi等..)

-(BOOL)loadImageAccordingToTheSetType{
    
    //获取省流量设置选项下标 (0 -- 2)
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    SaveFlowSettingType type = [[defaults objectForKey:@"setting_saveflow_selectedindexpath"] integerValue];
    
    switch (type) {
            
        case SaveFlowSettingTypeAllNetWorking:
        {
            
            //所有网络
            
            return YES;
            
        }
            break;
            
        case SaveFlowSettingTypeOnlyWiFi:
        {
            
            //获取当前网络状态
            
            AFNetworkReachabilityStatus  networkStatus = [NetRequestManger currentStatus];
            
            //判断是否为WiFi网络
            if (networkStatus == AFNetworkReachabilityStatusReachableViaWiFi) {
                
                return YES;
                
            } else {
                
                return NO;
            }
            
        }
            break;
            
        case SaveFlowSettingTypeClose:
        {
            
            //关闭图片加载
            
            return NO;
            
        }
            break;
            
        default:
        {
            
            return YES;
            
        }
            break;
            
    }
    
}
-(void)downloadViewHiddenOrShow:(BOOL)isHidden{
    if (isHidden) {
        
        //隐藏下载气泡
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        
        app.globalView.hidden = TRUE;
        
    } else {
        
        //显示下载气泡
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        
        app.globalView.hidden = FALSE;
        
    }

}
@end
