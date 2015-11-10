//
//  DealsCell.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeView.h"
#import "DealsModel.h"

@interface DealsCell : UITableViewCell

@property (nonatomic, strong) DealsDataModel *dataModel;
//* 时间标签 */
@property(nonatomic,strong)TimeView *timeView;
//* 左侧图片 */
@property(nonatomic,strong)UIImageView *iconIV;
//* 题目标签 */
@property(nonatomic,strong)UILabel *titleLb;
//* 来源标签 */
@property(nonatomic,strong)UILabel *sourceLb;
//* 赞标签 */
@property(nonatomic,strong)UILabel *supportLb;
//* 回复数标签 */
@property(nonatomic,strong)UILabel *commentLb;

@end
