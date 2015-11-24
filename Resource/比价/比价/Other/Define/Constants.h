//
//  Constants.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

/** 导航栏题目文字大小 */
#define kNaviTitleFontSize   20.0

/** 通过RGB设置颜色 */
#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
/** 导航栏题目文字颜色 */
#define kNaviTitleColor  kRGBColor(40, 137, 59)

#define Keywindow [UIApplication sharedApplication].keyWindow
/** 微博请求账号信息的归档地址 */
#define WRAccountFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"account.data"]
#define WRHistoryFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"history.data"]


#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度

#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))


//通过Storyboard ID 在对应Storyboard中获取场景对象
#define kVCFromSb(storyboardId, storyboardName)     [[UIStoryboard storyboardWithName:storyboardName bundle:nil] \
instantiateViewControllerWithIdentifier:storyboardId]

//移除iOS7之后，cell默认左侧的分割线边距
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}

//Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

/** collect数据库表名 */
#define WRTableCollectName @"Collect"
/** collect数据库字段名id */
#define WRTableCollectObjectId @"objectId"


#define WRItemsNameFontSize 17

#endif /* Constants_h */
