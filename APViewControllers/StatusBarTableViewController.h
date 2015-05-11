//
//  MainTableViewController.h
//  TableViewTests
//
//  Created by Flavio Negrão Torres on 04/03/15.
//  Copyright (c) 2015 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusBarTableViewController : UITableViewController

- (void) showNotificationBarWithText:(NSString *)text
                       withTextColor:(UIColor*) textColor
                     backgroundColor:(UIColor*) backgroundColor;

- (void) hideNotificationStatus;

@end
