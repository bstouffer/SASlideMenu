//
//  SAMenuItem.h
//
//  Created by Bryan on 6/23/13.
//
//

#import <Foundation/Foundation.h>

@interface SAMenuItem : NSObject

@property (strong, nonatomic) NSString* itemTitle;
@property (strong, nonatomic) NSString* itemAction;

-(id)initWithTitle:(NSString*) title action:(NSString*) action;

@end

