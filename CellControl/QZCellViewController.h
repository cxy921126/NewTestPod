//
//  QZCellViewController.h
//  CellControl
//
//  Created by Noodles on 15-12-15.
//  Copyright (c) 2015年 QZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QZCellViewController;
@protocol QZCellViewControllerDelegate <NSObject>
-(void)qzCellViewCtrl:(QZCellViewController*)qzvc passValue:(NSArray*)arr andIndex:(NSInteger)index;
@end

@interface QZCellViewController : UITableViewController
@property (assign,nonatomic) id<QZCellViewControllerDelegate> qzDelegate;
@property (copy,nonatomic) NSMutableArray* selectedArr;
@property (assign,nonatomic) NSInteger selectedIndex;
@end
