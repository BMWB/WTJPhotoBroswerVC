//
//  WTJTopBarView.m
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/6/14.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import "WTJTopBarView.h"
@interface WTJTopBarView()
{
    UIButton *_topBarLeftBtn;
    UILabel *_topBarLabel;
}
@end
@implementation WTJTopBarView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor= [UIColor clearColor];
        CGFloat btnWidth = self.bounds.size.height;
        
        if (!_topBarLabel) {
            _topBarLabel = [[UILabel alloc] init];
            _topBarLabel.frame = self.bounds;
            _topBarLabel.backgroundColor = [UIColor clearColor];
            _topBarLabel.textColor = [UIColor whiteColor];
            _topBarLabel.textAlignment = NSTextAlignmentCenter;
            _topBarLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [self addSubview:_topBarLabel];
        }
        
        if (!_topBarLeftBtn) {
            _topBarLeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnWidth, btnWidth)];
            [_topBarLeftBtn setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
            [_topBarLeftBtn addTarget:self action:@selector(backMth) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_topBarLeftBtn];
        }

    }
    
    return self;
}

-(void)backMth{
    
    if (self.WTJTopBarViewBlock) {
        self.WTJTopBarViewBlock(BackMth);
    }
    
}


-(void)saveImage{
    
    if (self.WTJTopBarViewBlock) {
        self.WTJTopBarViewBlock(SaveImage);
    }
}

-(void)setPhotos:(NSArray *)photos{
    _photos = photos;
    _topBarLabel.hidden =_photos.count <=1?YES:NO;
    
}

-(void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex{

    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _topBarLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_currentPhotoIndex + 1, (int)_photos.count];
    
    
}
@end
