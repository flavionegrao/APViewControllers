//
//  SelectDateVC.h
//  Latte
//
//  Created by Flavio Torres on 2/04/13.
//  Copyright (c) 2013 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface APSelectDateTVC: UITableViewController

@property (nonatomic, copy) NSDate* date;

/// The header to be presented with the DataPickerCell
@property (strong, nonatomic) NSString* header;

/// The footer to be presented with the DataPickerCell
@property (strong, nonatomic) NSString* footer;

/// Maximum date to be presented by the controller
@property (strong, nonatomic) NSDate* maximumDate;

/// Default is UIDatePickerModeTime
@property (assign, nonatomic) UIDatePickerMode pickerMode;

/// É chamado sempre que a data for alterada
- (void) setDateDidChange:(void (^)(NSDate *date))dateDidChange;


@end

