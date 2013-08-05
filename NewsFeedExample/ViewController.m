//
//  ViewController.m
//  CustomTableViewCell
//
//  Created by ToanDK on 7/5/13.
//  Copyright (c) 2013 ToanDK. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTestData];
    
    [self getListNews];
}

// Tạo dữ liệu test.
// Hàm này chỉ chạy 1 lần duy nhất
-(void)setupTestData {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"list_news"]) {
        NSArray *list = @[[NSDictionary dictionaryWithObjectsAndKeys:
                           @"1", @"cellId",
                           @"cell 1", @"name",
                           @"Gervinho chuẩn bị hoàn tất thủ tục gia nhập AS Roma", @"content",
                           nil],
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"2", @"cellId",
                           @"cell 2", @"name",
                           @"Real gián tiếp tuyên bố có Gareth Bale: Áo đấu in tên Bale bán đầy thành Madrid", @"content",
                           nil],
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"3", @"cellId",
                           @"cell 3", @"name",
                           @"Lionel Messi có giá... 580 triệu euro!!!", @"content",
                           nil],
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"4", @"cellId",
                           @"cell 4", @"name",
                           @"Sandro Rosell: Muốn chiêu mộ Messi, hãy chuẩn bị đủ tiền để mua cả một thành phố lớn!", @"content",
                           nil],
                          ];
        [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"list_news"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(BOOL)isCellIdExisted:(NSString *)cellId {
    NSString *key = [NSString stringWithFormat:@"cell_%@", cellId];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key])
        return YES;
    return NO;
}

-(void)saveCellHeight:(float)height forCellId:(NSString *)cellId {
    NSString *key = [NSString stringWithFormat:@"cell_%@", cellId];
    [[NSUserDefaults standardUserDefaults] setFloat:height forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(float)getHeightForRow:(int)index withId:(NSString *)cellId {
    NSString *key = [NSString stringWithFormat:@"cell_%@", cellId];    
    float height = [[NSUserDefaults standardUserDefaults] floatForKey:key];
    return height;
}

// Calculate cell height chỉ chạy 1 lần duy nhất
-(void)calculateCellHeights {
    for (int i=0; i<listNews.count; i++) {
        NSDictionary *cellDict = listNews[i];
        NSString *cellId = cellDict[@"cellId"];
        // Chỉ tính toán cho các cell chưa tồn tại
        if (![self isCellIdExisted:cellId]) {
            NSLog(@"calculate cell height");
            float height = [CustomTableCell heightForCellWithDictionary:cellDict];
            [self saveCellHeight:height forCellId:cellId];
        }
    }
}

-(void)getListNews {
    listNews = [[NSUserDefaults standardUserDefaults] objectForKey:@"list_news"];
    [self calculateCellHeights];
    
    [myTableView reloadData];
}

#pragma mark UITableView delegate
-(int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listNews.count;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellDict = listNews[indexPath.row];
    NSString *cellId = cellDict[@"cellId"];
    float height = [self getHeightForRow:indexPath.row withId:cellId];
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CustomTableCell";
    
    CustomTableCell *cell = [myTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        UIViewController *tempVC = [[UIViewController alloc] initWithNibName:@"CustomTableCell" bundle:nil];
        cell = (CustomTableCell *)tempVC.view;
        NSLog(@"New cell: %d", indexPath.row);
    }
    [cell setupCellWithDictionary:listNews[indexPath.row]];
    
    return cell;
}

@end
