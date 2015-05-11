//
//  MainTableViewController.m
//  TableViewTests
//
//  Created by Flavio Negrão Torres on 04/03/15.
//  Copyright (c) 2015 Apetis. All rights reserved.
//

#import "StatusBarTableViewController.h"

static NSInteger const statusBarHeight = 30;

@interface StatusBarTableViewController()
@property (nonatomic, assign) CGFloat originalTabbleViewTopContentInset;
@property (nonatomic, weak) UIView* notificationView;
@property (nonatomic, weak) UILabel* notificationLabel;
@property (nonatomic, assign) CGFloat originalNotificationViewOrigin;
@property (nonatomic, assign, getter=isViewFirstAppear) BOOL viewFirstAppear;
@property (nonatomic, assign, getter=isShowingNotification) BOOL showingNotification;
@end

@implementation StatusBarTableViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.viewFirstAppear = YES;
    self.showingNotification = NO;
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.isViewFirstAppear) {
        self.originalTabbleViewTopContentInset = self.tableView.contentInset.top;
        self.originalNotificationViewOrigin = self.tableView.bounds.origin.y;
        self.viewFirstAppear = NO;
    }
}

#pragma mark - Notification Status Bar

- (void) showNotificationBarWithText:(NSString *)text withTextColor:(UIColor*) textColor backgroundColor:(UIColor*) backgroundColor {
    
    if (!self.notificationView) {
        UIView* notificationView = [[UIView alloc]init];
        notificationView.frame = CGRectMake(0, -statusBarHeight, self.tableView.frame.size.width, 0);
        notificationView.backgroundColor = backgroundColor;
        notificationView.alpha = 0.85;
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.text = text;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = textColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [notificationView addSubview:label];
        [notificationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[label]-|" options:0 metrics:nil views:@{@"label":label}]];
        [notificationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics:nil views:@{@"label":label}]];
        self.notificationLabel = label;
        
        [self.tableView addSubview:notificationView];
        
        [UIView animateWithDuration:0.3 animations:^{
            notificationView.frame = CGRectMake(0, -statusBarHeight, self.tableView.frame.size.width, statusBarHeight);
            [self.tableView setContentInset:UIEdgeInsetsMake(self.originalTabbleViewTopContentInset + statusBarHeight, 0, 0, 0)];
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 320, 1) animated:YES];
        }];
        
        self.originalNotificationViewOrigin = self.notificationView.frame.origin.y;
        self.notificationView = notificationView;
        
    } else {
        self.notificationLabel.text = text;
        self.notificationView.backgroundColor = backgroundColor;
        self.notificationLabel.textColor = textColor;
    }
    self.showingNotification = YES;
}

- (void) hideNotificationStatus {
    if (self.notificationView) {
        self.showingNotification = NO;;
        [UIView animateWithDuration:0.3 animations:^{
            [self.tableView setContentInset:UIEdgeInsetsMake(self.originalTabbleViewTopContentInset, 0, 0, 0)];
        } completion:^(BOOL finished) {
            [self.notificationView removeFromSuperview];
        }];
    }
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.isShowingNotification) {
        CGRect tableBounds = self.tableView.bounds;
        CGRect notificationViewFrame = self.notificationView.frame;
        
        // Refresh controllers adds it when is enabled
        CGFloat tableViewTopInsetOffeset = self.tableView.contentInset.top - self.originalTabbleViewTopContentInset;

        notificationViewFrame.origin.y = self.originalNotificationViewOrigin + tableBounds.origin.y + self.tableView.contentInset.top - tableViewTopInsetOffeset;
        self.notificationView.frame = notificationViewFrame;
        [self.view bringSubviewToFront: self.notificationView];
    }
}

@end
