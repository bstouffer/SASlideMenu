//
//  SAMenuItem.m
//
//  Created by Bryan on 6/23/13.
//
//

#import "SAMenuItem.h"

@implementation SAMenuItem

@synthesize itemTitle, itemAction;

-(id)initWithTitle:(NSString*) title action:(NSString*) action{
    self = [super init];
    if(self)
    {
        itemTitle = title;
        itemAction = action;

        return self;
    }
    return nil;
}

@end
