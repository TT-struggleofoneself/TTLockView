//
//  
//  
//
//  
//
//

#import "TTLockView.h"
#import "UIImage+Extend.h"

@interface TTLockView()
@property(nonatomic,strong)NSMutableArray * selectedBtns;//用于保存选中的按钮

@property(nonatomic,assign)CGPoint currentpoint;//记录当前触摸点
@end




@implementation TTLockView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化设置
        [self setinit];
        
        //  创建按钮
        [self createButtons];
        
        //增加pan手势
        [self addpan];
        
        
    }
    return self;
}


/**
 *  加载xib
 */
-(void)awakeFromNib
{
    //初始化设置
    [self setinit];
    
    //  创建按钮
    [self createButtons];
    
    //增加pan手势
    [self addpan];
}



//初始化设置
-(void)setinit{
    self.linewidth=10;
    self.linecolor=[UIColor greenColor];
    self.Btnselectedimagename=@"gesture_node_highlighted";
    self.Btnnormolimagename=@"gesture_node_normal";
}



/**
 *  保存选中的按钮数组---懒加载
 *
 *  @return
 */
-(NSMutableArray *)selectedBtns
{
    if(!_selectedBtns){
        _selectedBtns=[NSMutableArray array];
    }
    return _selectedBtns;
}


/**
 *  增加pan手势
 */
-(void)addpan
{
    UIPanGestureRecognizer* pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanAction:)];
    [self addGestureRecognizer:pan];
}



/**
 *  用于返回初始化界面时候的图片截屏
 *
 *  @param block
 */
-(void)backinitimageWithcurrentviewBlock:(void (^)(UIImage *))block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block([self backcurrentGestureView]);
    });
}

/**
 *  pan  手势执行的方法
 *
 *  @param recognizer
 */
-(void)PanAction:(UIPanGestureRecognizer*)recognizer
{
    self.currentpoint=[recognizer locationInView:self];
    
    if(recognizer.state==UIGestureRecognizerStateChanged){
        //判断触摸点有没有在当前按钮上
        for (UIButton* button in self.subviews) {
            if(CGRectContainsPoint(button.frame,self.currentpoint) && button.selected==NO){//触摸点在按钮上
                button.selected = YES;
                [self.selectedBtns addObject:button];//选中按钮加入数组
                
                //截屏
                UIImage* image=[self backcurrentGestureView];
                if([self.delegate respondsToSelector:@selector(TTLockView:image:)]){
                    [self.delegate TTLockView:self image:image];
                }
            }
        }
    }
    //重绘
    [self setNeedsDisplay];
    
    //结束
    if (recognizer.state==UIGestureRecognizerStateEnded){
        
        NSMutableString* string=[NSMutableString string];
        for (UIButton* button in self.selectedBtns) {
            [string appendFormat:@"%ld",button.tag];
        }
       
        
        [self recoveryUI];//还原界面
        //返回值
        if([self.delegate respondsToSelector:@selector(TTLockView:result:)]){
            [self.delegate TTLockView:self result:string];
        }
    }
    
    if (recognizer.state==UIGestureRecognizerStateCancelled){
         [self recoveryUI];//还原界面
    }
    
    if (recognizer.state==UIGestureRecognizerStateFailed){
        [self recoveryUI];//还原界面
    }
}



/**
 *  返回的当前视图截屏
 *
 *  @return
 */
-(UIImage*)backcurrentGestureView
{
    [self setNeedsDisplay];
    return  [UIImage imageWithCaputureView:self];
}



/**
 *  恢复界面
 *
 *  @return 
 */
-(void)recoveryUI
{
    //还原界面
    for (UIButton* button in self.subviews) {
        button.selected=NO;
    } 
    [self.selectedBtns removeAllObjects];
    [self setNeedsDisplay];
}






/**
 *  设置线颜色
 *
 *  @param linecolor
 */
-(void)setLinecolor:(UIColor *)linecolor
{
    _linecolor=linecolor;
    [self setNeedsDisplay];//重绘
}


/**
 *  设置线宽度
 *
 *  @param linewidth
 */
-(void)setLinewidth:(CGFloat)linewidth
{
    _linewidth=linewidth;
    [self setNeedsDisplay];//重绘
}


/**
 *  设置按钮选中图片名称
 *
 *  @param Btnselectedimagename
 */
-(void)setBtnselectedimagename:(NSString *)Btnselectedimagename
{
    _Btnselectedimagename=Btnselectedimagename;
    [self createButtons];
}

/**
 *  设置按钮普通状态名称
 *
 *  @param Btnnormolimagename
 */
-(void)setBtnnormolimagename:(NSString *)Btnnormolimagename
{
    _Btnnormolimagename=Btnnormolimagename;
     [self createButtons];
}




/**
 *  创建按钮
 */
-(void)createButtons
{
    //先移除之前的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    
    //布局按钮---创建9个按钮
    for (int i=0; i<9; i++) {
        UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=i+1;
        [button  setImage:[UIImage imageNamed:self.Btnnormolimagename] forState:UIControlStateNormal];
        button.userInteractionEnabled=NO;
        [button setImage:[UIImage imageNamed:self.Btnselectedimagename] forState:UIControlStateSelected];
        [self addSubview:button];
    }
}


/**
 *  布局button
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //开始布局buttons
    NSInteger count=self.subviews.count;
    
    int  cols=3;//表示有3行3列
    CGFloat width=74;
    CGFloat height=74;
    //间隔距离
    CGFloat margin=(self.bounds.size.width-cols*width)/(cols+1);
    CGFloat col=0;//定义一个列数
    CGFloat row=0;//定义一个行数
    
    //开始布局
    for (int i=0; i<count; i++) {
        UIButton* button=self.subviews[i];
        col=i%cols;
        row=i/cols;
        button.frame=CGRectMake(margin+(width+margin)*col, (margin+height)*row, width, height);
    }
    
}


//开始绘制图形
-(void)drawRect:(CGRect)rect
{
    if(self.selectedBtns.count==0) return;
    
    
    UIBezierPath* path=[UIBezierPath bezierPath];
    //开始绘制
    for ( int i=0; i<self.selectedBtns.count; i++) {
        UIButton* buton=self.selectedBtns[i];
        if(i==0){
            [path moveToPoint:buton.center];
        }else{
            [path addLineToPoint:buton.center];
        }
    }
    //连接到手势触摸点
    if(self.currentpoint.y>0){
        [path addLineToPoint:self.currentpoint];
    }
    path.lineJoinStyle=kCGLineJoinRound;
    [self.linecolor set];
    path.lineWidth=self.linewidth;
    //绘制
    [path stroke];
}







@end
