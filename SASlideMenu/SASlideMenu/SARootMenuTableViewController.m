//
//  SARootMenuTableViewController.m
//  Bryan Stouffer
//
//  Created by Stefano Antonelli on 11/20/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SARootMenuTableViewController.h"
#import "SAMenuItem.h"

@interface SARootMenuTableViewController ()<SASlideMenuDataSource,SASlideMenuDelegate, UITableViewDataSource>

@property (nonatomic) CGFloat selectedHue;
@property (nonatomic) CGFloat selectedBrightness;

@end

@implementation SARootMenuTableViewController

@synthesize menuIndex;

-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        
        if (menuIndex == nil) {
            menuIndex = [[NSMutableArray alloc] init];
            [menuIndex addObject:[[SAMenuItem alloc] initWithTitle:@"Dashboard"
                                                       action:@"seg_dashboard"]];
            [center addObserverForName:@"updateMenu"
                                object:nil
                                 queue:mainQueue
                            usingBlock:^(NSNotification* note) {
                                menuIndex = note.object;
                                [[self tableView] reloadData];
                                NSLog(@"Got new menu of size: %d", (int)menuIndex.count);
                            }];
        }
    }
    return self;
}

-(void)tap:(id)sender{
    
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

#pragma mark -
#pragma mark SASlideMenuDataSource

-(void) prepareForSwitchToContentViewController:(UINavigationController *)content{
    
}

// It configure the menu button. The beahviour of the button should not be modified
-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuicon.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}

// It configure the right menu button. The beahviour of the button should not be modified
-(void) configureRightMenuButton:(UIButton *)menuButton{

}

// This is the segue you want visibile when the controller is loaded the first time
-(NSIndexPath*) selectedIndexPath{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

// It maps each indexPath to the segueId to be used. The segue is performed only the first time the controller needs to loaded, subsequent switch to the content controller will use the already loaded controller

-(NSString*) segueIdForIndexPath:(NSIndexPath *)indexPath{    
    //This is assuming that the array is indexed appropriately
    SAMenuItem* item = [menuIndex objectAtIndex:indexPath.row];
    if (item.itemAction != nil) {
        return item.itemAction;
    }
    
    return @"seg_dashboard";
}

-(Boolean) slideOutThenIn{
    return NO;
}

//Disable caching for the controller at the first row of each section
-(Boolean) disableContentViewControllerCachingForIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

//Enable the right menu for the the view controller in the first section
-(Boolean) hasRightMenuForIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   return @"";
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (menuIndex == nil) {
        return 0;
    }
    return menuIndex.count;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell.backgroundColor = [UIColor colorWithHue:hue saturation:1.0 brightness:brightness alpha:1.0];
    if (menuIndex == nil || menuIndex.count == 0) {
        cell.textLabel.text = @"Menu";
    } else {
        SAMenuItem* item = [menuIndex objectAtIndex:indexPath.row];
        cell.textLabel.text = item.itemTitle;
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"item"];
    return cell;
}

-(CGFloat) leftMenuVisibleWidth{
    return 280;
}

-(CGFloat) rightMenuVisibleWidth{
    return 0;
}

//restricts pan gesture interation to 50px on the left and right of the view.
-(Boolean) shouldRespondToGesture:(UIGestureRecognizer*) gesture forIndexPath:(NSIndexPath*)indexPath {
    CGPoint touchPosition = [gesture locationInView:self.view];
    return (touchPosition.x < 50.0 || touchPosition.x > self.view.bounds.size.width - 50.0f);
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Prep any info if needed on another screen
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}
#pragma mark -
#pragma mark SASlideMenuDelegate

-(void) slideMenuWillSlideIn{
    //NSLog(@"slideMenuWillSlideIn");
}
-(void) slideMenuDidSlideIn{
    //NSLog(@"slideMenuDidSlideIn");
}
-(void) slideMenuWillSlideToSide{
    //NSLog(@"slideMenuWillSlideToSide");
}
-(void) slideMenuDidSlideToSide{
    //NSLog(@"slideMenuDidSlideToSide");
}
-(void) slideMenuWillSlideOut{
    //NSLog(@"slideMenuWillSlideOut");
}
-(void) slideMenuDidSlideOut{
    //NSLog(@"slideMenuDidSlideOut");
}
-(void) slideMenuWillSlideToLeft{
    //NSLog(@"slideMenuWillSlideToLeft");
}
-(void) slideMenuDidSlideToLeft{
    //NSLog(@"slideMenuDidSlideToLeft");
}
@end
