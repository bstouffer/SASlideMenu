//
//  SASlideMenuRootViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/16/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuViewController.h"

@class SASlideMenuNavigationController;
@class SASlideMenuViewController;
@interface SASlideMenuRootViewController : UIViewController


@property (nonatomic,strong) SASlideMenuViewController* leftMenu;
@property (nonatomic,strong) UIViewController* rightMenu;
@property (nonatomic,assign) Boolean isRightMenuEnabled;
@property (nonatomic,strong) SASlideMenuNavigationController* navigationController;

-(void) switchToContentViewController:(UINavigationController*) content;
-(void) addContentViewController:(UIViewController*) content withAction:(NSString*)action;

-(void) popRightNavigationController;
-(void) pushRightNavigationController:(SASlideMenuNavigationController*)navigationController;

-(UINavigationController*) controllerForAction:(NSString*) action;

-(void) doSlideToSide;
-(void) doSlideToLeftSide;
-(void) doSlideIn:(void (^)(BOOL completed))completion;

-(void) rightMenuAction;
-(void) addRightMenu;

-(void) panItem:(UIPanGestureRecognizer*)gesture;
-(void) clearControllers;


@end
