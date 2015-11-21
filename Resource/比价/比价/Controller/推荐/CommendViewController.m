//
//  CommendViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "CommendViewController.h"
#import "WRCommendViewController.h"
#import "WRGoodListViewController.h"
#import "WRNaviTool.h"

@interface CommendViewController ()

@end

@implementation CommendViewController

+ (UINavigationController *)standardCommend{
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CommendViewController *vc = [[CommendViewController alloc] initWithViewControllerClasses:[self viewControllerClasses] andTheirTitles:[self itemNames]];
        //例如设置第一个控制器的某个属性的值, KVC
        //vc setValue:[values[0]] forKey:keys[0]
        vc.keys = [self vcKeys];
        vc.values = [self vcValues];
        navi = [[UINavigationController alloc] initWithRootViewController:vc];
    });
    return navi;
}
/** 提供每个VC对应的values值数组 */
+ (NSArray *)vcValues{
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i <[self itemNames].count; i++) {
        //数值上，vc的infoType的枚举值 恰好和i值相同
        [arr addObject:@(i)];
    }
    return arr;
}
/** 提供每个VC对应的key值数组 */
+ (NSArray *)vcKeys{
    NSMutableArray *arr = [NSMutableArray new];
    
    NSUInteger count = [self itemNames].count;
    for (int i = 0; i < count; i++) {
        [arr addObject:@"categoryType"];
    }

    return [arr copy];
}

/** 提供题目数组 */
+ (NSArray *)itemNames{
    return @[@"推荐",@"图吧"];
}
/** 提供每个题目对应的控制器的类型。题目和类型数量必须一致 */
+ (NSArray *)viewControllerClasses{
    NSMutableArray *arr = [NSMutableArray new];
    
    [arr addObject:[WRCommendViewController new]];
    [arr addObject:[WRGoodListViewController new]];
    
    return [arr copy];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"推荐";
    [WRNaviTool addLeftNaviItemAtViewC:self];
}

@end
