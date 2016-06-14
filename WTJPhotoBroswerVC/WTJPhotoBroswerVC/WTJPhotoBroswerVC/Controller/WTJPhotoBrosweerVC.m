//
//  WTJPhotoBrosweerVC.m
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/6/14.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import "WTJPhotoBrosweerVC.h"
#import "WTJPohotBroswerCell.h"
#import "WTJTopBarView.h"
@interface WTJPhotoBrosweerVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 外部操作控制器 */
@property (nonatomic,weak) UIViewController *handleVC;
/** 相册数组 */
@property (nonatomic,strong) NSArray *photoModels;
// 显示图片的collectionView
@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) WTJTopBarView *topBarView;
@end

@implementation WTJPhotoBrosweerVC
+(void)show:(UIViewController *)handleVC Index:(NSUInteger)index photoModelBlock:(NSArray *(^)())photoModelBlock{

    //取出相册数组
    NSArray *photoModels = photoModelBlock();
    
    WTJPhotoBrosweerVC *pbVC = [[self alloc] init];
    pbVC.photoModels = photoModels;
    pbVC.handleVC = handleVC;
    [pbVC show];
}

-(void)show{
    
    [self.handleVC presentViewController:self animated:YES completion:nil];
    
}

#pragma mark - lefe cycle

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.topBarView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -priteMth
-(void)singleTap{

    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    WTJPohotBroswerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WTJPhotoBroswerCellKey forIndexPath:indexPath];
    [cell.currentItemView reset];
    PhotoModel *pbModel = self.photoModels[indexPath.row];
    cell.currentItemView.photoModel = pbModel;
    cell.ItemViewSingleTapBlock = ^(){
    
        NSLog(@"--点击－－");
    };
    
    return cell;
}
    
#pragma mark - UICollectionViewDelegate

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSLog(@"%s",__FUNCTION__);
//}

#pragma mark - setter and getter

-(UICollectionViewFlowLayout *)flowLayout{
    
    if (!_flowLayout) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        [_flowLayout setItemSize:CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height)];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _flowLayout;
}


-(UICollectionView *)mainView{
    
    if (!_mainView) {
        
        _mainView= [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _mainView.backgroundColor = [UIColor clearColor];
        _mainView.pagingEnabled = YES;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.showsVerticalScrollIndicator = NO;
        [_mainView registerClass:[WTJPohotBroswerCell class] forCellWithReuseIdentifier:WTJPhotoBroswerCellKey];
        _mainView.dataSource = self;
        _mainView.delegate = self;
    }
    
    return _mainView;
}

-(WTJTopBarView *)topBarView{


    if (!_topBarView) {
        _topBarView = [[WTJTopBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
        
    }
    
    return _topBarView;
}

-(void)setPhotoModels:(NSArray *)photoModels{
    _photoModels = photoModels;
    [self.mainView reloadData];
}
@end
