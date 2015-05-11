//
//  ListObjectsTVC.m
//  MilkMap
//
//  Created by Flavio Negrão Torres on 5/5/14.
//  Copyright (c) 2014 Apetis. All rights reserved.
//

#import "APListObjectsTVC.h"

@interface APListObjectsTVC ()

@property (nonatomic, strong) NSString* originalViewTitle;
@property (nonatomic, strong) NSArray* sections;

@end


@implementation APListObjectsTVC


#pragma mark - Getters and Setters
- (void) setDatasource:(NSArray *)datasource {
    
    // O data source precisa ser no formado Arrays of Arrays
    if ([datasource isKindOfClass:[NSArray class]]) {
        _datasource = datasource;
        
        if (self.sectionKey) {
            [self configSections];
        }
        [self.tableView reloadData];
        
    } else {
        NSLog(@"Data source must be a NSArrays");
    }
}

- (void) setSectionKey:(NSString *)sectionKey {
    _sectionKey = sectionKey;
    if (self.datasource && sectionKey) {
        [self configSections];
    }
}


#pragma mark - Table view data source

- (id) objectAtIndexPath:(NSIndexPath*) indexPath {
    NSInteger indexOfObject = 0;
    for (NSInteger sectionIndex = 0; sectionIndex < indexPath.section; sectionIndex++) {
        indexOfObject += [self.tableView numberOfRowsInSection:sectionIndex];
    }
    indexOfObject += indexPath.item;
    return self.datasource[indexOfObject];
}

- (void) configSections {
    NSString* keyPath = [NSString stringWithFormat:@"@distinctUnionOfObjects.%@",self.sectionKey];

    self.sections = [[self.datasource valueForKeyPath:keyPath]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.sectionKey) {
        return [self.sections count];
    } else {
        return (self.datasource) ? 1 : 0;
    }
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return self.sections[section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.sectionKey) {
        NSString* sectionTitle = self.sections[section];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K == %@",self.sectionKey,sectionTitle];
        NSArray* objects = [self.datasource filteredArrayUsingPredicate:predicate];
        NSInteger numberOfRows = [objects count];
        return numberOfRows;
        
    } else {
        return [self.datasource count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Caso exista um self.CellIdentifier quer dizer que existe uma celular criada via StoryBoard
    // Caso contratio criamos um celula UITableViewCellStyleDefault para ser usada.
    
    static NSString* unidentifiedCell = @"unidentifiedCell";
    UITableViewCell *cell;
    
    if (self.cellIdentifier) {
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:unidentifiedCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle: self.defaultCellStyle reuseIdentifier:unidentifiedCell];
        }
    }
    
    id object = [self objectAtIndexPath:indexPath];
    
    if (self.cellTextLabelKey) {
        cell.textLabel.text = NSLocalizedString([object valueForKeyPath:self.cellTextLabelKey], nil);
    
    } else if ([object isKindOfClass:[NSString class]]){
        cell.textLabel.text = NSLocalizedString(object, nil);
    
    } else {
        NSLog(@"You don't override APListCoreDataTVC you need to set at least cellTextLabelKey");
    }
    
    cell.detailTextLabel.text = (self.cellDetailTextLabelKey) ? NSLocalizedString([object valueForKeyPath:self.cellDetailTextLabelKey],nil) : nil;
    cell.imageView.image = (self.cellImageKey) ? [object valueForKeyPath:self.cellImageKey]: nil;
    
    return cell;
}




@end
