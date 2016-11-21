//
//  CommonMacros.h
//Reindeer
//
//  Created by Sword on 3/15/12.
//  Copyright (c) 2015 Sword. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h
////////////////////////////////////////////////////////////////////////////////
#pragma mark - shortcuts

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//----------------------图片----------------------------
//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//建议使用前两种宏定义,性能高于后者
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

//----------------------图片----------------------------
////////////////////////////////////////////////////////////////////////////////
#pragma mark - common functions 


////////////////////////////////////////////////////////////////////////////////
#pragma mark - degrees/radian functions 
//由角度转化成弧度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
//由弧度转化成角度
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

////////////////////////////////////////////////////////////////////////////////
#pragma mark - color functions 

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define RANDOMRGBCOLOR() [UIColor colorWithRed:(random()%256)/255.0f green:(random()%256)/255.0f blue:(random()%256)/255.0f alpha:1]

#define UIColorFromRGB(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_HEX(Str)   [UIColor colorWithRGBString:Str]
    
///////////////////////////////////////
#define SHOULDOVERRIDE(basename, subclassname){ NSAssert([basename isEqualToString:subclassname], @"subclass must override the method!");}

#define SHOULDOVERRIDE_M(basename, subclassname, message){ NSAssert([basename isEqualToString:subclassname], message);}

//----------------------系统----------------------------
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
//----------------------系统----------------------------


#define iPhone4 (CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size) ?YES: NO)
#define iPhone5 (CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size) ?YES: NO)
#define iPhone6 (CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size) ?YES: NO)
#define iPhone6plus (CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size) ?YES: NO)
#define ScreenBoundHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBoundWidth  [UIScreen mainScreen].bounds.size.width

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//状态栏高度
#define StatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavigationBarHeight (self.navigationController.navigationBar.bounds.size.height)

#endif