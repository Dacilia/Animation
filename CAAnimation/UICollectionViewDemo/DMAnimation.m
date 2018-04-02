//
//  DMAnimation.m
//  UIcollectionViewDemo
//
//  Created by 李达志 on 2018/3/3.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "DMAnimation.h"
/**
 CATransition 转场动画的私有效果
 转场动画CATransition   有两个基本的属性 type  和  subtype  分别是设置动画类型（类型如上）和动画方向（有的动画显而易见没有动画方向，就不能设置了）
fade交叉淡化 过度的效果
push 新视图把旧视图推出去
moveIn新视图移到旧视图上面
reveal将旧视图移开，显示新视图
cube立方体翻滚的效果
oglFlip上下左右翻转的效果
suckEffect收缩效果，如一块布被抽走
rippleEffect水滴效果（像是在屏幕上滴了一滴水，然后泛起一下涟漪）
pageCurl向上翻页效果
pageUnCurl向下翻页效果
cameraIrisHollowOpen相机镜头打开效果
cameraIrisHollowClose相机镜头关闭效果
 */
@implementation DMAnimation{
    BOOL isShowDelectButton;
}
+(void)vibrateAnimation:(UIView *)AniView{
    CAKeyframeAnimation *rvibrateAni = [CAKeyframeAnimation animation];
    rvibrateAni.keyPath = @"transform.rotation";
    // rvibrateAni.delegate=AniView;
    CGFloat angle = M_PI_4/18;
    rvibrateAni.values = @[@(-angle),@(angle),@(-angle)];
    rvibrateAni.repeatCount = MAXFLOAT;
    [AniView.layer addAnimation:rvibrateAni forKey:@"shake"];
    
}
+ (void)fadeAnimation:(UIView *)AniView{
    CATransition *animation = [CATransition animation];
        //    animation.delegate = AniView;
    animation.type = @"fade";
    animation.subtype = @"fromTop";
    animation.duration = 1.1;
    [animation setValue:@"fade" forKey:@"animType"];
    [AniView.layer addAnimation:animation forKey:nil];
        //    AniView.hidden = YES;
}

+ (void)rotateAnimation:(UIView *)AniView{
    CATransition *animation = [CATransition animation];
        //    animation.delegate = AniView;
    animation.type = @"rotate";
    animation.subtype = @"fromTop";
    animation.duration = 1.1;
    animation.repeatCount=1;
    [animation setValue:@"rotate" forKey:@"animType"];
    [AniView.layer addAnimation:animation forKey:nil];
        //    AniView.hidden = YES;
}

+ (void)suckEffectAnimation:(UIView *)AniView{
    CATransition *animation = [CATransition animation];
        //    animation.delegate = AniView;
    animation.type = @"suckEffect";
    animation.subtype = @"fromTop";
    animation.duration = 1.3;
    [animation setValue:@"suckEffect" forKey:@"animType"];
    [AniView.layer addAnimation:animation forKey:nil];
        //    AniView.hidden = YES;
}

+ (void)pushAnimation:(UIView *)AniView{
    CATransition *animation = [CATransition animation];
        //    animation.delegate = AniView;
    animation.type = @"push";
    animation.subtype = @"fromTop";
    animation.duration = 1.1;
    [animation setValue:@"push" forKey:@"animType"];
    [AniView.layer addAnimation:animation forKey:nil];
        //    AniView.hidden = YES;
}

+ (void)rippleEffectAnimation:(UIView *)AniView{
    CATransition *animation = [CATransition animation];
        //    animation.delegate = AniView;
    animation.type = @"rippleEffect";
    animation.subtype = @"fromTop";
    animation.duration = 2.2;
    [animation setValue:@"rippleEffect" forKey:@"animType"];
    [AniView.layer addAnimation:animation forKey:nil];
        //    AniView.hidden = YES;
}

+ (void)cubeEffectAnimation:(UIView *)AniView{
    CATransition *animation = [CATransition animation];
        //    animation.delegate = AniView;
    animation.type = @"cube";
    animation.subtype = @"fromRight";
    animation.duration = 1.1;
    [animation setValue:@"cubeEffect" forKey:@"animType"];
    [AniView.layer addAnimation:animation forKey:nil];
        //    AniView.hidden = YES;
}

+ (void)oglFlipAnimation:(UIView *)AniView{
    CATransition *animation = [CATransition animation];
        //    animation.delegate = AniView;
    animation.type = @"oglFlip";
    animation.subtype = @"fromTop";
    animation.duration = 1.1;
    [animation setValue:@"oglFlip" forKey:@"animType"];
    [AniView.layer addAnimation:animation forKey:nil];
        //    AniView.hidden = YES;

}
+ (void)toMiniAnimation:(UIView *)originiView {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = originiView;
    CABasicAnimation *rotationAni = [CABasicAnimation animation];
    rotationAni.keyPath = @"transform.rotation";
    rotationAni.toValue = @(M_PI_2*3);

    CABasicAnimation *scaleAni = [CABasicAnimation animation];
    scaleAni.keyPath = @"transform.scale";
    scaleAni.toValue = @(0.03);

    group.duration = 1.0;
    group.animations = @[rotationAni, scaleAni];
    [group setValue:@"toMini" forKey:@"animType"];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [originiView.layer addAnimation:group forKey:nil];
}
@end
