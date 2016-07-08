//
//  WTJPhotoModel.h
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/7/6.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WTJPhotoModel : NSObject

/*
 *  网络图片
 */

/** 高清图地址 */
@property (nonatomic,copy) NSString *image_HD_U;

/*
 *  本地图片
 */
@property (nonatomic,strong) UIImage *image;

/** 标题 */
@property (nonatomic,copy) NSString *title;

/** 描述 */
@property (nonatomic,copy) NSString *desc;

/** 源frame */
@property (nonatomic,assign,readonly) CGRect sourceFrame;

/** 源imageView */
@property (nonatomic,weak) UIImageView *sourceImageView;

/** 是否从源frame放大呈现 */
@property (nonatomic,assign) BOOL isFromSourceFrame;

@end
