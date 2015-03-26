//
//  SARootMenuTableViewController.h
//
//  Created by Bryan on 6/20/13.
//
//

#import <UIKit/UIKit.h>
#import "SASlideMenuViewController.h"
#import "SASlideMenuDataSource.h"
#import "SASlideMenuDelegate.h"
@interface SARootMenuTableViewController : SASlideMenuViewController

@property (strong, nonatomic) NSMutableArray* menuIndex;

-(void) tap:(id) sender;

@end
