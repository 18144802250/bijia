//
//  ItemsCell.h
//  比价
//
//  Created by apple-jd28 on 15/11/16.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchDetailDataModel,SearchDetailDataItemsModel;
@interface HeadItemCell : UITableViewCell

@property (nonatomic, strong) SearchDetailDataModel *dataModel;

@end

@interface ItemsCell : UITableViewCell

@property (nonatomic, strong) SearchDetailDataItemsModel *itemsModel;

/** 把推荐价格传进来 */
@property (nonatomic, strong) NSString *recommendPrice;

@end
