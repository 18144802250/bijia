




//
//  WRTextFieldTool.m
//  比价
//
//  Created by apple-jd28 on 15/11/25.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRTextFieldTool.h"

@implementation WRTextFieldTool

#pragma mark 给键盘添加收起按钮
+ (void)addHideDowmItemAtTFKeyboard:(UITextField*)tf
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    [btn bk_addEventHandler:^(id sender) {
        
        [tf endEditing:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"shou"] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    [tf setInputAccessoryView:topView];
}

@end
