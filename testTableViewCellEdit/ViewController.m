//
//  ViewController.m
//  testTableViewCellEdit
//
//  Created by yulingsong on 16/1/8.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *m_tableview;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ViewController
@synthesize m_tableview;
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        for (int i = 'A'; i <= 'Z'; i ++)
        {
            [_dataArr addObject:@(i)];
        }
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test TableView";
    [self createTableView];
}

-(void)createTableView
{
    if (!m_tableview)
    {
        self.m_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ];
        [self.view addSubview:m_tableview];
    }
    [m_tableview setScrollEnabled:YES];
    [m_tableview setDelegate:self];
    [m_tableview setDataSource:self];
    [m_tableview setShowsVerticalScrollIndicator:NO];
    [m_tableview setUserInteractionEnabled:YES];
    [m_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"identifier:%d",(int)indexPath.row];
    TestTableViewCell *cell = (TestTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[TestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell.m_back setHidden:NO];
    [cell.m_back setFrame:CGRectMake(20, 0, 333, 128)];
    [cell.m_back setBackgroundColor:[UIColor lightGrayColor]];
    [cell.m_back.layer setCornerRadius:5];
    
    [cell.m_button setHidden:NO];
    [cell.m_button setFrame:CGRectMake(30, 0, 40, 50)];
    [cell.m_button setBackgroundColor:[UIColor cyanColor]];
    [cell.m_button setTitle:[NSString stringWithFormat:@"%ld",indexPath.row+1] forState:UIControlStateNormal];
    [cell.m_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.m_button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.m_label setHidden:NO];
    [cell.m_label setFrame:CGRectMake(250, 0, 40, 50)];
    NSNumber *num = self.dataArr[indexPath.row];
    [cell.m_label setText:[NSString stringWithFormat:@"%c",num.intValue]];
    [cell.m_label setTextAlignment:NSTextAlignmentCenter];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 136;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)delete:(NSIndexPath *)indexPath
{
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        [self.dataArr addObject:@100];
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0];
        [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"撤单";
}

//当滚动视图发生位移，就会进入下方代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:1000];

    CGPoint point = scrollView.contentOffset;

    NSInteger index = round(point.x/scrollView.frame.size.width);

    pageControl.currentPage = index;
}



@end
