//
//  UIImage+Extend.m
//  BCMSystem
//
//  Created by ccg on 14-4-15.
//  Copyright (c) 2014年 mobisoft. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)



/**
 *  拉伸图片（（（（一半））））
 *
 *  @param imageName 图片名称
 *
 *  @return 拉伸之后的图片
 */
+ (UIImage *)stretchImageWithName:(NSString *)imageName {
   return [self stretchImageWithName:imageName xPos:0.5 yPos:0.5];
}

/**
 *  拉伸图片
 *
 *  @param imageName 图片名称
 *  @param xPos      X拉伸多少
 *  @param yPos      Y拉伸多少
 *
 *  @return 拉伸之后图片
 */
+ (UIImage *)stretchImageWithName:(NSString *)imageName xPos:(CGFloat)xPos yPos:(CGFloat)yPos {
    UIImage *image = [UIImage imageNamed:imageName];
    double imageWidth = image.size.width;
    double imageHeight = image.size.height;
    return [image stretchableImageWithLeftCapWidth:imageWidth * xPos topCapHeight:imageHeight * yPos];
}



/**
 *   view转换为图片
 *
 *  @param view     需要转换的view
 *  @param shotSize 尺寸
 *
 *  @return 转换之后的图片
 */
+ (UIImage *)screenshotWithView:(UIView *)view shotSize:(CGSize)shotSize
{
    UIGraphicsBeginImageContext(shotSize);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



//
/**
 *  压缩图片----宽度高度不变 像素点变化
 *
 *  @param image 图片
 *
 *  @return nsdata
 */
+(NSData *)imageWithImage:(UIImage*)image
{
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}


//压缩图片----只变宽度
/**
 *  压缩图片----只变宽度
 *
 *  @param image   图片
 *  @param newsize 大小
 *
 *  @return 图片
 */
+(UIImage *)imageWithImage:(UIImage*)image Size:(CGSize)newsize
{
    UIGraphicsBeginImageContext(newsize);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}



/**
 *  压缩图片base 64 方式
 *
 *  @param image 图片
 *
 *  @return 返回图片base 64 字符串形式
 */
+(NSString*)YasuoImage:(UIImage*)image
{
    //按照宽高比例压缩
    CGSize size=image.size;
    
    image=[UIImage imageWithImage:image Size:CGSizeMake(size.width,size.height)];
    //提交数据
    NSData *IDzhengimgs=UIImageJPEGRepresentation(image, 0.05);
    NSLog(@"我是data的大小222 :%u kb",[IDzhengimgs length]/1024);
    NSString* DataStrings = [IDzhengimgs base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];//图片转
    NSLog(@"我是压缩之后的大小:%u kb",DataStrings.length/512);
    return DataStrings;
}



/**
 加半透明水印
 @param useImage 需要加水印的图片
 @param maskImage 水印
 @returns 加好水印的图片
 */
+ (UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    
    //四个参数为水印图片的位置
    [maskImage drawInRect:rect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}




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
+(UIImage*)ImageWithAddWatermarkImage:(UIImage*)image  text:(NSString*)text  textcolor:(UIColor*)textcolor  Font:(UIFont*)font Point:(CGPoint)point
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 300, 300)];
    [textcolor set];
    [path stroke];
    
    
    
    // 1.绘制原生的图片
    [image drawAtPoint:CGPointZero];
    // 2.给原生的图片添加文字
    NSString *str = text;
    // 创建字典属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    dict[NSFontAttributeName] = font;
    [str drawAtPoint:point withAttributes:dict];
    
    // 3.生成一张图片给我们,从上下文中获取图片
    UIImage *imageWater = UIGraphicsGetImageFromCurrentImageContext();
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return imageWater;
}









/**
 *  截屏
 *
 *  @param view 需要截屏的view
 *
 *  @return 截屏之后的图片
 */
