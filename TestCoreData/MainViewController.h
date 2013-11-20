//
//  MainViewController.h
//  TestCoreData
//
//  Created by sun qichao on 13-11-19.
//  Copyright (c) 2013年 sun qichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQCFetchedResultsController.h"

@interface MainViewController : UITableViewController<NSFetchedResultsControllerDelegate,SQCFetchedResultsDelegate>

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic ,strong) NSFetchedResultsController *fetchedResultsController;

@end
