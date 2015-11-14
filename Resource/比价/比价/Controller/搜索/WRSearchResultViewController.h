//
//  WRSearchResultViewController.h
//  比价
//
//  Created by apple-jd28 on 15/11/14.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRSearchResultViewController : UIViewController

- (instancetype)initWithQuest:(NSString*)quest;

@property (nonatomic, strong) NSString *quest;

@end
