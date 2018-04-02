//
//  RootTableViewController.m
//  UIcollectionViewDemo
//
//  Created by 李达志 on 2018/3/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "RootTableViewController.h"
#import "NSString+DMExtension.h"
@interface RootTableViewController ()
@property (nonatomic,strong) NSArray*controllerArray;
@property (nonatomic,strong) NSArray * titleArray;
@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"CAAnimation简要Demo";
self.controllerArray=@[@"ViewController",@"DMBasicAnimationController",@"ViewController",@"CATransitionController"];
    self.titleArray=@[@"运用动画对UICollectionView删除某个cell做的效果",@"CABasicAnimation",@"CAKeyframeAnimation",@"CATransition"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect=[NSString dm_heightStr:[self.titleArray objectAtIndex:indexPath.row]  width:[UIScreen mainScreen].bounds.size.width-30 height:1000 sizefont:16];
    return rect.size.height+25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text=[self.titleArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:[NSClassFromString([self.controllerArray objectAtIndex:indexPath.row]) new] animated:YES];
}

@end
