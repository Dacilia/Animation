//
//  ViewController.m
//  UIcollectionViewDemo
//
//  Created by 李达志 on 2018/3/2.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "ViewController.h"
#import "DMTestCell.h"
#import "DMRectangleFlowLayout.h"
#import "CircleLayout.h"
#import "CustomFlowLayout.h"
#import "DMAnimation.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DMTestCellDelegate>
@property (nonatomic,strong) UICollectionView*collectionView;
@property (nonatomic,strong)  NSMutableArray * itemsArray;
@property (nonatomic,strong)  CircleLayout *circleLayout;
@property (nonatomic,strong)   DMRectangleFlowLayout*rectangleFlowLayout;
@property (nonatomic,strong)  CustomFlowLayout * customFlowLayout;
@property (nonatomic,strong)  UICollectionViewFlowLayout * systemLayout;
@end

@implementation ViewController{
    BOOL isShowDelectButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    for (int i=1; i<26; i++) {
        
        UIImage*image=[UIImage imageNamed:[NSString stringWithFormat:@"i%d",i]];
        [self.itemsArray addObject:image];
        
    }

}
#pragma mark DMTestCellDelegate
-(void)showAllDeleteBtn{
    isShowDelectButton=YES;
    [self.collectionView reloadData];
    
}
-(void)hideAllDeleteBtn{
    isShowDelectButton=NO;
}
-(NSMutableArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray=[NSMutableArray array];
    }
    return _itemsArray;
}
-(CircleLayout *)circleLayout{
    if (!_circleLayout) {
        _circleLayout=[[CircleLayout alloc]init];
        
    }
    return _circleLayout;
}
-(CustomFlowLayout *)customFlowLayout{
    if (!_customFlowLayout) {
        _customFlowLayout=[[CustomFlowLayout alloc]init];
        _customFlowLayout.itemSize=CGSizeMake(150, 150);
    }
    return _customFlowLayout;
}
-(DMRectangleFlowLayout *)rectangleFlowLayout{
    if (!_rectangleFlowLayout) {
        _rectangleFlowLayout=[[DMRectangleFlowLayout alloc]init];
    _rectangleFlowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    }
    return _rectangleFlowLayout;
}
-(UICollectionViewFlowLayout *)systemLayout{
    if (!_systemLayout) {
        _systemLayout=[[UICollectionViewFlowLayout alloc]init];
        _systemLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    }
    return _systemLayout;
}
-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.systemLayout];
        _collectionView.dataSource                      = self;
        _collectionView.delegate                        = self;
        _collectionView.showsVerticalScrollIndicator    = NO;
        _collectionView.showsHorizontalScrollIndicator  = NO;
        _collectionView.scrollEnabled                   = YES;
        _collectionView.backgroundColor                 = [UIColor whiteColor];
//        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//        [_collectionView addGestureRecognizer:longPressGesture];
        [_collectionView registerNib:[UINib nibWithNibName:@"DMTestCell" bundle:nil] forCellWithReuseIdentifier:KIDDMTestCell];

    }
    return _collectionView;
}
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
        //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        //根据长按手势的状态进行处理。
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
                //当没有点击到cell的时候不进行处理
            if (!indexPath) {
                break;
            }
                //开始移动
            [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
                //移动过程中更新位置坐标
            [_collectionView updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
                //停止移动调用此方法
            [_collectionView endInteractiveMovement];
            break;
        default:
                //取消移动
            [_collectionView cancelInteractiveMovement];
            break;
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DMTestCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:KIDDMTestCell forIndexPath:indexPath];
    cell.iconImageView.image=[self.itemsArray objectAtIndex:indexPath.item];
    cell.delegate=self;
    cell.indexPath=indexPath;
    [self setDMTestCell:cell];
    return cell;
}
-(void)setDMTestCell:(DMTestCell*)cell{
    cell.delectButton.hidden=!isShowDelectButton?YES:NO;
    if (isShowDelectButton) {
        [DMAnimation cubeEffectAnimation:cell];
    }else{
         [cell.layer removeAnimationForKey:@"shake"];
    }
}
-(void)deleteCellAtIndexpath:(NSIndexPath *)indexPath cellView:(DMTestCell *)cell{
    isShowDelectButton=NO;
    [self.collectionView performBatchUpdates:^{
        [self.itemsArray removeObjectAtIndex:indexPath.item];
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
}
//    // 和UITableView类似，UICollectionView也可设置段头段尾
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//
//    if([kind isEqualToString:UICollectionElementKindSectionHeader])
//        {
//        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
//        if(headerView == nil)
//            {
//            headerView = [[UICollectionReusableView alloc] init];
//            }
//        headerView.backgroundColor = [UIColor grayColor];
//
//        return headerView;
//        }
//    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
//        {
//        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
//        if(footerView == nil)
//            {
//            footerView = [[UICollectionReusableView alloc] init];
//            }
//        footerView.backgroundColor = [UIColor lightGrayColor];
//
//        return footerView;
//        }
//
//    return nil;
//}
//在开始移动的时候会调用这个方法，如果有特殊的单元格不想被移动可以return NO， 如果没有限制就返回YES 吧。
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//移动结束的时候会调用此datasource，想要拖拽完成之后数据正确必须实现此方法，使用新的路径更新数据源，如果不实现此方法，刚刚移动cell中的数据不会重新排列。
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    UIImage*image=[self.itemsArray objectAtIndex:sourceIndexPath.item];
    [self.itemsArray removeObject:image];
    [self.itemsArray insertObject:image atIndex:destinationIndexPath.item];
}

#pragma mark - UICollectionViewDelegate

//开始移动
- (BOOL)beginInteractiveMovementForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;

}
    //更新移动过程的位置
- (void)updateInteractiveMovementTargetPosition:(CGPoint)targetPosition{

}
//结束移动的时候调用此方法，collectionView 会响应相应的datasource方法，collectionView:moveItemAtIndexPath:toIndexPath: 我们可以在这个方法中将移动的数据源，与目标数据源交互位置。
- (void)endInteractiveMovement{

}
    //取消移动的时候调用，会返回最原始的位置。
- (void)cancelInteractiveMovement{

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
}
// 长按某item，弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

    // 使copy和paste有效
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"])
        {
        return YES;
        }

    return NO;
}

    //
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if([NSStringFromSelector(action) isEqualToString:@"copy:"])
        {
            //      NSLog(@"-------------执行拷贝-------------");
//        [_collectionView performBatchUpdates:^{
////            [_section0Array removeObjectAtIndex:indexPath.row];
//            [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
//        } completion:nil];
        }
    else if([NSStringFromSelector(action) isEqualToString:@"paste:"])
        {
        NSLog(@"-------------执行粘贴-------------");
        }
}





//如果使用了自定义的FlowLayout UICollectionViewDelegateFlowLayout将不会起作用
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100,100);

}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//设置section的内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
@end
