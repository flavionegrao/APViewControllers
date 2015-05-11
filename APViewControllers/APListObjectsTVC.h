//
//  ListObjectsTVC.h
//  MilkMap
//
//  Created by Flavio Negrão Torres on 5/5/14.
//  Copyright (c) 2014 Apetis. All rights reserved.
//

@import UIKit;

@interface APListObjectsTVC : UITableViewController

@property (nonatomic,copy) NSArray* datasource;

#pragma mark - Lista Vazia

/**
 If the datasource has no elements this is the Header text to be showed.
 It will not be showed if the datasource is nil.
 */
@property (nonatomic,strong) NSString* emptyListHeaderText;


/**
 If the datasource has no elements this is the body text to be showed.
 It will not be showed if the datasource is nil.
 */
@property (nonatomic,strong) NSString* emptyListBodyText;


/// Backgound color of the emptylist view
@property (nonatomic,strong) UIColor* emptyListBGColor;


/// Header text color of the emptylist view
@property (nonatomic,strong) UIColor* emptyHeaderTextColor;


/// Body text color of the emptylist view
@property (nonatomic,strong) UIColor* emptyHeaderBodyColor;

/// Custom Cell Indentifier to be used by the tableView.
@property (nonatomic,strong) NSString* cellIdentifier;


/// Default is UITableViewCellStyleDefault
@property (assign, nonatomic) UITableViewCellStyle defaultCellStyle;


/*
 If the datasource is a Array of Strings then it will user each String as the textLabel of each cell. Otherwise the datasource must be a Array of Dictionaries, therefore cellTextLabelKey must be set and optinally cellDetailTextLabelKey and cellImageKey may be set.
 */

@property (copy, nonatomic) NSString* cellTextLabelKey;
@property (copy, nonatomic) NSString* cellDetailTextLabelKey;
@property (copy, nonatomic) NSString* cellImageKey;

/// Set it to enable sections. Like with NSFetchResultController the objects must be ordered by the sectionKey;
@property (copy, nonatomic) NSString* sectionKey;

- (id) objectAtIndexPath:(NSIndexPath*) indexPath;


@end
