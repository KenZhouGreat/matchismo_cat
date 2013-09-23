//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ken Zhou on 20/09/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards; //array of the cards
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *verbose;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck
{
    self = [super init];
    if(self){
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if(!card){
                self = nil;
            }
            else{
                self.cards[i] = card;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (NSString *)verbose
{
    if(!_verbose){
        _verbose = [[NSString alloc] init];
    }
    return _verbose;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(card && !card.isUnplayable){
        if(!card.isFaceUp){
            self.verbose = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            //see if flipping this card up creates a match
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.verbose = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                        
                        
                    }
                    else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.verbose = [NSString stringWithFormat:@"%@ & %@ don't match! %d points penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}



@end
