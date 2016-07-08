//
//  PhotoImageView.h
//  CorePhotoBroswerVC
//
//  Created by WTJ on 15/5/5.
//  Copyright (c) 2015年 WTJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EventHandler)(id sender);
@interface PhotoImageView : UIImageView

/** 设置图片后的回调 */
@property (nonatomic,copy) void (^ImageSetBlock)(UIImage *image);


@property (nonatomic,assign) CGRect calF;

@property (nonatomic,copy)   EventHandler       retHandler;

@end
