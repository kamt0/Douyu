//
//  additions.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/10.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface additions : NSObject

@end
@interface UITextField (handle)
/**
 *  光标位置的获取
 *
 *  @return 
 */
- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;
@end

@interface UITableView (handle)
/**
 *  tableview 默认左侧有15像素留白，创建tableview后执行此方法
 */
- (void)UIEdgeInsetsZero;

@end


@interface UITableViewCell(handle)
/**
 *  tableviewcell设置左间距为0，避免左侧15像素，配合上面使用，在tableView:willDisplayCell:forRowAtIndexPath:中执行
 */
- (void)setEdgeInsetsZero;

@end
@interface UIScrollView (handle)
//作用是防止在scrollView上触摸手势不响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
@interface NSIndexPath (handle)
/**
 *  比较两者是否相等
 *
 *  @param indexPath
 *
 *  @return
 */
- (BOOL)isEqual:(NSIndexPath *)indexPath;
@end