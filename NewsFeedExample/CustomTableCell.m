//
//  CustomTableCell.m
//  CustomTableViewCell
//
//  Created by ToanDK on 7/5/13.
//  Copyright (c) 2013 ToanDK. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell

+(CustomTableCell *)createNewCell {
    UIViewController *tempVC = [[UIViewController alloc] initWithNibName:@"CustomTableCell" bundle:nil];
    return (CustomTableCell *)tempVC.view;
}

-(void)setupCellWithDictionary:(NSDictionary *)dictionary {
    nameLabel.text = dictionary[@"name"];
    contentLabel.text = dictionary[@"content"];
    avatarImg.image = [UIImage imageNamed:dictionary[@"avatar"]];
    
    float contentLabelWidth = 228;
    CGSize constraint = CGSizeMake(contentLabelWidth, 20000.0f);
    CGSize size = [contentLabel.text sizeWithFont:contentLabel.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, size.height);
}

// Chiều cao của cell phụ thuộc vào chiều cao của content label
+(float)heightForCellWithDictionary:(NSDictionary *)dictionary {
    NSString *content = dictionary[@"content"];
    float contentLabelWidth = 228;
    CGSize constraint = CGSizeMake(contentLabelWidth, 20000.0f);
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 34 + 10;
}

@end
