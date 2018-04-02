//
//  CABasicRealizeController.m
//  CAAnimation
//
//  Created by 李达志 on 2018/3/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "CABasicRealizeController.h"

@interface CABasicRealizeController ()
@property (nonatomic,strong) UIImageView * demoImageView;
@property (nonatomic,strong) NSArray * titleItems;
@property (nonatomic,strong) NSArray * selItems;
//缩放动画按钮title数组
@property (nonatomic,strong) NSArray * scaleTitleItems;
@property (nonatomic,strong) NSArray * scaleSELItems;

//移动动画
@property (nonatomic,strong) NSArray * moveTitleItems;
@property (nonatomic,strong) NSArray * moveSELItems;
//旋转动画
@property (nonatomic,strong) NSArray * rotationTitleItems;
@property (nonatomic,strong) NSArray * rotationSELItems;
@end

@implementation CABasicRealizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.demoImageView];
    switch (self.type) {
        case CABasicRealizeType_scale:
            [self initScale];
            break;
        case CABasicRealizeType_move:
            [self initMove];
            break;
        case CABasicRealizeType_rotation:
            [self initRotation];
            break;
        default:
            break;
    }
    for (int i=0; i<self.titleItems.count; i++) {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*kScreenWidth/4, 70, kScreenWidth/4, 30);
        [button setTitle:self.titleItems[i] forState:UIControlStateNormal];
        [button setTitleColor:KDeepTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
        [self.view addSubview:button];

    }

}

-(void)initScale{
    self.titleItems=@[@"bounds",@"transform",@"transform.scale",@"CGAffineTransform"];
    self.selItems=@[@"scaleAnimationWithKeyPathBounds",@"scaleAnimationWithKeyPathtransform",@"scaleAnimationWithKeyPathTransformScale",@"uiviewAnimation"];

}
-(void)initMove{
    self.titleItems=@[@"position",@"transform",@"UIView层级"];
    self.selItems=@[@"moveAnimationPosition",@"moveCATransform3D",@"moveViewAnimation"];

}
-(void)initRotation{
    self.titleItems=@[@"rotationTransform",@"rotationLayer",@"rotationCGAff"];
    self.selItems=@[@"rotationTransform",@"rotationLayer",@"rotationCGAff"];
}
-(void)buttonAction:(UIButton*)button{
    [self performSelector:NSSelectorFromString([self.selItems objectAtIndex:button.tag])];

}
-(UIImageView *)demoImageView{
    if (!_demoImageView) {
        _demoImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"i11"]];
        _demoImageView.contentMode=UIViewContentModeScaleAspectFill;
        _demoImageView.frame=CGRectMake(200, 200, 150, 150);
        _demoImageView.center=self.view.center;
        _demoImageView.layer.cornerRadius=75;
        _demoImageView.layer.masksToBounds=YES;
    }
    return _demoImageView;
}

#pragma scale缩放动画

/**
 Bounds
 */
-(void)scaleAnimationWithKeyPathBounds{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds"];
    anim.duration = 2;
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 30, 30)];
    [self.demoImageView.layer addAnimation:anim forKey:nil];
}

/**
 transform
 */
-(void)scaleAnimationWithKeyPathtransform{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    // 动画持续1.5s
    anim.duration = 1.5;
    // CALayer的宽度从0.5倍变为2倍
    // CALayer的高度从0.5倍变为1.5倍
    anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1)];
    anim.toValue  = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 1.5, 1)];
    [self.demoImageView.layer addAnimation:anim forKey:nil];
}

/**
 transform.scale
 */
-(void)scaleAnimationWithKeyPathTransformScale{
        // 创建CABasicAnimation
    CABasicAnimation *anim = [CABasicAnimation animation];

        // 告诉系统修改图层的哪个属性

    anim.keyPath = @"transform.scale";

        // 告诉系统修改图层的哪个值
        //    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    anim.toValue = @0.5;
        // 取消反弹
        // 告诉在动画结束的时候不要移除
    anim.removedOnCompletion = YES;
        // 始终保持最新的效果
    anim.fillMode = kCAFillModeForwards;

    [self.demoImageView.layer addAnimation:anim forKey:nil];
}

/**
 uiview层级
 如果想了解CGAffineTransform参考
 https://www.jianshu.com/p/ca7f9bc62429
 */
-(void)uiviewAnimation{
        // 放大缩小动画
    [UIView animateWithDuration:1 animations:^{
            // 放大
        self.demoImageView.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
                // 缩小
            self.demoImageView.transform = CGAffineTransformMakeScale(0.6, 0.6);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                    // 还原
                self.demoImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }];
    }];
}

#pragma move移动动画
-(void)moveAnimationPosition{

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(250, 500)];
//    anim.delegate = self;
    anim.removedOnCompletion = YES;
    anim.fillMode = kCAFillModeForwards;

    [self.demoImageView.layer addAnimation:anim forKey:nil];
}
-(void)moveCATransform3D{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.duration = 1;
    CATransform3D form = CATransform3DMakeTranslation(350, 350, 0);
    anim.toValue = [NSValue valueWithCATransform3D:form];

    [self.demoImageView.layer addAnimation:anim forKey:nil];
}

/**
 uiview层级移动 移动后保持移动之后的状态
 */
-(void)moveViewAnimation{
    [UIView animateWithDuration:1.5 animations:^{
        self.demoImageView.layer.position=CGPointMake(self.view.center.x, self.view.center.y+100);
    }];
}
#pragma mark rotation
-(void)rotationTransform{
    CABasicAnimation*animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation([self getRadian:180.0], 0 , 0, 0)];
    [self.demoImageView.layer addAnimation:animation forKey:nil];
}

/**
//    直接执行，不会恢复
 */
-(void)rotationLayer{

    self.demoImageView.layer.transform=CATransform3DMakeRotation([self getRadian:360.0], 1, 0,0 );

}

/**
 //    直接执行，不会恢复
 */
-(void)rotationCGAff{
    self.demoImageView.layer.affineTransform= CGAffineTransformMakeRotation([self getRadian:180]);
}
/**
 计算弧度

 @param angle 需要旋转的角度
 @return 弧度
 */
-(CGFloat)getRadian:(CGFloat)angle{
    return ( angle * 3.14159265 ) / 180.0;
}
@end
