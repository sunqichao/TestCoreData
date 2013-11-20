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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = [_sqcFetchedResultsController objectAtIndexPath:indexPath];
    [_delegate didselectRowData:data];
    
}

#pragma mark - 设置fetchedresults的delegate

- (void)setSqcFetchedResultsController:(NSFetchedResultsController *)sqcFetchedResultsController
{
    _sqcFetchedResultsController = sqcFetchedResultsController;
    sqcFetchedResultsController.delegate = self;
    NSError *error;
    if (![sqcFetchedResultsController performFetch:&error]) {       //启动
        NSLog(@"Unresolved error %@, %@",error, [error userInfo]);
        exit(-1);
    }
    
}

#pragma mark - 暂停的方法，比如说对应的视图被隐藏的时候就让自动更新机制暂停，当回到视图的时候再让它开始
- (void)setPaused:(BOOL)paused
{
    _paused = paused;
    if (paused) {
        self.sqcFetchedResultsController.delegate = nil;
    } else {
        self.sqcFetchedResultsController.delegate = self;
        [self.sqcFetchedResultsController performFetch:NULL];
        [self.tableView reloadData];
    }
}

#pragma mark - fetchedResults delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

//自增长的代理方法，有数据改变了，会通知这里的，因为需求只有插入数据，所以这里只写了一个，还有删除，更新，等等
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath;
{
    UITableView *tableView = self.tableView;
    
    if (type == NSFetchedResultsChangeInsert) {
        [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeMove) {
        [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    } else if (type == NSFetchedResultsChangeDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        NSAssert(NO,@"");
    }
    
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
    
}


@end
