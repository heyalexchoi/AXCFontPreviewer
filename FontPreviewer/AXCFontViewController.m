//
//  AXCFontViewController.m
//  FontPreviewer
//
//  Created by alexchoi on 6/5/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import "AXCFontViewController.h"

@interface AXCFontViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) NSMutableArray * fontFamilyNames;
@property (strong,nonatomic) NSMutableArray * fontNames;
@end

@implementation AXCFontViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fontFamilyNames = [NSMutableArray arrayWithArray:[UIFont familyNames]];
    self.fontNames = [NSMutableArray new];
    

    
    [self.fontFamilyNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        NSString * familyName = obj;
        [self.fontNames addObjectsFromArray:[UIFont fontNamesForFamilyName:familyName]];
    }];
    
    
    
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fontNames.count;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
///    return self.fontFamilyNames.count;
    return 1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    NSString * fontName = [self.fontNames objectAtIndex:indexPath.item];
    
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        UIView * subview = obj;
        if ([subview isMemberOfClass:[UILabel class]])
        {
            UILabel * label = subview;
            label.font = [UIFont fontWithName:fontName size:16];
            label.text = fontName;
        }
        if ([subview isMemberOfClass:[UITextView class]])
        {
            UITextView * textView = subview;
            textView.font = [UIFont fontWithName:fontName size:16];
        }
        
        
    }];
    
    
    return cell;
    
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCellID" forIndexPath:indexPath];
    
    [sectionHeader.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        UIView * subview = obj;
        if ([subview isMemberOfClass:[UILabel class]])
        {
            UILabel * label = subview;
            
            
            
        }
    }];
    
    return sectionHeader;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
