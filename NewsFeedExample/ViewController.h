//
//  ViewController.h
//  CustomTableViewCell
//
//  Created by ToanDK on 7/5/13.
//  Copyright (c) 2013 ToanDK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    __unsafe_unretained IBOutlet UITableView *myTableView;
    
    NSMutableArray *listNews;
}

@end
