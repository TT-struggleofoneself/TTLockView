//
//  TTLockView.h
//  TT_手势解锁
//
//  Created by TT_code on 16/4/6.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import <UIKit/UIKit.h>




@class TTLockView;
/***  代理   */
@protocol TTLockViewDelegate <NSObject>
@optional;

/***  绘制结束 结果  image  手势图案 */
-(void)TTLockView:(TTLockView*)view  result:(NSString*)result;
-(void)TTLockView:(TTLockView*)view  image:(UIImage*)image;
@end


/**
 *  手势解锁view
 */
@interface TTLockView : UIView
/***  代理   */
@property(nonatomic,weak) id<TTLockViewDelegate> delegate;


/*** 线颜色   */
@property(nonatomic,strong)UIColor* linecolor;

/*** 线宽度   */
@property(nonatomic,assign)CGFloat linewidth;


/*** 按钮选中的图片名称   */
@property(nonatomic,strong)NSString* Btnselectedimagename;

/*** 按钮普通状体的图片名称   */
@property(nonatomic,strong)NSString* Btnnormolimagename;



/**
 *  用于返回初始化界面时候的图片截屏
 *
 *  @param block
 */
-(void)backinitimageWithcurrentviewBlock:(void (^)(UIImage *image))block;


/**
 *  返回的当前视图截屏
 *
 *  @return
 */
-(UIImage*)backcurrentGestureView;

@end



