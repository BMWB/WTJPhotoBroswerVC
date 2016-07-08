//
//  WTJPhotoModel.m
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/7/6.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import "WTJPhotoModel.h"

@implementation WTJPhotoModel

-(CGRect)sourceFrame{
    return [_sourceImageView convertRect:_sourceImageView.bounds toView:_sourceImageView.window];
}
@end