+(UIImage *)saveImage:(UIView *)view
{
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(CGSizeMake(320, 200));
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    [[UIColor blackColor] set];
    
    CGContextFillRect(context, mainRect);
    [view.layer renderInContext:context];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//
///**
// *  给图片增加恩子
// *
// *  @param img   <#img description#>
// *  @param text1 <#text1 description#>
// *
// *  @return <#return value description#>
// */
//+ (UIImage *)addText:(UIImage *)img text:(NSString *)text1
//{
//    //get image width and height
//    int w = img.size.width;
//    int h = img.size.height;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    //create a graphic context with CGBitmapContextCreate
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    // CGContextSetRGBFillColor(context,18/255, 131/255,47/255, 0.7);
//    
//    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
//    CGContextSelectFont(context, "Helvetica", 20, kCGEncodingMacRoman);
//    CGContextSetTextDrawingMode(context, kCGTextFill);
//    // CGContextSetRGBFillColor(context,253/255, 248/255,243/255, 0.7);
//   CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    CGContextShowTextAtPoint(context, w-130, h/14, text, strlen(text));
//    //Create image ref from the context
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];
//}
//




/**
 *  压缩图片----压缩尺寸不是像素点
 *
 *  @param image   图片
 *  @param newSize 尺寸
 *
 *  @return 返回压缩之后的图片
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}



/**
 *  生成pdf-方法1
 *
 *  @param aView     view
 *  @param aFilename 保存pdf路径
 *
 *  @return 返回保存pdf的路径-此时已经保存了
 */
+(NSString*)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    // Creates a mutable data object for updating with binary data, like a byte array
    UIWebView *webView = (UIWebView*)aView;
    NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    
    int height = [heightStr intValue];
    
    // Get the number of pages needed to print. 9 * 72 = 648
    int pages = ceil(height / 648.0);
    
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData( pdfData, CGRectZero, nil );
    CGRect frame = [webView frame];
    for (int i = 0; i < pages; i++) {
        // Check to see if page draws more than the height of the UIWebView
        if ((i+1) * 648 > height) {
            CGRect f = [webView frame];
            f.size.height -= (((i+1) * 648.0) - height);
            [webView setFrame: f];
        }
        
        UIGraphicsBeginPDFPage();
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(currentContext, 72, 72); // Translate for 1" margins
        
        [[[webView subviews] lastObject] setContentOffset:CGPointMake(0, 648 * i) animated:NO];
        [webView.layer renderInContext:currentContext];
    }
    
    UIGraphicsEndPDFContext();
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    [webView setFrame:frame];
    NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
    return documentDirectoryFilename;
}


#pragma mark-生成pdf的另外的方法2


/**
 *  生成pdf方法2
 *
 *  @param aView     view
 *  @param aFilename 保存pdf路径
 *
 *  @return 返回保存的路径-此时已经保存了
 */
-(NSString*)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    // Creates a mutable data object for updating with binary data, like a byte array
    UIWebView *webView = (UIWebView*)aView;
    NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    
    int height = [heightStr intValue];
    //  CGRect screenRect = [[UIScreen mainScreen] bounds];
    //  CGFloat screenHeight = (self.contentWebView.hidden)?screenRect.size.width:screenRect.size.height;
    CGFloat screenHeight = webView.bounds.size.height;
    int pages = ceil(height / screenHeight);
    
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, webView.bounds, nil);
    CGRect frame = [webView frame];
    for (int i = 0; i < pages; i++) {
        // Check to screenHeight if page draws more than the height of the UIWebView
        if ((i+1) * screenHeight  > height) {
            CGRect f = [webView frame];
            f.size.height -= (((i+1) * screenHeight) - height);
            [webView setFrame: f];
        }
        
        UIGraphicsBeginPDFPage();
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        //      CGContextTranslateCTM(currentContext, 72, 72); // Translate for 1" margins
        
        [[[webView subviews] lastObject] setContentOffset:CGPointMake(0, screenHeight * i) animated:NO];
        [webView.layer renderInContext:currentContext];
    }
    
    UIGraphicsEndPDFContext();
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    [webView setFrame:frame];
    
    //返回保存pdf格式的图片的路径
    return documentDirectoryFilename;
}




/**
 *  截取图片
 *
 *  @param image     为需要取的原图片
 *  @param imageview imageview为需要取图的原图片控件
 *  @param rect      rect 为需要取的尺寸
 *
 *  @return 截取图片
 */
