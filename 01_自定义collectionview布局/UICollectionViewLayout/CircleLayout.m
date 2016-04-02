//
//  CircleLayout.m
//  01_自定义collectionview布局
//
//  Created by Jimmy on 16/3/10.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "CircleLayout.h"

@implementation CircleLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray new];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0 ; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] ];
        [array addObject:attrs];
    }
    return array;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(50, 50);
    //圆的半径
    CGFloat radius = 70;
    //圆的中心点
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width*0.5, self.collectionView.frame.size.height*0.5);
    //每个item之间的角度
    CGFloat circlesAngleDelta = M_PI * 2/ [self.collectionView numberOfItemsInSection:0];
    
    //计算当前item的角度
    CGFloat itemAngle = indexPath.item * circlesAngleDelta;
    
    attrs.center =  CGPointMake(circleCenter.x + radius*cosf(itemAngle), circleCenter.y-radius*sinf(itemAngle));
    attrs.zIndex = indexPath.item;
    
    return attrs;
}
@end
