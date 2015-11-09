//
//  DealsCell.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsCell : UITableViewCell

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
