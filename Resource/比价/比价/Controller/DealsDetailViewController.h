//
//  DealsDetailViewController.h
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsDetailViewController : UIViewController

- (instancetype)initWithIdStr:(NSString*)idStr;
/** idStr */
@property (nonatomic, strong) NSString *idStr;

@end
