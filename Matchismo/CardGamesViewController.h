//
//  CardGamesViewController.h
//  Matchismo
//
//  Created by Ken Zhou on 18/09/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGamesViewController : UIViewController

-(Deck *)createDeck; //abstract
@property (nonatomic) NSInteger startingCardCount; //abstract
-(void)updateCell:(UICollectionViewCell *)cell
        usingCard:(Card *)card
        animation:(BOOL)animation; //abstract
@end
