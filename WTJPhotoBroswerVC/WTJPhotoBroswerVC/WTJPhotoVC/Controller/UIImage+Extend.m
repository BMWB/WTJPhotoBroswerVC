

#import "UIImage+Extend.h"
#import <objc/runtime.h>

static const void *CompleteBlockKey = &CompleteBlockKey;
static const void *FailBlockKey = &FailBlockKey;

@interface UIImage ()

@property (nonatomic,copy)  void(^CompleteBlock)();

@property (nonatomic,copy)  void(^FailBlock)();

@end


@implementation UIImage (Extend)


/**
 *  获取启动图片
 */
+(UIImage *)launchImage{
    
    NSString *imageName=@"LaunchImage-700";
    
    if(([UIScreen mainScreen].bounds.size.height==568.0f)) imageName=@"LaunchImage-700-568h";
    
    return [UIImage imageNamed:imageName];
}


/**
 *  根据不同的iphone屏幕大小自动加载对应的图片名
 *  加载规则：
 *  iPhone4:             默认图片名，无后缀
 *  iPhone5系列:          _ip5
 *  iPhone6:             _ip6
 *  iPhone6 Plus:     _ip6p,注意屏幕旋转显示不同的图片不是这个方法能决定的，需要使用UIImage的sizeClass特性决定
 */
+(UIImage *)deviceImageNamed:(NSString *)name{

    NSString *imageName=[name copy];

    //iphone5
    if(([UIScreen mainScreen].bounds.size.height==568.0f)) imageName=[NSString stringWithFormat:@"%@%@",imageName,@"_ip5"];
    
    //iphone6
    if(([UIScreen mainScreen].bounds.size.height==667.0f)) imageName=[NSString stringWithFormat:@"%@%@",imageName,@"_ip6"];
    
    //iphone6 Plus
    if(([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)) imageName=[NSString stringWithFormat:@"%@%@",imageName,@"_ip6p"];

    UIImage *originalImage=[UIImage imageNamed:name];
    
    UIImage *deviceImage=[UIImage imageNamed:imageName];
    
    if(deviceImage==nil) deviceImage=originalImage;

    return deviceImage;
}




/**
 *  拉伸图片
 */
#pragma mark  拉伸图片:自定义比例
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * leftCap topCapHeight:image.size.height * topCap];
}




#pragma mark  拉伸图片
+(UIImage *)resizeWithImageName:(NSString *)name{
    
    return [self resizeWithImageName:name leftCap:.5f topCap:.5f];

}




/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param completeBlock 出错回调
 */
-(void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock{
    
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
    
    self.CompleteBlock = completeBlock;
    self.FailBlock = failBlock;
}




- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error == nil){
        if(self.CompleteBlock != nil) self.CompleteBlock();
    }else{
        if(self.FailBlock !=nil) self.FailBlock();
    }

}



/*
 *  模拟成员变量
 */
-(void (^)())FailBlock{
    return objc_getAssociatedObject(self, FailBlockKey);
}
-(void)setFailBlock:(void (^)())FailBlock{
    objc_setAssociatedObject(self, FailBlockKey, FailBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void (^)())CompleteBlock{
    return objc_getAssociatedObject(self, CompleteBlockKey);
}

-(void)setCompleteBlock:(void (^)())CompleteBlock{
    objc_setAssociatedObject(self, CompleteBlockKey, CompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImage *)remakeImageWithFullSize:(CGSize)fullSize zoom:(CGFloat)zoom{
    
    //新建上下文
    UIGraphicsBeginImageContextWithOptions(fullSize, NO, 0.0);
    
    //图片原本size
    CGSize size_orignal = self.size;
    CGFloat sizeW = size_orignal.width * zoom;
    CGFloat sizeH = size_orignal.height * zoom;
    CGFloat x = (fullSize.width - sizeW) *.5f;
    CGFloat y = (fullSize.height - sizeH) * .5f;
    CGRect rect = CGRectMake(x, y, sizeW, sizeH);
    
    [self drawInRect:rect];
    
    //获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


/*
 *  生成一个默认的占位图片：bundle默认图片
 */
+(UIImage *)phImageWithSize:(CGSize)fullSize zoom:(CGFloat)zoom{
    
    return [[UIImage imageNamed:@"placeholder_photo"] remakeImageWithFullSize:fullSize zoom:zoom];
}
@end
