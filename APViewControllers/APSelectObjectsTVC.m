//
//  SelectTVC.m
//  MilkMap
//
//  Created by Flavio Torres on 20/08/13.
//  Copyright (c) 2013 Apetis. All rights reserved.
//

#import "APSelectObjectsTVC.h"


@interface APSelectObjectsTVC ()

@property (nonatomic, strong) void (^viewDidSelectCallBack) (BOOL selected, NSUInteger indexIndex);
@property (nonatomic, strong) void (^viewDidSelectObject) (id object);

@property (nonatomic, strong) NSMutableIndexSet* mutableIndexOfSelectedObjects;
@end

@implementation APSelectObjectsTVC

#pragma mark - View Lifecycle
- (void) awakeFromNib {
    [super awakeFromNib];
    [self configView];
}


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) [self configView];
    return self;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
         if (self) [self configView];
    }
    return self;
}


- (void) configView {
    //defaults
    self.allowMultipleSelections = YES;
    self.allowSelectNone = NO;
    //[self.tableView setHidden:YES];
}


- (void) setViewDidSelectCallBack: (void (^)(BOOL selected, NSUInteger indexIndex)) block {
    _viewDidSelectCallBack = block;
}



#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.indexSetOfSelectedObjects containsIndex:indexPath.item]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    BOOL isSelecting = [self.mutableIndexOfSelectedObjects containsIndex:indexPath.item];
    
    if (isSelecting) {
        
        // Celula já estava marcada com o Checkmark
        
        if ([self.mutableIndexOfSelectedObjects count] > 1 || self.allowSelectNone) {
            //Retirnar indexPath do array
            [self.mutableIndexOfSelectedObjects removeIndex:indexPath.item];
            
            //Desmarcar a celula
            selectedCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    } else {
        
        // Selecionou um celula não marcada
        
        if (self.allowMultipleSelections || [self.mutableIndexOfSelectedObjects count] == 0) {
            [self.mutableIndexOfSelectedObjects addIndex:indexPath.item];
            selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;

        } else if (self.allowMultipleSelections == NO && [self.mutableIndexOfSelectedObjects count] > 0) {
            NSIndexPath* indexPathOfPreviouslySelectedCell = [NSIndexPath indexPathForItem:[self.mutableIndexOfSelectedObjects firstIndex] inSection:0];
            UITableViewCell *previouslySelectedCell = [self.tableView cellForRowAtIndexPath:indexPathOfPreviouslySelectedCell];
            previouslySelectedCell.accessoryType = UITableViewCellAccessoryNone;
            [self.mutableIndexOfSelectedObjects removeIndex:indexPathOfPreviouslySelectedCell.item];
            
            [self.mutableIndexOfSelectedObjects addIndex:indexPath.item];
            selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.viewDidSelectCallBack) self.viewDidSelectCallBack(isSelecting,indexPath.item);
    
    id object = [self objectAtIndexPath:indexPath];
    if (self.viewDidSelectObject) self.viewDidSelectObject(object);
}


- (NSMutableIndexSet*) mutableIndexOfSelectedObjects  {
    
    if (_mutableIndexOfSelectedObjects == nil) {
        _mutableIndexOfSelectedObjects = [NSMutableIndexSet indexSet];
    }
    return _mutableIndexOfSelectedObjects;
}


- (NSIndexSet*) indexSetOfSelectedObjects {
    
    return [self.mutableIndexOfSelectedObjects copy];
}

                                          
- (void) setIndexSetOfSelectedObjects:(NSIndexSet *)indexSetOfSelectedObjects {
    
    _mutableIndexOfSelectedObjects = [indexSetOfSelectedObjects mutableCopy];
    [self.tableView reloadData];
}


@end
