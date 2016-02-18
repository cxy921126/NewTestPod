//
//  QZCellViewController.m
//  CellControl
//
//  Created by Noodles on 15-12-15.
//  Copyright (c) 2015年 QZ. All rights reserved.
//

#import "QZCellViewController.h"

@interface QZCellViewController ()<UIAlertViewDelegate,UINavigationControllerDelegate>
@property (copy,nonatomic) NSMutableArray* arrM;
@property (copy,nonatomic) NSIndexPath* modifyIndex;
@end

@implementation QZCellViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBar];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.navigationController.delegate = self;
    _arrM = [self.selectedArr mutableCopy];
}

-(void)setNavBar
{
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = addBtn;
    self.navigationItem.title = @"Update";
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
    return self.arrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    //以代码创建Cell时必须给tableview注册该cell类
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.arrM[indexPath.row]];
    return cell;
}

#pragma mark - 实现删除cell
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSIndexPath* index = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        [self.arrM removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
        [self passValue];
    }
}

#pragma mark 实现添加按钮的监听
- (void)addItem:(id)sender {
    UIAlertView* input = [[UIAlertView alloc]init];
    input=[input initWithTitle:@"Add" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    input.alertViewStyle = UIAlertViewStylePlainTextInput;
    [input show];
}


#pragma mark 点击cell进行修改
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView* modify = [[UIAlertView alloc]initWithTitle:@"Modify" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    modify.alertViewStyle = UIAlertViewStylePlainTextInput;
    [modify textFieldAtIndex:0].text = [NSString stringWithFormat:@"%@",self.arrM[indexPath.row]];
    [modify show];
    self.modifyIndex = indexPath;
}

#pragma mark - 实现alertview的按钮点击监听
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView.title isEqual:@"Add"]){
        if (buttonIndex == 1) {
            UITextField* getAdd = [alertView textFieldAtIndex:0];
            NSString* newItem = getAdd.text;
            if([[newItem stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]){
                //判断输入的内容是否为纯空格
                [self.arrM addObject:newItem];
                NSIndexPath* index = [NSIndexPath indexPathForRow:self.arrM.count-1 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self passValue];
            }
        }
    }
    
    if ([alertView.title isEqual:@"Modify"]) {
        if (buttonIndex == 1) {
            UITextField* getModify = [alertView textFieldAtIndex:0];
            NSString* modifyItem = getModify.text;
            [self.arrM replaceObjectAtIndex:self.modifyIndex.row withObject:modifyItem];
            [self.tableView reloadData];
            [self passValue];
        }
        
    }
}

-(void)passValue{
    [self.qzDelegate qzCellViewCtrl:self passValue:self.arrM andIndex:self.selectedIndex];
}

@end
