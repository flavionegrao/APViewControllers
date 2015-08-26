//
//  LoadingTableViewController.m
//  TableViewControllerTests
//
//  Created by Flavio Negrão Torres on 11/07/15.
//  Copyright (c) 2015 Apetis. All rights reserved.
//

#import "LoadingTableViewController.h"

@interface LoadingView : UIView
@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) [self config];
    return self;
}

- (void) config {
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator startAnimating];
    [self addSubview:activityIndicator];
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:activityIndicator attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:activityIndicator attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

@end


@interface LabelView : UIView
@property (nonatomic, weak) UILabel* label;
@property (nonatomic, weak) UIButton* button;
@end

@implementation LabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) [self config];
    return self;
}

- (void) config {
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeBottom multiplier:1 constant:4]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[label]-|" options:0 metrics:nil views:@{@"label":label}]];

    UIButton* button = [[UIButton alloc]initWithFrame:CGRectZero];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:button];
    self.button = button;
    [self.button setTitleColor:self.label.textColor forState:UIControlStateNormal];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeTop multiplier:1 constant:4]];
}

@end



@interface LoadingDataSource : NSObject <UITableViewDataSource>
@end

@implementation LoadingDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {return 0;}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{return 0;}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {return nil;}
@end



@interface LoadingTableViewController()

@property (nonatomic,strong) id<UITableViewDataSource> originalDataSource;
@property (nonatomic,strong) id<UITableViewDataSource> loadingDataSource;
@property (nonatomic,strong) LoadingView* loadingView;
@property (nonatomic,strong) LabelView* noContentView;

@property (nonatomic, strong) UIColor* originalCellsSeparatorColor;

@end


@implementation LoadingTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self config];
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
      [self config];
}

- (id<UITableViewDataSource>) loadingDataSource {
    if (!_loadingDataSource) {
        _loadingDataSource = [LoadingDataSource new];
    }
    return _loadingDataSource;
}


- (void) config {
    _loadingView = [[LoadingView alloc]initWithFrame:CGRectZero];
    _noContentView = [[LabelView alloc]initWithFrame:CGRectZero];
    _noContentLabel = _noContentView.label;
    _noContentButton = _noContentView.button;
}


- (void) viewDidLoad {
    [super viewDidLoad];
    self.originalDataSource = self.tableView.dataSource;
    self.originalCellsSeparatorColor = self.tableView.separatorColor;

}


- (void) setContentStatus:(UITableViewContentStatus)contentStatus {
    switch (contentStatus) {
        case UITableViewContentStatusLoading: {
            self.tableView.backgroundView = self.loadingView;
            self.tableView.backgroundView.backgroundColor = self.tableView.backgroundColor;
            self.tableView.separatorColor = [UIColor clearColor];
            self.tableView.dataSource = self.loadingDataSource;
            
            break;
        }
            
        case UITableViewContentStatusEmpty: {
            self.tableView.backgroundView = self.noContentView;
            self.tableView.backgroundView.backgroundColor = self.tableView.backgroundColor;
            self.tableView.separatorColor = [UIColor clearColor];
            self.tableView.dataSource = self.loadingDataSource;
            break;
        }
            
        case UITableViewContentStatusLoaded: {
            self.tableView.separatorColor = self.originalCellsSeparatorColor;
            self.tableView.backgroundView = nil;
            self.tableView.dataSource = self.originalDataSource;
        }
    }
    
    [self.tableView reloadData];
}



@end
