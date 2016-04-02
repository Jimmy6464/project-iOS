//
//  LineLayout.m
//  01_自定义collectionview布局
//
//  Created by Jimmy on 16/3/8.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "LineLayout.h"
static const CGFloat linelayoutItemWH = 100;
/**
 *  缩放因素 值越大缩放越小
 */
static const CGFloat ActiveDistance = 150;
@implementation LineLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
//        //初始化
//        //每个cell的尺寸
//        self.itemSize = CGSizeMake(linelayoutItemWH, linelayoutItemWH);
//        //设置水平滚动
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        self.minimumLineSpacing = 100;
//        CGFloat inset = (self.collectionView.frame.size.width - linelayoutItemWH)*0.5;
//        self.sectionInset = UIEdgeInsetsMake(0, 0, inset, inset)
//        ;
        //UICollectionViewLayoutAttributes 布局属性，
        //1.每一个cell (item)都有自己的UICollectionViewLayoutAttributes
        //2.每一个indexPath都有自己的UICollectionViewLayoutAttributes

        
    }
    return self;
}
/**
 *  用来设置scrollview停止滚动那一刻的位置
 *
 *  @param proposedContentOffset 原本scrollview停止滚动那一刻的位置
 *
 *  @param velocity 滚动速度
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //1.计算出scrollview最后会停留的范围
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    //计算屏幕最中间的x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width*0.5;
    //2.取出这个范围内的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    //3.遍历所有属性
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in array) {
        if(ABS(attr.center.x - centerX) < ABS(adjustOffsetX)){
            adjustOffsetX = attr.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x+adjustOffsetX, proposedContentOffset.y);
}
/**
 *  一些初始化工作最好在这里实现
 */
- (void)prepareLayout
{
    //初始化
    //每个cell的尺寸
    self.itemSize = CGSizeMake(linelayoutItemWH, linelayoutItemWH);
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 100;
    CGFloat inset = (self.collectionView.frame.size.width - linelayoutItemWH)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset)
    ;
    //UICollectionViewLayoutAttributes 布局属性，
    //1.每一个cell (item)都有自己的UICollectionViewLayoutAttributes
    //2.每一个indexPath都有自己的UICollectionViewLayoutAttributes
}
/**
 *  只要显示的边界发生改变就重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
 *
 *  @param newBounds newbounds
 *
 *  @return bool
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //计算可见的矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    //1.取出默认的cell的UICollectionViewLayoutAttributes
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算屏幕最中间的x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width*0.5;
    //2.遍历所有的布局属性
    for (UICollectionViewLayoutAttributes *attributes in array) {
        //如果不是可见的
        if(!CGRectIntersectsRect(visiableRect, attributes.frame)){
            continue;
        }
        //每一个item的中点x
        CGFloat itemCenterX = attributes.center.x;
        //差距越小，缩放比例越大
        //根据屏幕最中间的距离计算缩放比例
//        if (ABS(itemCenterX-centerX) <= 150) {
//            <#statements#>
//        }
        CGFloat scale = 0.7*(1-(ABS(itemCenterX-centerX)/100)) + 1;
        attributes.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
    
    }
    NSLog(@"%s",__func__);
    return array;
}
@end
