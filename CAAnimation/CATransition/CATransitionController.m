//
//  CATransitionController.m
//  UIcollectionViewDemo
//
//  Created by 李达志 on 2018/3/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//
//关于CATransition的解析见https://www.jianshu.com/p/267ba592254c
#import "CATransitionController.h"
#import "NSString+DMExtension.h"
@interface CATransitionController ()

/**放置title的数组 */
@property (nonatomic,strong) NSArray * animationItems;
@property (nonatomic,strong) UIImageView*caImageView;
@property (nonatomic,strong) NSArray * selectorItems;
@property (nonatomic,strong) UIButton * stopButton;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end

@implementation CATransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"CATransitionDemo";
    self.caImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"i25"]];
    self.caImageView.layer.cornerRadius=10;
    self.caImageView.layer.masksToBounds=YES;
    self.caImageView.frame=CGRectMake(200, 100, 100, 100);
    [self.view addSubview:self.caImageView];
    self.view.backgroundColor=[UIColor whiteColor];
    self.indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.view addSubview:self.stopButton];


}
-(UIButton *)stopButton{
    if (!_stopButton) {
        _stopButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_stopButton setTitle:@"执行一次" forState:UIControlStateNormal];
        [_stopButton setTitle:@"重复执行" forState:UIControlStateSelected];
        [_stopButton addTarget:self action:@selector(stopButtonActio) forControlEvents:UIControlEventTouchUpInside];
        [_stopButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_stopButton  setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_stopButton setBackgroundColor:[UIColor purpleColor]];
        _stopButton.layer.cornerRadius=5;
        _stopButton.layer.masksToBounds=YES;
        _stopButton.frame=CGRectMake(200, 40, 100, 30);

    }
    return _stopButton;
}
-(void)stopButtonActio{
    self.stopButton.selected=!self.stopButton.selected;
    [self.caImageView.layer removeAllAnimations];
    [self fadeCATransitionAnimation:self.indexPath];
}
-(NSArray *)selectorItems{
    if (!_selectorItems) {
        _selectorItems=@[@"fade",@"push",@"moveIn",@"reveal",@"cube",@"oglFlip",@"suckEffect",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"];
    }
    return _selectorItems;
}
-(NSArray *)animationItems{
    if (!_animationItems) {
        _animationItems=@[@"fade交叉淡化过度的效果",
                          @"push 新视图把旧视图推出去",
                          @"moveIn新视图移到旧视图上面",
                          @"reveal将旧视图移开，显示新视图",
                          @"cube立方体翻滚的效果",
                          @"oglFlip上下左右翻转的效果",
                          @"suckEffect收缩效果，如一块布被抽走",
                          @"rippleEffect水滴效果（像是在屏幕上滴了一滴水，然后泛起一下涟漪）",
                          @"pageCurl向上翻页效果",
                          @"pageUnCurl向下翻页效果",
                          @"cameraIrisHollowOpen相机镜头打开效果",
                          @"cameraIrisHollowClose相机镜头关闭效果"];
    }
    return _animationItems;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.animationItems.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect=[NSString dm_heightStr:[self.animationItems objectAtIndex:indexPath.row]  width:[UIScreen mainScreen].bounds.size.width-30 height:1000 sizefont:16];
    return rect.size.height+25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text=[self.animationItems objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexPath=indexPath;
    [self.caImageView.layer removeAllAnimations];
    [self fadeCATransitionAnimation:indexPath];

}

/**
 fade交叉淡化过度的效果
 */
-(void)fadeCATransitionAnimation:(NSIndexPath*)index{
    CATransition *animation = [CATransition animation];
    animation.type = [self.selectorItems objectAtIndex:index.row];
    animation.subtype = @"fromTop";
    animation.duration = 1.1;
    animation.repeatCount=self.stopButton.isSelected?1:MAXFLOAT;
    [animation setValue:@"fade" forKey:@"animType"];
    [self.caImageView.layer addAnimation:animation forKey:nil];
}
@end
