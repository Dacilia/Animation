//
//  DMTestCell.m
//  UIcollectionViewDemo
//
//  Created by 李达志 on 2018/3/2.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "DMTestCell.h"
#import "DMAnimation.h"
@implementation DMTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClick)];
    [self addGestureRecognizer:lpgr];
}
-(void)longClick{
    if ([self.delegate respondsToSelector:@selector(showAllDeleteBtn)]) {
        [self.delegate showAllDeleteBtn];
    }
}
- (IBAction)delectButtonAction:(id)sender {
    [DMAnimation toMiniAnimation:self];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([self.delegate respondsToSelector:@selector(deleteCellAtIndexpath:cellView:)]) {
        [self.delegate deleteCellAtIndexpath:self.indexPath cellView:self];
    }
}
@end
