//
//  SQCFetchedResultsController.h
//  TestCoreData
//
//  Created by sun qichao on 13-11-20.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SQCFetchedResultsDelegate <NSObject>

/*
 实现这个方法来配置cell上的data数据
 
 cell：要配置书就的cell
 
 data：对应的数据（index根据index取出的，所以没有传indexpath）
 
 */

- (void)configCellData:(id)data cell:(id)cell;

/*
 didselectrow的方法
 
 */

- (void)didselectRowData:(id)data;


@end

@interface SQCFetchedResultsController : NSObject<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

//控制数据自动更新的fetchedresultsController
@property (nonatomic ,strong) NSFetchedResultsController *sqcFetchedResultsController;

@property (nonatomic ,weak) id <SQCFetchedResultsDelegate> delegate;

//cell的名称，重用名
@property (nonatomic ,copy) NSString* reuseIdentifier;

//是否暂停自动化观察数据
@property (nonatomic ,assign) BOOL paused;


- (id)initWithTableView:(UITableView*)tableView;


@end
