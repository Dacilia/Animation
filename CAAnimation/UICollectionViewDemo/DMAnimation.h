//
//  DMAnimation.h
//  UIcollectionViewDemo
//
//  Created by 李达志 on 2018/3/3.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DMAnimation : NSObject

/**
 抖动效果

 @param originView 传入的view
 */
+(void)vibrateAnimation:(UIView *)originView;
/**
 *  Delete cell with fadeAnimation
 *
 *  @param AniView UICollectionViewCell
 */
+ (void)fadeAnimation:(UIView *)AniView;

/**
 *  Delete cell with rotateAnimation
 *
 *  @param AniView UICollectionViewCell
 */
+ (void)rotateAnimation:(UIView *)AniView;

/**
 *  Delete cell with suckEffectAnimation
 *
 *  @param AniView UICollectionViewCell
 */
+ (void)suckEffectAnimation:(UIView *)AniView;

/**
 *  Delete cell with pushAnimation
 *
 *  @param AniView UICollectionViewCell
 */
+ (void)pushAnimation:(UIView *)AniView;

/**
 *  Delete cell with rippleEffectAnimation
 *
 *  @param AniView UICollectionViewCell
 */
+ (void)rippleEffectAnimation:(UIView *)AniView;

/**
 * cube立方体翻滚的效果
 *
 */
+ (void)cubeEffectAnimation:(UIView *)AniView;

/**
 *  Delete cell with oglFlipAnimation
 *
 *  @param AniView UICollectionViewCell
 */
+ (void)oglFlipAnimation:(UIView *)AniView;
/**
 点击删除按钮执行的步骤 是一个动画组

 @param originiView 传入的view
 */
+ (void)toMiniAnimation:(UIView *)originiView;
@end
