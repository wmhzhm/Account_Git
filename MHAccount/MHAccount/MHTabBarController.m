//
//  MHTabBarController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/16.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHTabBarController.h"
#import "LBTabBar.h"

#import "MHMyBagTableViewController.h"
#import "MHDetailedViewController.h"


@interface MHTabBarController()<LBTabBarDelegate>

@end


@implementation MHTabBarController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllChildVc];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
}
#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)setUpAllChildVc
{
    
    
    MHDetailedViewController *detailVC = [[MHDetailedViewController alloc] init];
    [self setUpOneChildVcWithVc:detailVC Image:@"detail_item_img" selectedImage:@"detail_item_img" title:@"明细"];
    
    MHMyBagTableViewController *FishVC = [[MHMyBagTableViewController alloc] init];
    [self setUpOneChildVcWithVc:FishVC Image:@"bag_item_img" selectedImage:@"bag_item_img" title:@"钱包"];
    
    MHMyBagTableViewController *MessageVC = [[MHMyBagTableViewController alloc] init];
    [self setUpOneChildVcWithVc:MessageVC Image:@"bag_item_img" selectedImage:@"bag_item_img" title:@"钱包"];
    
    MHMyBagTableViewController *MineVC = [[MHMyBagTableViewController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"bag_item_img" selectedImage:@"bag_item_img" title:@"钱包"];
}
#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
//    LBNavigationController *nav = [[LBNavigationController alloc] initWithRootViewController:Vc];
//    Vc.view.backgroundColor = [self randomColor];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
    Vc.navigationItem.title = title;
    
//    [self addChildViewController:nav];
    
}
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{

}

@end