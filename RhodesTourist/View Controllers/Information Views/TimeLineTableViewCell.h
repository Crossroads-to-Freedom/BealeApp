//
//  TimeLineTableViewCell.h
//  BealeApp
//
//  Created by Will Cobb on 3/8/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineTableViewCell : UITableViewCell {
    int direction;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Direction:(int) d;

@end
