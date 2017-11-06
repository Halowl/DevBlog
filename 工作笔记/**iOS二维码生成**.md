# **iOS二维码生成**
![](media/15064105430567/15064105489541.jpg)

### 相关推荐
**[iOS二维码生成]()**
**[iOS二维码扫描]()**
**[iOS二维码识别]()**
**[iOS二维码优化]()**
**[iOS二维码其它]()**

> 项目中经常会用到二维码,常见的二维码使用有,扫描,生成,识别,闪光灯.这个系列主要记录下二维码相关的笔记.
> 有关二维码的生成原理,可以参考这篇文章[二维码的生成细节和原理](https://coolshell.cn/articles/10590.html)

### 二维码生成
> 主要可分为生成黑白颜色的二维码,彩色的二维码,艺术二维码,中间带Logo的二维码等.

- 普通二维码
	- 生成二维码主要以下几个步骤
		1. 创建CIFilter对象,设置相关属性
		2. 根据CIFilter对象生成CIImage
		3. 放大并绘制二维码
		4. 翻转图片 
		
```
/** 生成指定大小的黑白二维码 */
- (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    // 1. 创建CIFilter对象,设置相关属性
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜默认设置
    [filter setDefaults];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 2. 根据CIFilter对象生成CIImage
    CIImage *qrImage = qrFilter.outputImage;
    // 3. 放大并绘制二维码 (上面生成的二维码很小，需要放大)
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    // 4.翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return codeImage;
}
```
		
	- 这里简单介绍下CIFilter用来表示CoreImage提供的各种滤镜,滤镜使用键-值来设置输入值，这些值设置好之后，CIFilter就可以用来生成新的CIImage输出图像。这里的输出的图像不会进行实际的图像渲染。(系统默认已经默认导入CoreImage框架)`
		

- 彩色二维码
	- 彩色二维码其实设置`CIFilter`的属性,改变其颜色
	
```
/** 为二维码改变颜色 */
- (UIImage *)changeColorForQRImage:(UIImage *)image backColor:(UIColor *)backColor frontColor:(UIColor *)frontColor
{
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",[CIImage imageWithCGImage:image.CGImage],
                             @"inputColor0",[CIColor colorWithCGColor:frontColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:backColor.CGColor],
                             nil];
    
    return [UIImage imageWithCIImage:colorFilter.outputImage];
}
```

- 带Logo的二维码
	-  带Logo的二维码其实就是在二维码上面添加一个图片.

1#
		
```
/**
 6.生成二维码
 
 - parameter size:            大小
 - parameter color:           颜色
 - parameter bgColor:         背景颜色
 - parameter logo:            图标
 - parameter radius:          圆角
 - parameter borderLineWidth: 线宽
 - parameter borderLineColor: 线颜色
 - parameter boderWidth:      带宽
 - parameter borderColor:     带颜色
 
 - returns: 自定义二维码
 */
-(UIImage*)generateQRCodeWithSize:(CGFloat)size
                            color:(UIColor*)color
                          bgColor:(UIColor*)bgColor
                             logo:(UIImage*)logo
                           radius:(CGFloat)radius
                  borderLineWidth:(CGFloat)borderLineWidth
                  borderLineColor:(UIColor*)borderLineColor
                       boderWidth:(CGFloat)boderWidth
                      borderColor:(UIColor*)borderColor
{
    CIImage* ciImage = [self generateCIImageWithSize:size color:color bgColor:bgColor];
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    if (!logo) return image;
    if (!image) return nil;
    
    CGFloat logoWidth = image.size.width/4;
    CGRect logoFrame = CGRectMake((image.size.width - logoWidth) /  2,(image.size.width - logoWidth) / 2,logoWidth,logoWidth);
    
    // 绘制logo
    UIGraphicsBeginImageContextWithOptions(image.size, false, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    //线框
    UIImage *logoBorderLineImagae = [logo getRoundRectImageWithSize:logoWidth radius:radius borderWidth:borderLineWidth borderColor:borderLineColor];
    //边框
     UIImage *logoBorderImagae = [logoBorderLineImagae getRoundRectImageWithSize:logoWidth radius:radius borderWidth:boderWidth borderColor:borderColor];
    
    [logoBorderImagae drawInRect:logoFrame];
    
    UIImage *QRCodeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return QRCodeImage;
}
```
	
	
2#
	 - 其实就是添加自定义的View然后通过截图生成图片

```
/** 在二维码中心加一个小图 */
- (UIImage *)addSmallImageForQRImage:(UIImage *)qrImage
{
    
    UIView *view = [[UIView alloc]init];
    view.frame = self.imageView.bounds;
    
    [self.view addSubview:view];

    UIImageView *imgV = [[UIImageView alloc]initWithImage:qrImage];
    imgV.frame = view.bounds;
    [view addSubview:imgV];
    
    UIImage *image = [UIImage imageNamed:@"IMG_0809"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth = 2;
    imageView.layer.cornerRadius = 10;
    imageView.frame = CGRectMake(0, 0, 70, 70);
    imageView.center = view.center;
    [view addSubview:imageView];
    
    UIImage *result = [self screenShot:view];
    
    [view removeFromSuperview];
    
    return result;
}


- (UIImage *)screenShot:(UIView*)view {
    if (view && view.frame.size.height && view.frame.size.width) {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;  
    } else {   
        return nil;
    } 
}

```

- 艺术二维码
	- 关于艺术二维码,不是太懂,可以参考以下资料
	- [EFQRCode](https://github.com/EyreFree/EFQRCode)
	- [怎样制作动态艺术二维码？](https://www.zhihu.com/question/46587018)

