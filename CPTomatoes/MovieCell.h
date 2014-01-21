//
//  MovieCell.h
//  CodePathTomatoes
//
//  Created by Christine Wang on 1/15/14.
//  Copyright (c) 2014 Christine Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *movieTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *synopsisLabel;
@property (nonatomic, weak) IBOutlet UILabel *castLabel;

@end
