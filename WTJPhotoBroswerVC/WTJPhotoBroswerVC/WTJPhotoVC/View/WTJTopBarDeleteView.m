//
//  WTJTopBarDeleteView.m
//  Guru
//
//  Created by wtj on 16/7/7.
//  Copyright © 2016年 com.techwolf.guru. All rights reserved.
//

#import "WTJTopBarDeleteView.h"
@interface WTJTopBarDeleteView()
{
    UIButton *_topBarRightBtn;
}
@end
@implementation WTJTopBarDeleteView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor= [UIColor clearColor];
        CGFloat btnWidth = self.bounds.size.height;
        CGFloat width = self.bounds.size.width;
        
        if (!_topBarRightBtn) {
            _topBarRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(width-btnWidth, 0, btnWidth, btnWidth)];
            [_topBarRightBtn setImage:[UIImage imageNamed:@"ic_title_delete_arrow"] forState:UIControlStateNormal];
           
            [_topBarRightBtn addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_topBarRightBtn];
        }
    }
    
    return self;
}

-(void)deleteImage{
    
    if (self.WTJTopBarViewBlock) {
        self.WTJTopBarViewBlock(DeleteImage);
    }
    
}

@end
