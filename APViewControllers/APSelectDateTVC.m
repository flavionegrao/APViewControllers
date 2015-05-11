//
//  SelectDateVC.m
//  Latte
//
//  Created by Flavio Torres on 2/04/13.
//  Copyright (c) 2013 Apetis. All rights reserved.
//

#import "APSelectDateTVC.h"
#import "APCellDatePicker.h"


@interface APSelectDateTVC ()

@property (nonatomic, copy) void (^dateDidChange)(NSDate* date);

@end


@implementation APSelectDateTVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        _pickerMode = UIDatePickerModeTime;
        _date = [NSDate date];
    }
    return self;
}


- (NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.footer;
}


- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.header;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 217;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    APCellDatePicker* cell = [[APCellDatePicker alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    cell.selectedDate = self.date;
    cell.pickerMode = self.pickerMode;
    cell.maximumDate = self.maximumDate;
    
    [cell setPickerDidChangeValue:^(NSDate *date) {
        self.date = date;
        if (self.dateDidChange) self.dateDidChange(date);
    }];
    return cell;
}


- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (void) changePickerForToday: (UIBarButtonItem*) sender {
    APCellDatePicker* cell = (APCellDatePicker*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    NSDate* today = [NSDate date];
    cell.selectedDate = today;
    self.date = today;
    if (self.dateDidChange) self.dateDidChange(today);
}



@end
