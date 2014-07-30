//
//  AXCFontViewController.m
//  FontPreviewer
//
//  Created by alexchoi on 6/5/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import "AXCFontViewController.h"

@interface AXCFontViewController () <UICollectionViewDataSource,UICollectionViewDelegate, UISearchBarDelegate>

@property (strong,nonatomic) NSMutableArray * fontNames;
@property (strong,nonatomic) NSArray * filteredNames;
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
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 20)];
    searchBar.backgroundImage = [UIImage new]; // get rid of that dumbass gray background box
    [searchBar sizeToFit];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    self.collectionView.frame = CGRectMake(0,searchBar.frame.size.height + searchBar.frame.origin.y,self.collectionView.frame.size.width,self.collectionView.frame.size.height-searchBar.frame.size.height);

    self.fontNames = [NSMutableArray new];

    [[UIFont familyNames] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        NSString * familyName = obj;
        [self.fontNames addObjectsFromArray:[UIFont fontNamesForFamilyName:familyName]];
    }];
    
    [self.fontNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@",obj);
    }];
    
    [self.fontNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.filteredNames = [self.fontNames copy];
    

        // dismiss search keyboard on searchbar on main view tap
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:searchBar action:@selector(endEditing:)]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.filteredNames.count;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    NSString * fontName = [self.filteredNames objectAtIndex:indexPath.item];
    
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

#pragma mark UISearchBarDelegate
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""])
    {
        self.filteredNames = self.fontNames;
        [self.collectionView reloadData];
        return;
    }
    self.filteredNames = [self.fontNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchText]];
    [self.collectionView reloadData];
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
