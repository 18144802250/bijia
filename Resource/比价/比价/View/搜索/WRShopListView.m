//
//  WRShopListView.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRShopListView.h"
#define WRItemInterSpace 10
#define WRLineSpace 10
#define WRLeftMargin 15
#define WRTopMargin 10

@interface WRShopLayout : UICollectionViewFlowLayout


@end

@implementation WRShopLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        //3 X 4
        CGFloat w = (kWindowW - 2*WRItemInterSpace - 2*WRLeftMargin)/3;
        // 高 = 宽/2 - 3个行间距
        CGFloat h = ((kWindowW - 2*WRItemInterSpace)/2 - 5*WRLineSpace)/4;
        self.itemSize = CGSizeMake(w, h);
        self.minimumLineSpacing = WRLineSpace;
        self.minimumInteritemSpacing = WRItemInterSpace;
        self.sectionInset = UIEdgeInsetsMake(WRTopMargin, WRLeftMargin, WRTopMargin, WRLeftMargin);

    }
    return self;
}

@end

@interface WRShopListView () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *shopCV;

@end

@implementation WRShopListView

- (UICollectionView *)shopCV {
	if(_shopCV == nil) {
		_shopCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[WRShopLayout new]];
        
        _shopCV.dataSource = self;
        _shopCV.backgroundColor = [UIColor grayColor];
        [_shopCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
	}
	return _shopCV;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.shopCV];
        
        [self.shopCV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    return self;
}

- (void)setShopModel:(ShopViewModel *)shopModel
{
    _shopModel = shopModel;
    
    [self.shopCV reloadData];
}

#pragma mark - 瀑布流布局



#pragma mark - 数据源配置

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shopModel.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    ShopDataModel *model = self.shopModel.dataArr[indexPath.row];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.tag = indexPath.row;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:model.name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    
#pragma mark -点击商场进入商场详细页面
    [btn bk_addEventHandler:^(UIButton *sender) {
        
        if ([_delegate respondsToSelector:@selector(didClickedAtBtnTag:)]) {
            [_delegate didClickedAtBtnTag:sender.tag];
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    return cell;
}

@end
