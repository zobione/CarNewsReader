//
//  selectionViewController.h
//  RecipeApp
//
//  Created by Emilien Sanchez on 17/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface selectionViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray * Category;
    NSArray * CategoryTitle;
    NSMutableArray * PassCategory;
    NSMutableArray * URLs;
    NSArray *Source;
    NSMutableArray *SourceMutable;
    NSInteger NbURL;
}

- (IBAction)Selection:(id)sender;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
