//
//  ShowPicCell.h
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DealsDataModel,TipListDataModel;
@interface ShowPicCell : UITableViewCell

@property (nonatomic, strong) DealsDataModel *dataModel;

@property (nonatomic, strong) TipListDataModel *tlModel;

@end