-(UIImage *)getNeedImageFrom:(UIImage*)image   imageview:(UIImageView*)imageview cropRect:(CGRect)rect
{
    CGSize cropSize = rect.size;
    CGFloat widthScale = image.size.width/imageview.bounds.size.width;
    CGFloat heightScale = image.size.height/imageview.bounds.size.height;
    
    cropSize = CGSizeMake(rect.size.width*widthScale, rect.size.height*heightScale);
    CGPoint  pointCrop = CGPointMake(rect.origin.x*widthScale, rect.origin.y*heightScale);
    
    rect = CGRectMake(pointCrop.x, pointCrop.y, cropSize.width, cropSize.height);
    
    CGImageRef subImage = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:subImage];
    CGImageRelease(subImage);
    return croppedImage;
    
}





/**
 *  图片裁剪：把正方形图片重新生产一张圆形的图片---绘制MJ
 *
 *  @param image       图片
 *  @param borderWidth 边框宽度
 *  @param color       边框颜色
 *
 *  @return 新的图片
 */
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    // 图片的宽度和高度
    CGFloat imageWH = image.size.width;
    
    // 设置圆环的宽度
    CGFloat border = borderWidth;
    
    // 圆形的宽度和高度
    CGFloat ovalWH = imageWH + 2 * border;
    
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    // 2.画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [color set];
    
    [path fill];
    
    // 3.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [clipPath addClip];
    
    // 4.绘制图片
    [image drawAtPoint:CGPointMake(border, border)];
    
    // 5.获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
    
}




/**
 *  截屏--MJ
 *
 *  @param view 需要截屏的试图
 *
 *  @return 截屏之后的图片
 */
+ (UIImage *)imageWithCaputureView:(UIView *)view
{
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 把控件上的图层渲染到上下文,layer只能渲染
    [view.layer renderInContext:ctx];
    
    // 生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}







/**
 *  截取图片
 *
 *  @param imageview 要截取的imageview
 *  @param rect      截取的Rect
 *
 *  @return 截取之后的图片
 */
+(UIImage*)ImageCapImage:(UIImageView*)imageview   Rect:(CGRect)rect
{
    // 开启上下文
    // 如果不透明，默认超出裁剪区域会变成黑色，通常都是透明
    UIGraphicsBeginImageContextWithOptions(imageview.bounds.size, NO, 0);
    // 设置裁剪区域
    UIBezierPath *path =  [UIBezierPath bezierPathWithRect:rect];
    [path addClip];
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 把控件上的内容渲染到上下文
    [imageview.layer renderInContext:ctx];
    // 生成一张新的图片
    UIImage* newimage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return newimage;
}







/**
 *     使用案例
 *
     - (void)pan:(UIPanGestureRecognizer *)pan
     {
     // 获取当前点
     CGPoint curP = [pan locationInView:self.view];
     // 获取擦除的矩形范围
     CGFloat wh = 20;
     CGFloat x = curP.x - wh * 0.5;
     CGFloat y = curP.y - wh * 0.5;
     CGRect rect = CGRectMake(x, y, wh, wh);
     _imageView.image = [self ImageWitheraserImageView:self.imageView Rect:rect];
     }
 *
 *
 *
 */


/**
 *  擦除部分图片
 *
 *  @param imageview 需要擦的imageviwe
 *  @param rect      擦除的rect
 *
 *  @return 擦除之后的图片
 */
+(UIImage*)ImageWitheraserImageView:(UIImageView*)imageview  Rect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(imageview.bounds.size, NO, 0);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    // 控件的layer渲染上去
    [imageview.layer renderInContext:context];
    
    // 擦除图片
    CGContextClearRect(context, rect);
    
    UIImage* newimage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
    
}




/**
 *  base64 转换图片
 *
 *  @param bases64tring base 64
 *
 *  @return 转换之后的图
 */
+(UIImage *)ImageWithBase64ToUIImage:(NSString *)bases64tring
{
    NSData *_decodedImageData   =[[NSData alloc]initWithBase64EncodedString:bases64tring options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}




/**
 *  图片转base 64字符串
 *
 *  @param image 图片
 *
 *  @return 字符串base 64
 */
+(NSString *)Base64WithUIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}



@end
