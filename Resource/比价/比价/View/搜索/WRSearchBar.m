//
//  WRSearchBar.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRSearchBar.h"
#import "UIImage+Extension.h"

@implementation WRSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:14];
        
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        searchIcon.width += 10;
        searchIcon.contentMode = UIViewContentModeCenter;
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
