//
//  SideNavigationViewController.m
//  NK
//
//  Created by speak share on 13-1-28.
//  Copyright (c) 2013年 nnkou. All rights reserved.
//

#import "SideNavigationViewController.h"
#import "ViewController.h"
#import "SideControllViewController.h"

@interface SideNavigationViewController (){
}

@end

@implementation SideNavigationViewController

- (id)initWithControllArray:(NSArray *)array
{
    if ([self init]) {
        _p_SelectTag = 10;
        _p_ControlersArray = array;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化数据
    self.p_TitleArray = @[@[@"牛扣推荐"],@[@"优惠",@"团购",@"活动",@"免费店",@"首页",@"我的牛扣"]];
    
    //调整table高度
    int titleCount = [[self.p_TitleArray objectAtIndex:1] count];
    CGFloat tableHeight = titleCount * 44.0 - 1;
    self.m_SideTableView.frame = CGRectSetH(self.m_SideTableView.frame, tableHeight);
    
    NSString *topButtonTitle = self.p_TitleArray[0][0];
    [self.m_TopButton setTitle:topButtonTitle forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)topButtonClickAction:(id)sender {
    [self popToControllerOfSection:0 ofRow:0];
}

- (void)popToControllerOfSection:(int)section ofRow:(int)row{
    int selectTag = section * 10 + row;
    ViewController *viewController = [ViewController getViewCtrl];
   
        @try {
            
            NSLog(@"%d,row%d",section,row);
            id controller = self.p_ControlersArray[section][row];
            [viewController popViewControllerWithNewCenterController:controller animated:YES];
            _p_SelectTag = selectTag;
        }
        @catch (NSException *exception) {
            return;
        }
  }

#pragma mark --
#pragma mark -- UITableView Methods
- (NSUInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [self.p_TitleArray objectAtIndex:1];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = [indexPath row];
    static NSString *CellIndefiner = @"CellIndefiner";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndefiner];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndefiner];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *title = [[self.p_TitleArray objectAtIndex:1] objectAtIndex:row];
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont fontWithName: @"Arial" size: 14.0 ];
    cell.textLabel.textColor = [UIColor colorWithR:99 G:36 B:49];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = [indexPath row];
    
    NSLog(@"row%d",row);
    [self popToControllerOfSection:1 ofRow:row];
}

@end
