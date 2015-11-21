//
//  GoodlistCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "GoodlistCell.h"
#import "DealsModel.h"

#pragma mark - collectionViewLayout

@interface WRShowItemLayout : UICollectionViewFlowLayout

@end

@implementation WRShowItemLayout

- (instancetype)init
{
    if (self = [super init]) {
        CGFloat w = (kWindowW - 80)/3;
        self.itemSize = CGSizeMake(w, w);
        self.minimumInteritemSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

@end

@interface GoodlistCell ()<UICollectionViewDataSource>

/** 大图 */
@property (nonatomic, strong) UIButton *headBtn;
/** 展示图 */
@property (nonatomic, strong) UICollectionView *showItemCV;
/** itemModelArray */
@property (nonatomic, strong) NSArray *itemsArr;

@end

@implementation GoodlistCell

- (NSArray *)itemsArr {
    if(_itemsArr == nil) {
        _itemsArr = [[NSArray alloc] init];
    }
    return _itemsArr;
}

- (UIButton *)headBtn {
    if(_headBtn == nil) {
        _headBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_headBtn];
    }
    return _headBtn;
}

- (UICollectionView *)showItemCV {
    if(_showItemCV == nil) {
        _showItemCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200) collectionViewLayout:[WRShowItemLayout new]];
        _showItemCV.dataSource = self;
        self.userInteractionEnabled = NO;
        [self.contentView addSubview:_showItemCV];
    }
    return _showItemCV;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //720*480
        CGFloat headH = kWindowW*(480/720);
        [self.headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(headH);
        }];
        
        CGFloat showItemH = (kWindowW - 80)/3 + 20;
        
        [self.showItemCV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headBtn.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(showItemH);
        }];
    }
    return self;
}

- (void)setGlDataModel:(DealsDataModel *)glDataModel
{
    _glDataModel = glDataModel;
    
    _itemsArr = [glDataModel.items copy];
}

#pragma mark - collectionView数据源配置
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = _itemsArr.count;
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [UICollectionViewCell new];
    
    DealsDataItemsModel *itemModel = _itemsArr[indexPath.row];
    UIImageView *iv = [UIImageView new];
    [iv setImageWithURL:itemModel.image_url];
    [cell.contentView addSubview:iv];
    
    return cell;
}

@end
