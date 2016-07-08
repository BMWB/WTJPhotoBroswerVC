//
//  WTJTopBarView.h
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/6/14.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,WTJTopBarType){

    SaveImage,//保存图片
    BackMth,//返回
    DeleteImage//删除图片
};
@interface WTJTopBarView : UIView
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@property (copy,nonatomic) void (^WTJTopBarViewBlock)(WTJTopBarType);
@end
