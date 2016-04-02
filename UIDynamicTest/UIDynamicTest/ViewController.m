//
//  ViewController.m
//  UIDynamicTest
//
//  Created by Jimmy on 16/3/7.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//红色的view
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@end

@implementation ViewController
- (UIDynamicAnimator *)animator
{
    if (_animator == nil) {
        //1.创建仿真器，并且指定仿真范围
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)testUIDynamic
{
    

    NSArray *items = @[self.redView,self.blueView];
    //1.1创建重力仿真行为，并且指定仿真元素
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[self.redView]];
    //1.1.1设置重力角度(弧度,默认M_PI_2)
    gravity.angle = M_PI_2;
    
    //1.1.2设置重力大小
//    gravity.magnitude = 10.0;
    
    //1.1.3设置向量
    gravity.gravityDirection = CGVectorMake(10.0, 4.0);
    
    //1.2创建碰撞行为，并且指定仿真元素
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:items];
    //1.2.1将仿真器的bounds作为碰撞的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //2.将仿真行为添加到仿真器中，开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
    
}
- (void)testCollision
{
    //1.1创建重力仿真行为，并且指定仿真元素
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[self.redView]];
    
    //1.2创建碰撞行为，并且指定仿真元素
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView]];
    //1.2.1将仿真器的bounds作为碰撞的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //1.2.2 添加边界
    CGPoint starPoint = CGPointMake(0, 300);
    CGPoint endPoint =  CGPointMake(320, 300);
    //identifier用作移除
    [collision addBoundaryWithIdentifier:@"line" fromPoint:starPoint toPoint:endPoint];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 320, 320)];
    //1.2.3
    [collision addBoundaryWithIdentifier:@"" forPath:bezierPath];
    //2.将仿真行为添加到仿真器中，开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];

}
- (void)gravityAndCollision
{
    //1.1创建重力仿真行为，并且指定仿真元素
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[self.redView]];
    
    //1.2创建碰撞行为，并且指定仿真元素
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView]];
    //1.2.1将仿真器的bounds作为碰撞的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    //2.将仿真行为添加到仿真器中，开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}
- (void)gravity
{
    //1.创建仿真器，并且指定仿真范围
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    _animator = animator;
    
    //2.创建重力仿真行为，并且指定仿真元素
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[self.redView]];
    
    //3.将仿真行为添加到仿真器中，开始仿真
    [animator addBehavior:gravity];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testUIDynamic];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
