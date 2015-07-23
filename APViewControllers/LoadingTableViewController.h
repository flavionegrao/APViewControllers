//
//  LoadingTableViewController.h
//  TableViewControllerTests
//
//  Created by Flavio Negrão Torres on 11/07/15.
//  Copyright (c) 2015 Apetis. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger, UITableViewContentStatus) {
    UITableViewContentStatusLoading = 0,
    UITableViewContentStatusEmpty,
    UITableViewContentStatusLoaded,
};


@interface LoadingTableViewController : UITableViewController

@property (nonatomic,assign) UITableViewContentStatus contentStatus;
@property (nonatomic,readonly,strong) UILabel* noContentLabel;
@property (nonatomic,readonly,strong) UIButton* noContentButton;


@end
