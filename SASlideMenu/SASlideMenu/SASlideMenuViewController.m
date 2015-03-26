//
//  SASlideMenuViewController.m
//  Bryan Stouffer
//
//  Created by Stefano Antonelli on 1/17/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuViewController.h"
#import "SASlideMenuRootViewController.h"
#import "SAMenuItem.h"
#import "SARootMenuTableViewController.h"

@interface SASlideMenuViewController ()<SASlideMenuDataSource,SASlideMenuDelegate>
@property (nonatomic) NSIndexPath* currentContentIndexPath;
@end

@implementation SASlideMenuViewController
#pragma mark -
#pragma mark Init
-(void)setup; {
    if(self.slideMenuDataSource == nil)
        self.slideMenuDataSource = self;
    if(self.slideMenuDelegate == nil)
        self.slideMenuDelegate = self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder; {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)init; {
    self = [super self];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)loadContentAtIndexPath:(NSIndexPath*)indexPath {
    SARootMenuTableViewController* source = (SARootMenuTableViewController*)self;
    SAMenuItem *selectedItem = [source.menuIndex objectAtIndex:indexPath.row];
    
    if ([selectedItem.itemAction hasPrefix:@"action_"]) {
        
        [source.rootController doSlideIn:^(BOOL completed) {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            NSLog(@"Posting notification: %@", selectedItem.itemAction);
            [center postNotificationName:selectedItem.itemAction object:selectedItem];
        }];
    } else if ([self.slideMenuDataSource respondsToSelector:@selector(segueIdForIndexPath:)]) {
        UINavigationController* controller = [self.rootController controllerForAction:selectedItem.itemAction];
        
        if (controller) {
            //Add code to pop the controller
            [controller.navigationController setNavigationBarHidden:YES];
            
            [controller popToRootViewControllerAnimated:NO];
            [self.rootController switchToContentViewController:controller];
        } else {
            NSString* segueId = [self.slideMenuDataSource segueIdForIndexPath:indexPath];
            [self performSegueWithIdentifier:segueId sender:self];
            self.currentContentIndexPath = indexPath;
        }
        
        //Reset the status bar.
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
}

- (void)loadContentForAction:(NSString*)action {
    UINavigationController* controller = [self.rootController controllerForAction:action];
    if (controller) {
        //Add code to pop the controller
        [controller.navigationController setNavigationBarHidden:YES];
        
        [controller popToRootViewControllerAnimated:NO];
        [self.rootController switchToContentViewController:controller];
        return;
    }

    [self performSegueWithIdentifier:action sender:self];
    self.currentContentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

#pragma mark -
#pragma mark SASlideMenuViewController

-(void)selectContentAtIndexPath:(NSIndexPath *)indexPath scrollPosition:(UITableViewScrollPosition)scrollPosition{
    if ([self.slideMenuDataSource respondsToSelector:@selector(segueIdForIndexPath:)]) {
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:scrollPosition];
     
        Boolean disableContentViewControllerCaching= NO;
        if ([self.slideMenuDataSource respondsToSelector:@selector(disableContentViewControllerCachingForIndexPath::)]) {
            disableContentViewControllerCaching = [self.slideMenuDataSource disableContentViewControllerCachingForIndexPath:indexPath];
        }

        [self loadContentAtIndexPath:indexPath];
    }
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL shouldRespondToGesture = YES;
    if ([self.slideMenuDataSource respondsToSelector:@selector(shouldRespondToGesture:forIndexPath:)]) {
        shouldRespondToGesture = [self.slideMenuDataSource shouldRespondToGesture:gestureRecognizer
                                                                     forIndexPath:self.currentContentIndexPath];
    }
    return shouldRespondToGesture;
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self loadContentAtIndexPath:indexPath];
}

@end
