//
//  SASlideMenuViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/17/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuViewController.h"
#import "SASlideMenuRootViewController.h"
@interface SASlideMenuViewController ()<SASlideMenuDataSource,SASlideMenuDelegate>

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
    if ([self.slideMenuDataSource respondsToSelector:@selector(segueIdForIndexPath:)]) {
        UINavigationController* controller = [self.rootController controllerForIndexPath:indexPath];
        if (controller) {
            [self.rootController switchToContentViewController:controller];
            return;
        }
        NSString* segueId = [self.slideMenuDataSource segueIdForIndexPath:indexPath];
        [self performSegueWithIdentifier:segueId sender:self];
    }
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
