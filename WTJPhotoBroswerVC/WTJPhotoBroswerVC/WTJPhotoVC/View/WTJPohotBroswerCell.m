//
//  WTJPohotBroswerCell.m
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/6/14.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import "WTJPohotBroswerCell.h"
#import "UIView+Extend.h"
@interface WTJPohotBroswerCell()

@end

@implementation WTJPohotBroswerCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        __weak typeof(self) weakSelf=self;
        self.contentView.backgroundColor =[UIColor blackColor];
        if (!_currentItemView) {
        
            PhotoItemView *photoItemView = [PhotoItemView viewFromXIB];
            photoItemView.frame = CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height);
            photoItemView.zoomScale = 2.f;
            __weak typeof(photoItemView) weakphotoItemView=photoItemView;
            
            photoItemView.ItemViewSingleTapBlock= ^(){
                
                [weakphotoItemView handleBotoomView];
                if (weakSelf.ItemViewSingleTapBlock) {
                    weakSelf.ItemViewSingleTapBlock();
                }
                
            };
            
            [self.contentView addSubview:photoItemView];
            self.currentItemView = photoItemView;
        }
        
    }
    return self;
}

-(void)setPhotoModel:(WTJPhotoModel *)photoModel{
    
    _photoModel = photoModel;
    _currentItemView.photoModel = _photoModel;
}
@end
