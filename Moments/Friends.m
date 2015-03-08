//
//  Friends.m
//  Moments
//
//  Created by Dhwanit Mehta on 12/11/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import "Friends.h"
#import "ImageBrowser.h"
#import "CollageView.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SettingsView.h"
@implementation Friends


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSearch =false;
    self.searchResults = [[NSArray alloc]init];
    NSSortDescriptor *ascSorter = [[NSSortDescriptor alloc]
                                   initWithKey:@"name" ascending:YES];
    [self.profiles sortUsingDescriptors:[NSArray
                                         arrayWithObject:ascSorter]];
    
    NSArray *mut = [[[NSArray alloc]initWithArray:self.profiles]mutableCopy];
    for(Profiles *i in mut){
        if (i.pictureURLs.count == 0) {
            [self.profiles removeObject:i];
        }
    }
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //settingsButton reference:https://stackoverflow.com/questions/9755154/ios-uibarbuttonitem-identifier-option-to-create-settings-cogwheel-button
    
    //search feature functionality reference: https://www.youtube.com/watch?v=TijuWkbxP1o and https://stackoverflow.com/questions/7207050/searching-filtering-a-custom-class-array-with-a-nspredicate and https://stackoverflow.com/questions/21135305/uisearchbar-didselectrowatindexpath-cellforrowatindexpath
    
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
    settingsButton.width = 50;
    UIFont *customFontS = [UIFont fontWithName:@"Helvetica" size:30.0];
    UIFont *customFont = [UIFont fontWithName:@"Helvetica" size:18.0];
    NSDictionary *fontDictionaryS = @{NSFontAttributeName : customFontS};
    NSDictionary *fontDictionary = @{NSFontAttributeName : customFont};
    [settingsButton setTitleTextAttributes:fontDictionaryS forState:UIControlStateNormal];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneSelecting)];
    [doneButton setTitleTextAttributes:fontDictionary forState:UIControlStateNormal];
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearSelection)];
    [clearButton setTitleTextAttributes:fontDictionary forState:UIControlStateNormal];
     self.navigationItem.leftBarButtonItem = settingsButton;
    self.navigationItem.rightBarButtonItems = @[doneButton,clearButton];
}

-(void)clearSelection{
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selectedIds"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"photos"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Clear" message:@"All Selected Images Cleared" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

-(void)doneSelecting{
    if ([[[NSUserDefaults standardUserDefaults]arrayForKey:@"selectedIds"] count]<4) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"Please Select %lu more Images",(4-[[[NSUserDefaults standardUserDefaults]arrayForKey:@"selectedIds"]count])] message:[NSString stringWithFormat:@"Insufficient Number of Images Selected\n (%lu of 4 Images Selected)",[[[NSUserDefaults standardUserDefaults] arrayForKey:@"selectedIds"] count]]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        [self performSegueWithIdentifier:@"toCollageView" sender:self];
    }
}

-(void)showSettings{
    [self performSegueWithIdentifier:@"toSettings" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }else{
        return [self.profiles count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
    Profiles *p;
    NSURL *url;
    NSData *data;
    UIImage *image;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendsCell"];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        p = [self.searchResults objectAtIndex:indexPath.row];
        self.isSearch = true;
    }
    else{
        p = [self.profiles objectAtIndex:indexPath.row];
        self.isSearch = false;
    }
    url = [NSURL URLWithString: p.profileImageURL];
    data = [NSData dataWithContentsOfURL:url];
    image = [[UIImage alloc]initWithData:data];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = image;
    
    cell.textLabel.text = p.name;
    return cell;
}
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        self.isSearch = FALSE;
    }
    else
    {
        self.isSearch = true;
    }
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    self.isSearch = FALSE;
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.searchResults = [self.profiles filteredArrayUsingPredicate:predicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
    [self performSegueWithIdentifier:@"toImageBrowser" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toImageBrowser"]) {
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Profiles *p;
        if (self.isSearch) {
            p = [self.searchResults objectAtIndex:indexPath.row];
        }
        else{
            p = [self.profiles objectAtIndex:indexPath.row];
        }
        ImageBrowser *imageBrowser = segue.destinationViewController;
        imageBrowser.selectedProfile = p;
        NSMutableArray *images = [[NSMutableArray alloc]init];
        for(NSString *i in p.pictureThumbs){
            NSString *urlString = i;
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *photo = [[UIImage alloc]initWithData:data];
            [images addObject:photo];
        }
        imageBrowser.photos = images;
    }
    
    if ([segue.identifier isEqualToString:@"toCollageView"]) {
        CollageView *collageView = (CollageView*)segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"toSettings"]) {
        SettingsView *settingView = (SettingsView*)segue.destinationViewController;
    }
//    ImageView *imageView = segue.destinationViewController;
//    imageView.selectedProfile = p;
}

@end
