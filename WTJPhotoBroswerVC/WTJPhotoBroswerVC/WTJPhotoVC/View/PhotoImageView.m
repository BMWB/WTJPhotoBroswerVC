//
//  PhotoImageView.m
//  CorePhotoBroswerVC
//
//  Created by WTJ on 15/5/5.
//  Copyright (c) 2015年 WTJ. All rights reserved.
//

#import "PhotoImageView.h"
#import "UIView+Extend.h"
@interface PhotoImageView ()

/** bounds */
@property (nonatomic,assign) CGRect screenBounds;

/** center*/
@property (nonatomic,assign) CGPoint screenCenter;

/** imageView的双击 */
@property (nonatomic,strong) UITapGestureRecognizer *tap_double_imageViewGesture;

@end


@implementation PhotoImageView




-(void)setImage:(UIImage *)image{
    
    if(image == nil) return;
    
    [super setImage:image];
    
    //确定frame
    [self calFrame];
    
    self.contentMode = UIViewContentModeScaleAspectFit;
    
    if(_ImageSetBlock != nil) _ImageSetBlock(image);

}

/*
 *  imageView单击
 */
-(UITapGestureRecognizer *)tap_double_imageViewGesture{
    
    if(_tap_double_imageViewGesture == nil){
        
        _tap_double_imageViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_double_imageViewTap:)];
        _tap_double_imageViewGesture.numberOfTapsRequired = 2;
    }
    
    return _tap_double_imageViewGesture;
}

-(void)tap_double_imageViewTap:(UITapGestureRecognizer *)tap{


//    BlockCallWithOneArg(self.retHandler, tap);
}


/*
 *  确定frame
 */
-(void)calFrame{
    
    CGSize size = self.image.size;
    
    CGFloat w = size.width;
    CGFloat h = size.height;
    
    CGRect superFrame = self.screenBounds;
    CGFloat superW =superFrame.size.width ;
    CGFloat superH =superFrame.size.height;
    
    CGFloat calW = superW;
    CGFloat calH = superW;
    
    if (w>=h) {//较宽
        
        CGFloat scale = superW / w;
        if(w> superW){//比屏幕宽
            
            
            
            //确定宽度
            calW = w * scale;
            calH = h * scale;
            
        }else if(w <= superW){//比屏幕窄，直接居中显示
        
            calW = superW;
            calH = h * scale;
        }
        
    }else if(w<h){//较高
        
        CGFloat scale1 = superH / h;
        CGFloat scale2 = superW / w;
        
        BOOL isFat = w * scale1 > superW;//比较胖
        
        CGFloat scale =isFat ? scale2 : scale1;
 
        if(h> superH){//比屏幕高
            
            //确定宽度
            calW = w * scale;
            calH = h * scale;

        }else if(h <= superH){//比屏幕窄，直接居中显示
            
            if(w>superW){
                                    
                //确定宽度
                calW = w * scale;
                calH = h * scale;
                    
                
            }else{
                calW = superW;
                calH = h*scale;
            }
            
        }
    }
    
    CGRect frame = [UIView frameWithW:calW h:calH center:self.screenCenter];
    
    self.calF = frame;
}


-(CGRect)screenBounds{
    
    if(CGRectEqualToRect(_screenBounds, CGRectZero)){
        
        _screenBounds = [UIScreen mainScreen].bounds;
    }
    
    return _screenBounds;
}

-(CGPoint)screenCenter{
    if(CGPointEqualToPoint(_screenCenter, CGPointZero)){
        CGSize size = self.screenBounds.size;
        _screenCenter = CGPointMake(size.width * .5f, size.height * .5f);
    }

    return _screenCenter;
}



@end
