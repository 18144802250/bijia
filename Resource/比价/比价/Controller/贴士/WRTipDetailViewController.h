//
//  WRTipDetailViewController.h
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRTipDetailViewController : UIViewController

- (instancetype)initWithGuideId:(NSString*)idStr;
@property (nonatomic, strong) NSString *guideId;

@end
