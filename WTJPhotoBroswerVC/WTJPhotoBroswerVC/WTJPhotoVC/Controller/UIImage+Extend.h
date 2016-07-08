

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

/**
 *  拉伸图片:自定义比例
 */
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;





/**
 *  拉伸图片
 */
+(UIImage *)resizeWithImageName:(NSString *)name;


/**
 *  获取启动图片
 */
+(UIImage *)launchImage;




/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param completeBlock 出错回调
 */
-(void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock;



-(UIImage *)remakeImageWithFullSize:(CGSize)fullSize zoom:(CGFloat)zoom;

/*
 *  生成一个默认的占位图片：bundle默认图片
 */
+(UIImage *)phImageWithSize:(CGSize)fullSize zoom:(CGFloat)zoom;
@end
