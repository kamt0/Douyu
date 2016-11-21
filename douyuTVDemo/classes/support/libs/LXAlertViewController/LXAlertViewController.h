//
//  LXAlertViewController.h
//  动效提示框封装
//
//

#import <UIKit/UIKit.h>

@protocol LXAlertViewDelegate <NSObject>

@optional

- (void)positiveButtonAction:(BOOL)isYes;//确认按钮点击事件

- (void)negativeButtonAction;//否认按钮点击事件

- (void)closeButtonAction;//关闭按钮点击事件

@end


@interface LXAlertViewController : UIViewController

@property (nonatomic , strong ) UIView *titleView;

@property (nonatomic , strong ) NSString *alertTitle;//提示标题内容

@property (nonatomic , strong ) NSString *againAlertTitle;//再次提示标题内容

@property (nonatomic , strong ) NSString *successAlertTitle;//成功提示标题内容

@property (nonatomic , strong ) NSString *positiveTitle;//确定按钮

@property (nonatomic , strong ) NSString *negativeTitle;//否定按钮


@property (nonatomic , strong ) UIColor *alertColor;//提示视图颜色

@property (nonatomic , strong ) UIColor *positiveColor;//确定按钮颜色

@property (nonatomic , strong ) UIColor *negativeColor;//确定按钮颜色

@property (nonatomic , assign ) id<LXAlertViewDelegate> lxAlertViewDelegate;


//添加要显示在哪个视图控制器

- (void)showView:(UIViewController *)VC;


CA_EXTERN CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ);

CA_EXTERN CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ);



@end
