//
//  ShopCell.m
//  02_瀑布流
//
//  Created by Jimmy on 16/3/10.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "ShopCell.h"
#import "UIImageView+WebCache.h"
#import "HMShop.h"
@interface ShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *shopImageVeiw;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation ShopCell

- (void)setShop:(HMShop *)shop
{
    [self.shopImageVeiw sd_setImageWithURL:[NSURL URLWithString:shop.img
                                            ] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.nameLabel.text = shop.price;
}
@end
