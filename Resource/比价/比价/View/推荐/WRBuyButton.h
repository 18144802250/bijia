//
//  WRBuyButton.h
//  比价
//
//  Created by apple-jd28 on 15/11/20.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WRBuyButtonDelegate <NSObject>

@optional
- (void)didClickedAtBuyBtn:(UIButton*)btn;

@end

@interface WRBuyButton : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) id <WRBuyButtonDelegate> delegate;

@end
