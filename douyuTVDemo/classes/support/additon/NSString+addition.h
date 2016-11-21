//
//  NSString+addition.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/9.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (addition)
/**
 * 截取字符串 以一个字符开始到另一个字符结束
 *
 *  @param start 开始位置的字符
 *  @param end   结束位置的字符
 *
 *  @return 
 */
- (NSString *)searchCharStart:(char)start charEnd:(char)end;
/**
 *  MD5加密
 *
 *  @return 
 */
- (NSString *)MD5;
/**
 *  SHA1加密
 *
 *  @return
 */
- (NSString *)SHA1;
/**
 *  SHA256加密
 *
 *  @return
 */
- (NSString *)SHA256;
/**
 *  SHA512加密
 *
 *  @return
 */
- (NSString *)SHA512;

/**
 *  字符串base64编码
 *
 *  @return
 */
- (NSString *)base64;
/**
 *  base64解码
 *
 *  @return
 */
- (NSString *)base64Decoded;
/**
 *  是否包含该字符串
 *
 *  @param substring
 *
 *  @return
 */
- (BOOL)hasString:(NSString *)substring;
/**
 *  是否包含数字
 *
 *  @return
 */
- (BOOL)ConvertNumber;
/**
 *  是否是身份证格式
 *
 *  @param value
 *
 *  @return
 */
- (BOOL)validateIDCardNumber:(NSString *)value;
/**
 *  是否是手机格式
 *
 *  @param phone <#phone description#>
 *
 *  @return
 */
+ (BOOL)validatePhone:(NSString *)phone;
/**
 *  是否是email格式
 *
 *  @param email
 *
 *  @return
 */
+ (BOOL)isEmail:(NSString *)email;

/**
 *  转成utf8格式
 *
 *  @return 
 */
- (NSString *)utf8Str;
/**
 *  将字符串以URL编码
 *
 *  @return
 */
- (NSString *)urlEncode;
/**
 *  将字符串以URL编码
 *
 *  @return
 */
- (NSString *)stringEncode;
/**
 *  将URL编码的字符串解码返回
 *
 *  @return 
 */
- (NSString *)stringDecode;

/**
 *  utf8转unicode
 *
 *  @param string
 *
 *  @return 
 */
+(NSString *) utf8ToUnicode:(NSString *)string;

/**
 *  首字母小写
 *
 *  @return 
 */
- (NSString *)firstCharLower;
/**
 * 首字母大写
 *
 *  @return 
 */
- (NSString *)firstCharUpper;
/**
 *  首字母大写其余小写
 *
 *  @return 
 */
- (NSString *)sentenceCapitalizedString;

/**
 *  是否是整形
 *
 *  @return
 */
- (BOOL)isPureInt;
/**
 *  是否是浮点型
 *
 *  @return 
 */
- (BOOL)isPureFloat;
/**
 *  文字的宽度
 *
 *  @param fontSize 字体大小
 *
 *  @return
 */
- (CGFloat)textWidthWithfont:(NSInteger)fontSize;
/**
 *   根据文字的宽度确定文字的高度
 *
 *  @param width     文字宽度
 *  @param fontSize  字体大小
 *
 *  @return 
 */
- (CGFloat)textHeight:(CGFloat)width font:(NSInteger)fontSize;
/**
 *  返回带阴影的文字
 *
 *  @return NSAttributedString
 */
- (NSAttributedString *)shadowText;
/**
 *  清除字符串敏感词
 *
 *  @param array
 *
 *  @return 
 */
-(NSString *)removeSensitiveWordsWithArray:(NSArray *)array;
@end
