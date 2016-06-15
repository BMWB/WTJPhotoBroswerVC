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
@property (weak,nonatomic) PhotoItemView *currentItemView;
@end

@implementation WTJPohotBroswerCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        __weak typeof(self) weakSelf=self;
        if (!_currentItemView) {
            PhotoItemView *photoItemView = [PhotoItemView viewFromXIB];
            photoItemView.frame = self.contentView.bounds;
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

-(void)setPhotoModel:(PhotoModel *)photoModel{

    _photoModel = photoModel;
    [_currentItemView reset];
    _currentItemView.photoModel = _photoModel;
}
@end
