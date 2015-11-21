//
//  ShopPriceListView.m
//  比价
//
//  Created by apple-jd28 on 15/11/17.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ShopPriceListView.h"

#import "SearchDetailModel.h"

#pragma mark - ItemsCell开始

@interface ItemsCell : UITableViewCell

@property (nonatomic, strong) SearchDetailDataItemsModel *itemsModel;

/** 把推荐价格传进来 */
@property (nonatomic, strong) NSString *recommendPrice;

@end


@interface ItemsCell ()
/** 是否推荐 */
@property (nonatomic, strong) UIImageView *recommendIv;

/** 是否缺货 */
@property (nonatomic, strong) UIButton *avibtn;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLb;
/** 价格 */
@property (nonatomic, strong) UILabel *priceLb;

@end

@implementation ItemsCell

- (UIImageView *)recommendIv {
    if(_recommendIv == nil) {
        _recommendIv = [[UIImageView alloc] init];
        [self.contentView addSubview:_recommendIv];
    }
    return _recommendIv;
}

- (UIButton *)avibtn {
    if(_avibtn == nil) {
        _avibtn = [[UIButton alloc] init];
        _avibtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_avibtn];
    }
    return _avibtn;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLb];
    }
    return _titleLb;
}

- (UILabel *)priceLb {
    if(_priceLb == nil) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_priceLb];
    }
    return _priceLb;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.recommendIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.centerY.mas_equalTo(0);
        }];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_recommendIv.mas_right).mas_equalTo(8);
            make.centerY.mas_equalTo(0);
        }];
        
        [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        [self.avibtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(88, 35));
        }];
    }
    return self;
}


- (void)setItemsModel:(SearchDetailDataItemsModel *)itemsModel
{
    _itemsModel = itemsModel;
    //是否推荐？
    if (itemsModel.recommend) {
        _recommendIv.hidden = NO;
    } else {
        _recommendIv.hidden = YES;
    }
    //电商名
    _titleLb.text = itemsModel.site_name;
    //价格 最低的绿色 普通的红色 缺货显示灰色
    if (itemsModel.available) {
        if ([itemsModel.price isEqualToString:_recommendPrice]) {
            _priceLb.textColor = [UIColor greenColor];
        } else {
            _priceLb.textColor = [UIColor blueColor];
        }
    } else {
        _priceLb.textColor = [UIColor lightGrayColor];
    }
    _priceLb.text = itemsModel.price;
    
    if (itemsModel.available) {
        [_avibtn setTitle:@"买买买" forState:UIControlStateNormal];
        [_avibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [_avibtn setTitle:@"额偶,缺货" forState:UIControlStateNormal];
        [_avibtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        //隐藏辅助视图
        self.accessoryView.hidden = YES;
        self.userInteractionEnabled = NO;
    }
}


@end

#pragma mark - ShopPriceListTV开始

@interface ShopPriceListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *shopPriceArr;

@end



@implementation ShopPriceListView

+ (instancetype)viewInRect:(CGRect)frame
{
    ShopPriceListView *sp = [[ShopPriceListView alloc] initWithFrame:frame];
    
    return sp;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor purpleColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


#pragma mark -初始化 添加tableView到View上
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setSdModel:(SearchDetailDataModel *)sdModel
{
    _sdModel = sdModel;
    self.shopPriceArr = sdModel.items;
}

#pragma mark - 重新构建数组 根据是否缺货排序
- (void)setShopPriceArr:(NSArray *)shopPriceArr
{
    _shopPriceArr = shopPriceArr;
    
    NSMutableArray *arr = [shopPriceArr mutableCopy];
    
    //是否是compareView点击进来的 如果是 删除对应的商品名
    if (_isCompareView) {
        for (SearchDetailDataItemsModel *model in arr) {
            if ([model.site_name isEqualToString:_siteName]) {
                [arr removeObject:model];
                break;
            }
        }
    }
    
    //根据是否缺货排序
    int arrCount = (int)arr.count;
    int count = -1;
    for (int i = 0; i < arrCount; i++) {
        
        SearchDetailDataItemsModel *model = arr[i];
        //如果缺货，从数组中删除，并添加到数组后面
        if (!model.available) {
            [arr removeObjectAtIndex:i];
            [arr insertObject:model atIndex:arr.count];
            i--;
        }
        count++;
        if (count==arrCount-1) {
            break;
        }
    }
    _shopPriceArr = [arr copy];
    
    [self.tableView reloadData];
}
#pragma mark - tableView数据源配置

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rowNumber = _shopPriceArr.count;
    return rowNumber;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ItemsCell *cell = [ItemsCell new];
    
    cell.recommendPrice = _sdModel.recommend_price;
    
    cell.itemsModel = self.shopPriceArr[indexPath.row];
    
    
    return cell;
}

#pragma mark - tableViewDelegate 点击Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([_delegate respondsToSelector:@selector(didClickAtCellIndex:)]) {
        [_delegate didClickAtCellIndex:indexPath.row];
    }
    if ([_delegate respondsToSelector:@selector(didClickAtCellWithItemModel:)]) {
        [_delegate didClickAtCellWithItemModel:self.shopPriceArr[indexPath.row]];
    }
}


@end
