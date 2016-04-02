//
//  ImagesCell.m
//  01_自定义collectionview布局
//
//  Created by Jimmy on 16/3/8.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "ImagesCell.h"
@interface ImagesCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImagesCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.layer.borderWidth = 3;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.clipsToBounds = NO;
    self.imageView.layer.cornerRadius = 5;
}
- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:_imageName];
}
@end
