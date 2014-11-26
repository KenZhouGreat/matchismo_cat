//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Ken Zhou on 15/10/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@property (nonatomic) BOOL faceup;

@end
