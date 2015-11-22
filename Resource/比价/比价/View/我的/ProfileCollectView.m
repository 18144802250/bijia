//
//  ProfileCollectView.m
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ProfileCollectView.h"
#import "ProfileCollectCell.h"

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

@interface ProfileCollectView () <UICollectionViewDataSource,UICollectionViewDelegate>

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

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 11;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    return cell;
}

@end
