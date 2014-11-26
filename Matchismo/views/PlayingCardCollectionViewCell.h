//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Ken Zhou on 18/10/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet PlayingCardView *playingCardView;
@end
