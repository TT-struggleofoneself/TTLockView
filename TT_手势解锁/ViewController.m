//
//  ViewController.m
//  TT_手势解锁
//
//  Created by TT_code on 16/4/6.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "ViewController.h"
#import "TTLockView.h"
@interface ViewController ()<TTLockViewDelegate>
@property (weak, nonatomic) IBOutlet TTLockView *lockview;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lockview.delegate=self;
    //自定义设置
    self.lockview.linewidth=20;
    self.lockview.linecolor=[UIColor redColor];
    
    //获取初始化图片---
    [self.lockview backinitimageWithcurrentviewBlock:^(UIImage *image) {
        self.imageview.image=image;
    }];
    
}


/**
 *  绘制结果
 *
 */
-(void)TTLockView:(TTLockView *)view result:(NSString *)result {
    NSLog(@"打印绘制结果:%@",result);
}

/**
 *  当图片改变时候
 *
 */
-(void)TTLockView:(TTLockView *)view image:(UIImage *)image
{
     self.imageview.image=image;
}

@end
