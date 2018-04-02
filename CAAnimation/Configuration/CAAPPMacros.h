//
//  CAAPPMacros.h
//  CAAnimation
//
//  Created by 李达志 on 2018/3/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#ifndef CAAPPMacros_h
#define CAAPPMacros_h
/** RGB创建Color */
#define RGBColor(r,g,b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0])
#define RGBAColor(r,g,b,a) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a])
/** 16进制色值创建Color  十六进制格式:0xFFFFFF*/
#define HexColor(hex) ([UIColor colorWithRed:((CGFloat)((hex & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hex & 0xFF00)>>8))/255.0 blue:((CGFloat)(hex & 0xFF))/255.0 alpha:1.0])

#define kScreenWidth    [[UIScreen mainScreen] bounds].size.width   // 屏幕宽
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height  // 屏幕高
#define KDeepTextColor  RGBColor(80,80,80) //深色字体颜色（深黑）
#define KLightTextColor  RGBColor(170,170,170) //浅色

#endif /* CAAPPMacros_h */
