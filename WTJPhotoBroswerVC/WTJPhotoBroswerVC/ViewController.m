//
//  ViewController.m
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/6/14.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import "ViewController.h"
#import "WTJPhotoBrosweerVC.h"
@interface ViewController ()

@property (nonatomic,strong) NSArray *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    __weak typeof(self) weakSelf=self;
    
    [WTJPhotoBrosweerVC show:self Index:3 photoModelBlock:^NSArray *{
        NSArray *localImages = weakSelf.images;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            WTJPhotoModel *pbModel=[[WTJPhotoModel alloc] init];
            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image = localImages[i];
            
            //源frame

//            pbModel.sourceImageView = localImages[i];
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSArray *)images{
    
    if(_images ==nil){
        NSMutableArray *arrayM = [NSMutableArray array];
        
        for (NSUInteger i=0; i<9; i++) {
            
            UIImage *imagae =[UIImage imageNamed:[NSString stringWithFormat:@"%@",@(i+1)]];
            
            [arrayM addObject:imagae];
        }
        
        _images = arrayM;
    }
    
    return _images;
}
@end
