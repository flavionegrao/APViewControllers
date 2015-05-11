//
//  SelectObjectsTVC.h
//  MilkMap
//
//  Created by Flavio Torres on 20/08/13.
//  Copyright (c) 2013 Apetis. All rights reserved.
//

@import UIKit;

#import "APListObjectsTVC.h"

/**
 This class takes a NSArray as datasource and and uses a NSIndexSet to mark the selected cells.
 It will keep the current selected cells on indexSetOfSelectedObjects and for every new selection
 or deselection will call the block set with -[SelectObjectsTVC setViewDidSelectCallBack:]
 
 @author Flavio Negrão Torres
 */
@interface APSelectObjectsTVC : APListObjectsTVC


/// IndexPaths for the selected objects
@property (nonatomic,strong) NSIndexSet* indexSetOfSelectedObjects;


/** 
 Whether or not the tableview should allow more than one item being selected
 Default value is YES
 */
@property (nonatomic,assign) BOOL allowMultipleSelections;


/** 
 Whether or not the tableview should allow none cells to be selected
 Default = NO
 */
@property (nonatomic,assign) BOOL allowSelectNone;


/**
 This block if set will be called everytime a new cell is selected or deselected
 @param selected if YES the cell was selected otherwise NO.
 @param itemIndex the index of the selected item in the datasource.
 */
- (void) setViewDidSelectCallBack: (void (^)(BOOL selected, NSUInteger index)) block;

- (void) setViewDidSelectObject: (void (^)(id object)) block;


@end
