//
//  DMBasicAnimationController.m
//  CAAnimation
//
//  Created by 李达志 on 2018/3/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "DMBasicAnimationController.h"
#import "NSString+DMExtension.h"
#import "CABasicRealizeController.h"
@interface DMBasicAnimationController ()
@property (nonatomic,strong) NSArray * dataItems;
@end

@implementation DMBasicAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataItems=@[@"缩放动画",@"平移动画",@"旋转动画"];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[self.dataItems objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect=[NSString dm_heightStr:[self.dataItems objectAtIndex:indexPath.row] width:kScreenWidth-40 height:1000 sizefont:15];
    return rect.size.height+25;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CABasicRealizeController*vc=[[CABasicRealizeController alloc]init];
     vc.title=[self.dataItems objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            vc.type=CABasicRealizeType_scale;
            break;
        case 1:
            vc.type=CABasicRealizeType_move;
            break;

        default:
            vc.type=CABasicRealizeType_rotation;
            break;
    }


    [self.navigationController pushViewController:vc animated:YES];
}
@end
