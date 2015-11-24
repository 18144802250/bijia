//
//  ProfileCollectView.m
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ProfileCollectView.h"
#import "ProfileCollectCell.h"
#import "ProfileCollectModel.h"

@interface ProfileCollectLayout : UICollectionViewFlowLayout

@end

@implementation ProfileCollectLayout

- (instancetype)init
{
    if (self = [super init]) {
        
        CGFloat itemW = (kWindowW - 30)/2;
        CGFloat itemH = itemW + 50;
        self.itemSize = CGSizeMake(itemW, itemH);
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
    }
    return self;
}


@end

@interface ProfileCollectView () <UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation ProfileCollectView

- (UICollectionView *)collectView {
	if(_collectView == nil) {
		_collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:[ProfileCollectLayout new]];
        _collectView.dataSource = self;
        _collectView.delegate = self;
        [_collectView registerClass:[ProfileCollectCell class] forCellWithReuseIdentifier:@"Cell"];
	}
	return _collectView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = kNaviTitleColor;
        
        [self addSubview:self.collectView];
        
        [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

#pragma mark - 传入数据 显示视图
- (void)setCollectArr:(NSArray *)collectArr
{
    _collectArr = collectArr;
    
    
    [_collectView reloadData];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    ProfileCollectDataModel *dataModel = self.collectArr[indexPath.row];
    
    cell.dataModel = dataModel.bmobDataDic;
    
    UILongPressGestureRecognizer *gestrue = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [cell addGestureRecognizer:gestrue];
    gestrue.minimumPressDuration = 1.0;
    gestrue.delegate = self;
    gestrue.view.tag = indexPath.row;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(didClickAtCollectViewCellWithIndex:url:title:)]) {
        
        ProfileCollectDataModel *dataModel = self.collectArr[indexPath.row];
        ProfileCollectDataBmobModel *model = dataModel.bmobDataDic;
        
        [_delegate didClickAtCollectViewCellWithIndex:indexPath.row url:[NSURL URLWithString:model.url] title:model.source];
    }
}

#pragma mark - handleLongpress
- (void)handleLongPress:(UILongPressGestureRecognizer*)gr
{
    if (gr.state == UIGestureRecognizerStateBegan) {
        NSUInteger index = gr.view.tag;
        ProfileCollectDataModel *dataModel = self.collectArr[index];
        
        if ([_delegate respondsToSelector:@selector(longPressAtCollectViewCellWithIndex:objectId:)]) {
            [_delegate longPressAtCollectViewCellWithIndex:index objectId:dataModel.objectId];
        }
    }
}

@end
