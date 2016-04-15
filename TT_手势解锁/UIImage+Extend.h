//
// 
// 
//
// 
//
//  UIImage分类扩展方法

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

#pragma mark - Create StretchImage

/**
 *  @brief  创建默认拉伸的Image
 *
 *  @param
 *
 *  @return
 */
+ (UIImage *)stretchImageWithName:(NSString *)imageName;

/**
 *  @brief  创建自定义拉伸的Image
 *
 *  @param  xPos 拉伸点的x坐标占图片长度的比例
 *  @param  yPos 拉伸点的y坐标占图片高度的比例
 *
 *  @return
 */
+ (UIImage *)stretchImageWithName:(NSString *)imageName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

#pragma mark - ScreenShot Image

/**
  *  @brief  获取视图的截图
  *
  *  @param  view 需要截图的View
  *
  *  @return UIImage 截图
  */
+ (UIImage *)screenshotWithView:(UIView *)view shotSize:(CGSize)shotSize;




/**
 *  压缩图片----只变宽度
 *
 *  @param image   图片
 *  @param newsize 大小
 *
 *  @return 图片
 */
+(UIImage *)imageWithImage:(UIImage*)image Size:(CGSize)newsize;




/**
 *  压缩图片base 64 方式
 *
 *  @param image 图片
 *
 *  @return 返回图片base 64 字符串形式
 */

+(NSString*)YasuoImage:(UIImage*)image;








/**
 *  截屏
 *
 *  @param view 需要截屏的view
 *
 */

+(UIImage *)saveImage:(UIView *)view;


/**
 *  加半透明水印
 *
 *  @param useImage  需要加水印的图片
 *  @param maskImage 水印图片
 */
+(UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect;


////加水印 水印是文字
//
///**
// *  加水印 水印是文字
// *
// *  @param img  需要加水印的图片
// *  @param text1 水印文字
// */
//+ (UIImage *)addText:(UIImage *)img text:(NSString *)text1;



/**
 *  压缩图片
 *
 *  @param image   需要压缩的图片
 *  @param newSize 需要压缩的大小
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;





//压缩图片----只变宽度
/**
 *  压缩图片----只变宽度
 *
 *  @param image   图片
 *  @param newsize 大小
 *
 *  @return 图片
 */
+(NSData *)imageWithImage:(UIImage*)image;




/**
 *  生成pdf方法2
 *
 *  @param aView     view
 *  @param aFilename 保存pdf路径
 *
 *  @return 返回保存的路径-此时已经保存了
 */
+(NSString*)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename;

/**
 *  生成pdf方法2
 *
 *  @param aView     view
 *  @param aFilename 保存pdf路径
 *
 *  @return 返回保存的路径-此时已经保存了
 */
-(NSString*)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename;




/**
 *  截取图片
 *
 *  @param image     为需要取的原图片
 *  @param imageview imageview为需要取图的原图片控件
 *  @param rect      rect 为需要取的尺寸
 *
 *  @return 截取图片
 */
-(UIImage *)getNeedImageFrom:(UIImage*)image   imageview:(UIImageView*)imageview cropRect:(CGRect)rect;





/**
 *  图片裁剪：把正方形图片重新生产一张圆形的图片---绘制MJ
 *
 *  @param image       图片
 *  @param borderWidth 边框宽度
 *  @param color       边框颜色
 *
 *  @return 新的图片
 */
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;




/**
 *  给图片增加水印------文字--MJ
 *
 *  @param image     需要加水印的图片
 *  @param text      文字
 *  @param textcolor 文字颜色
 *  @param font      字体大小
 *  @param point     加的位置
 *
 *  @return 有水印的图片
 */
+(UIImage*)ImageWithAddWatermarkImage:(UIImage*)image  text:(NSString*)text  textcolor:(UIColor*)textcolor  Font:(UIFont*)font Point:(CGPoint)point;


/**
 *  截屏--MJ
 *
 *  @param view 需要截屏的试图
 *
 *  @return 截屏之后的图片
 */
+ (UIImage *)imageWithCaputureView:(UIView *)view;





/**
 *  截取图片---MJ
 *
 *  @param imageview 要截取的imageview
 *  @param rect      截取的Rect
 *
 *  @return 截取之后的图片
 */
+(UIImage*)ImageCapImage:(UIImageView*)imageview   Rect:(CGRect)rect;




/**
 *  擦除部分图片
 *
 *  @param imageview 需要擦的imageviwe
 *  @param rect      擦除的rect
 *
 *  @return 擦除之后的图片
 */
+(UIImage*)ImageWitheraserImageView:(UIImageView*)imageview  Rect:(CGRect)rect;



/**
 *  base64 转换图片
 *
 *  @param bases64tring base 64
 *
 *  @return 转换之后的图
 */
+(UIImage *)ImageWithBase64ToUIImage:(NSString *)bases64tring;



/**
 *  图片转base 64字符串
 *
 *  @param image 图片
 *
 *  @return 字符串base 64
 */
+(NSString *)Base64WithUIImageToBase64Str:(UIImage *) image;


@end
