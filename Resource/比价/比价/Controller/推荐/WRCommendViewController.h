//
//  WRCommendViewController.h
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealsNetManager.h"

@interface WRCommendViewController : UIViewController

- (id)initWithType:(CategoryType)type;
@property (nonatomic, assign) CategoryType type;

@end
