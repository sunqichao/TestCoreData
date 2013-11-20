//
//  MainViewController.m
//  TestCoreData
//
//  Created by sun qichao on 13-11-19.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import "MainViewController.h"
#import "SQCEntity.h"
#import "AppDelegate.h"

@interface MainViewController ()
@property (nonatomic ,strong) SQCFetchedResultsController *sqcFetchedResultsController;

@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //初始化fetchedResultsController的实例
    self.sqcFetchedResultsController = [[SQCFetchedResultsController alloc] initWithTableView:self.tableView];
    self.sqcFetchedResultsController.sqcFetchedResultsController = [SQCEntity fetchedResultsController];
    self.sqcFetchedResultsController.delegate = self;
    self.sqcFetchedResultsController.reuseIdentifier = @"UITableViewCell";
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - sqcfetchedresultscontroller delegate
//配置cell要显示的数据
- (void)configCellData:(id)data cell:(id)cell
{
    UITableViewCell *cellView = (UITableViewCell *)cell;
    SQCEntity *entity = (SQCEntity *)data;
    cellView.textLabel.text = entity.name;

}
//选中其中一行后进行的操作
- (void)didselectRowData:(id)data
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate addTestDatasource];
    
}

 




@end
