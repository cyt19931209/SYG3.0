//
//  BrandChoiceViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "BrandChoiceViewController.h"

@interface BrandChoiceViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITextField *findTextField;
    
}

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,copy) NSString *keyword;

@end

@implementation BrandChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _keyword = @"";
    
    self.navigationItem.title = @"品牌选择";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    _dataArr = [NSMutableArray array];
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    

    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 56)];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:whiteView];
    
    
    findTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 80, 34)];
    
    findTextField.backgroundColor = [RGBColor colorWithHexString:@"#f7f7f7"];
    
    findTextField.font = [UIFont systemFontOfSize:16];
    
    findTextField.placeholder = @"请输入你要查找的内容";

    findTextField.borderStyle = UITextBorderStyleRoundedRect;

    [whiteView addSubview:findTextField];
    
    UIButton *findButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    findButton.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
    
    findButton.frame = CGRectMake(kScreenWidth - 60 , 10, 50, 34);
    
    [findButton setTitle:@"查找" forState:UIControlStateNormal];
    findButton.titleLabel.font = [UIFont systemFontOfSize:16];
    findButton.layer.cornerRadius = 8;
    findButton.layer.masksToBounds = YES;
    
    [findButton addTarget:self action:@selector(findButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteView addSubview:findButton];
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 56, kScreenWidth, kScreenHeight - 56 - 64) style:UITableViewStyleGrouped];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    _myTableView.sectionIndexColor = [RGBColor colorWithHexString:@"#666666"];
    
    _myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    [self loadData];
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    [self.view addGestureRecognizer:singleRecognizer];

}

- (void)singleAction{

    [findTextField resignFirstResponder];

}

- (void)loadData{

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_sort_id forKey:@"category_id"];

    [DataSeviece requestUrl:get_brands_by_category_idhtml params:params success:^(id result) {
        
        [_dataArr removeAllObjects];
        
        NSArray * arr = result[@"result"][@"data"][@"item"];
        
        
        for (int i = 0; i < arr.count; i++) {
         
            NSString *str = [arr[i][@"brands_name"] substringToIndex:1].uppercaseString;

            if (i == 0 ) {
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                
                [dic setObject:str forKey:@"title"];
                
                NSMutableArray *array = [NSMutableArray array];
                
                [array addObject:arr[i]];
                
                [dic setObject:array forKey:@"item"];
                
                [_dataArr addObject:dic];
                
            }else{

                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[_dataArr lastObject]];
                NSString *str1 = dic[@"title"];
                
                if ([str1.uppercaseString isEqualToString:str]) {
                    
                    NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"item"]];
                    
                    [array addObject:arr[i]];
                    
                    [dic setObject:array forKey:@"item"];
                    
                    [_dataArr replaceObjectAtIndex:_dataArr.count - 1 withObject:dic];
                }else{
                
                    NSMutableArray *array = [NSMutableArray array];
                    
                    [array addObject:arr[i]];
                    
                    [dic setObject:array forKey:@"item"];
                    
                    [dic setObject:str forKey:@"title"];
                    
                    [_dataArr addObject:dic];

                }
                
            }
            
        }
        
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = _dataArr[section][@"item"];
    
    return arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrandCell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    }
    
    cell.textLabel.text = _dataArr[indexPath.section][@"item"][indexPath.row][@"brands_name"];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UITableViewHeaderFooterView *headerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BrandHeaderView"];
    
    if (!headerView) {
        
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"BrandHeaderView"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 20)];

        label.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        label.font = [UIFont systemFontOfSize:14];
        
        label.tag = 200;
        
        [headerView.contentView addSubview:label];
        
        headerView.contentView.backgroundColor = [RGBColor colorWithHexString:@"#f7f7f7"];
 
    }
    
    UILabel *label = [headerView.contentView viewWithTag:200];
    
    label.text = _dataArr[section][@"title"];
    
    return headerView;

}



- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in _dataArr) {
        
        [toBeReturned addObject:dic[@"title"]];
    }
    
    return toBeReturned;
    
}



- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
  
    NSInteger num = 0;
    for (int i = 0; i < index; i++) {
        
        NSArray *itemArr = _dataArr[i][@"item"];
        
        num = num + itemArr.count;
        
    }
    
    
    NSInteger y= num *48 +index *22;
    
    [tableView setContentOffset:CGPointMake(0, y) animated:NO];

    
    return NSNotFound;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.navigationController popViewControllerAnimated:YES];


    [[NSNotificationCenter defaultCenter] postNotificationName:@"BrandChoiceNotification" object:_dataArr[indexPath.section][@"item"][indexPath.row]];

}


- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];

}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)findButtonAction{
    
    _keyword = findTextField.text;
    
    [findTextField resignFirstResponder];

    
    [self loadData];
    

}


@end
