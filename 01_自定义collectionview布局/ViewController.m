//
//  ViewController.m
//  01_自定义collectionview布局
//
//  Created by Jimmy on 16/3/8.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "ViewController.h"
#import "ImagesCell.h"
#import "LineLayout.h"
#import "StackLayout.h"
#import "CircleLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong)NSMutableArray *images;
@property (nonatomic, weak)UICollectionView *collectionView;
@end
static  NSString *const ID = @"images";
@implementation ViewController
- (NSMutableArray *)images
{
    if (!_images) {
        self.images = [NSMutableArray new];
        for (int i=1; i<= 20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = self.view.frame.size.width;
    CGRect rect = CGRectMake(0, 100, w, 200);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[StackLayout new]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ImagesCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    //collectionviewlayout
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[StackLayout class]]) {
        [self.collectionView setCollectionViewLayout:[LineLayout new] animated:YES];
    }else {
        [self.collectionView setCollectionViewLayout:[StackLayout new] animated:YES];
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.imageName = self.images [indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1.删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    //2.刷新UI
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
@end
