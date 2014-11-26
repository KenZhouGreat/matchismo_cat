//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Ken Zhou on 18/10/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5.0;
}

-(Deck *)createDeck; //abstract
{
    return [[PlayingCardDeck alloc] init];
}
-(NSInteger ) startingCardCount; //abstract
{
    return 20;
}
-(void)updateCell:(UICollectionViewCell *)cell
        usingCard:(Card *)card
        animation:(BOOL)animation
{
    if ( [cell isKindOfClass:[PlayingCardCollectionViewCell class]])
    {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *playingCard = (PlayingCard *)card;
            if (!animation) {
                playingCardView.rank = playingCard.rank;
                playingCardView.suit = playingCard.suit;
                playingCardView.faceup = playingCard.isFaceUp;
                playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
            }
            else{
                [UIView transitionWithView:playingCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromRight
                                animations:^{
                                    playingCardView.rank = playingCard.rank;
                                    playingCardView.suit = playingCard.suit;
                                    playingCardView.faceup = playingCard.isFaceUp;
                                    playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
                                    
                                }
                                completion:nil];
            }            
           
        }
    }
}

@end
