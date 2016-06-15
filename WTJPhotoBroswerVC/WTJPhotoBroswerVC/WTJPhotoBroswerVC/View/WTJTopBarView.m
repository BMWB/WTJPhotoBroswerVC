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
    UIButton *_topBarRightBtn;
    UIButton *_topBarLeftBtn;
    UILabel *_topBarLabel;
    
}
@end
@implementation WTJTopBarView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor= [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        CGFloat btnWidth = self.bounds.size.height;
        CGFloat width = self.bounds.size.width;
        
        if (!_topBarLabel) {
            _topBarLabel = [[UILabel alloc] init];
            _topBarLabel.font = [UIFont systemFontOfSize:20];
            _topBarLabel.frame = self.bounds;
            _topBarLabel.backgroundColor = [UIColor clearColor];
            _topBarLabel.textColor = [UIColor whiteColor];
            _topBarLabel.textAlignment = NSTextAlignmentCenter;
            _topBarLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [self addSubview:_topBarLabel];
        }
        
        if (!_topBarLeftBtn) {
            _topBarLeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnWidth, btnWidth)];
            [_topBarLeftBtn setImage:[UIImage imageNamed:@"PB.bundle/back_arrow"] forState:UIControlStateNormal];
            [_topBarLeftBtn setImage:[UIImage imageNamed:@"PB.bundle/back_arrow"] forState:UIControlStateHighlighted];
            [_topBarLeftBtn addTarget:self action:@selector(backMth) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_topBarLeftBtn];
        }
        
        if (!_topBarRightBtn) {
            _topBarRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(width-btnWidth, 0, btnWidth, btnWidth)];
            [_topBarRightBtn setImage:[UIImage imageNamed:@"PB.bundle/preview_save_icon"] forState:UIControlStateNormal];
            [_topBarRightBtn setImage:[UIImage imageNamed:@"PB.bundle/preview_save_icon_highlighted"] forState:UIControlStateHighlighted];
            [_topBarRightBtn setImage:[UIImage imageNamed:@"PB.bundle/preview_save_icon_disable"] forState:UIControlStateDisabled];
            [_topBarRightBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_topBarRightBtn];
        }
    }
    
    return self;
}

-(void)backMth{
    
    if (self.WTJTopBarViewBlock) {
        self.WTJTopBarViewBlock(BackMth);
    }
    
    NSLog(@"后退");
}


-(void)saveImage{
    
    if (self.WTJTopBarViewBlock) {
        self.WTJTopBarViewBlock(SaveImage);
    }
    NSLog(@"保存");
    
}

-(void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex{

    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _topBarLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_currentPhotoIndex + 1, (int)_photos.count];
    
    
}
@end
