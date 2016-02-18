//
//  QZCellController.m
//  CellControl
//
//  Created by Noodles on 15-12-15.
//  Copyright (c) 2015年 QZ. All rights reserved.
//

#import "QZCellController.h"
#import "AFNetworking.h"
#import "QZCellViewController.h"

@interface QZCellController () <QZCellViewControllerDelegate>
@property (strong,nonatomic) NSMutableArray* user;
@property (copy,nonatomic) NSMutableArray* detail;
@end

@implementation QZCellController
//QZCellViewController* qzCV;

-(void)getData{
    AFHTTPRequestOperationManager* mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:@"http://localhost:3000/User" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.user = [responseObject mutableCopy];
        NSLog(@"%@",[[self.user[0] valueForKey:[[self.user[0] allKeys] firstObject]]allObjects]);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getData];
    self.tableView.rowHeight = 105;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _user.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    NSString* title = [[self.user[indexPath.row] allKeys]firstObject];
    self.detail = [[[self.user[indexPath.row] valueForKey:[[self.user[indexPath.row] allKeys]firstObject]]allObjects]mutableCopy];
    
    cell.textLabel.text =title;
    cell.detailTextLabel.text = [self.detail componentsJoinedByString:@" , "];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QZCellViewController *qzCV = [[QZCellViewController alloc]init];
    //qzCV.selectedArr = [[self.user[indexPath.row] allObjects]firstObject];
    qzCV.selectedArr = [[[self.user[indexPath.row] valueForKey:[[self.user[indexPath.row] allKeys]firstObject]]allObjects]mutableCopy];
    qzCV.selectedIndex = indexPath.row;
    qzCV.qzDelegate =self;
    [self.navigationController pushViewController:qzCV animated:YES];
}

#pragma mark - 实现qzcellviewcontroller的代理方法
-(void)qzCellViewCtrl:(QZCellViewController *)qzvc passValue:(NSArray *)arr andIndex:(NSInteger)index{
    //将更改后的数组传回，放入一个新的字典，并且替换到user数组中
    NSMutableDictionary* dicM = [[self.user objectAtIndex:index] mutableCopy];
    [dicM setObject:arr forKey:[[dicM allKeys]firstObject]];
    [self.user replaceObjectAtIndex:index withObject:dicM];
    [self.tableView reloadData];
}



@end
