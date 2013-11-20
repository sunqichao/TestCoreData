//
//  SQCFetchedResultsController.m
//  TestCoreData
//
//  Created by sun qichao on 13-11-20.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "SQCFetchedResultsController.h"
@interface SQCFetchedResultsController ()

@property (nonatomic, strong) UITableView* tableView;

@end


@implementation SQCFetchedResultsController

- (id)initWithTableView:(UITableView*)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;

    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.sqcFetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    id<NSFetchedResultsSectionInfo> section = self.sqcFetchedResultsController.sections[sectionIndex];
    return section.numberOfObjects;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier];
    
    if (cell == nil) {
        
        Class someClass = NSClassFromString(_reuseIdentifier);
        
        cell = [[someClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_reuseIdentifier];

    }
    
    // Configure the cell...
    
    id data = [_sqcFetchedResultsController objectAtIndexPath:indexPath];
    
    [_delegate configCellData:data cell:cell];
    
    return cell;
}


@end
