//
//  CABasicRealizeController.h
//  CAAnimation
//
//  Created by 李达志 on 2018/3/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CABasicRealizeType) {
    CABasicRealizeType_scale,
    CABasicRealizeType_move,
    CABasicRealizeType_rotation
};
@interface CABasicRealizeController : UIViewController
@property (nonatomic,assign) CABasicRealizeType type;

@end
