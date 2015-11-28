//
//  TipViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "TipViewController.h"
#import "WRTipViewController.h"

@interface TipViewController ()

@end

@implementation TipViewController

+ (UIViewController *)standardTip{
    static TipViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[TipViewController alloc] initWithViewControllerClasses:[self viewControllerClasses] andTheirTitles:[self itemNames]];
        //例如设置第一个控制器的某个属性的值, KVC
        //vc setValue:[values[0]] forKey:keys[0]
        vc.keys = [self vcKeys];
        vc.values = [self vcValues];
       
    });
    return vc;
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
        [arr addObject:@"type"];
    }
    
    return [arr copy];
}

/** 提供题目数组 */
+ (NSArray *)itemNames{
    return @[@"健康贴士",@"分享图吧"];
}
/** 提供每个题目对应的控制器的类型。题目和类型数量必须一致 */
+ (NSArray *)viewControllerClasses{
    NSMutableArray *arr = [NSMutableArray new];
    
    
    NSUInteger count = [self itemNames].count;
    for (int i = 0; i < count; i++) {
        [arr addObject:[WRTipViewController class]];
    }
    
    return [arr copy];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleColorSelected = kNaviTitleColor;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeNormal = 16;
    self.titleSizeSelected = 18;
    self.menuItemWidth = 100;
}



@end
