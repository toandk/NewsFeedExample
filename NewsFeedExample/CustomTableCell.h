//
//  CustomTableCell.h
//  CustomTableViewCell
//
//  Created by ToanDK on 7/5/13.
//  Copyright (c) 2013 ToanDK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell {
    __unsafe_unretained IBOutlet UILabel *nameLabel, *contentLabel;
    __unsafe_unretained IBOutlet UIImageView *avatarImg;
}

+(CustomTableCell *)createNewCell;

-(void)setupCellWithDictionary:(NSDictionary *)dictionary;
+(float)heightForCellWithDictionary:(NSDictionary *)dictionary;

@end

