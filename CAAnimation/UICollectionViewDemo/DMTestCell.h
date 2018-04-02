//
//  DMTestCell.h
//  UIcollectionViewDemo
//
//  Created by 李达志 on 2018/3/2.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DMTestCell;
@protocol DMTestCellDelegate <NSObject>
-(void)deleteCellAtIndexpath:(NSIndexPath *)indexPath cellView:(DMTestCell *)cell;
-(void)showAllDeleteBtn;
-(void)hideAllDeleteBtn;
@end

static NSString * const KIDDMTestCell=@"KIDDMTestCell";
@interface DMTestCell : UICollectionViewCell<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *delectButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) void (^delectActionBlock)(NSIndexPath*indexPath);
@property (nonatomic,weak) id<DMTestCellDelegate>delegate;
@end
