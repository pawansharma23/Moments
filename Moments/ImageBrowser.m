//
//  ImageBrowser.m
//  Moments
//
//  Created by Dhwanit Mehta on 12/15/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import "ImageBrowser.h"
#import "DetailImage.h"

//reference for UICollectionView http://www.raywenderlich.com/22324/beginning-uicollectionview-in-ios-6-part-12
//tapped for segue functionality reference :https://stackoverflow.com/questions/16761623/collection-view-segue

@interface ImageBrowser ()

@end

@implementation ImageBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImagesCell"];
    self.navigationItem.title = self.selectedProfile.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionView Datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.photos count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImagesCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    cell.imageView.image = [self.photos objectAtIndex:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *photo = [self.photos objectAtIndex:indexPath.row];
    CGSize retval = photo.size.width > 0 ? photo.size : CGSizeMake(100, 100);
    retval.width += 35;
    retval.height +=35;
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toDetailShow"]) {
        DetailImage *detailImage = (DetailImage*)segue.destinationViewController;
        NSURL *url = [NSURL URLWithString:self.selectedImage];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc]initWithData:data];
        detailImage.image.image = img;
        detailImage.selectedImage = img;
        detailImage.ids = self.ids;
    }
    
}

- (IBAction)tapped:(UITapGestureRecognizer *)gesture {
    
    CGPoint tapLocation = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        
        self.selectedImage = [self.selectedProfile.pictureURLs objectAtIndex:indexPath.row];
        
        self.ids = [self.selectedProfile.ids objectAtIndex:indexPath.row];
        
        [self performSegueWithIdentifier:@"toDetailShow" sender:self];
    }
}

@end
