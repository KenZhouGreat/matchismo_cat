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
@property  (nonatomic) int gameMode;
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
        self.verbose = @"Matchismo";
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)setMode:(NSUInteger)modeNumber
{
    self.gameMode = modeNumber;
    self.verbose = (self.gameMode == 0)? @"Two cards match mode" : @"Three cards match mode";
}

- (NSString *)verbose
{
    if(!_verbose){
        _verbose = [[NSString alloc] init];
    }
    return _verbose;
}

- (int)gameMode
{
    if(!_gameMode){
        _gameMode = 0;
    }
    return _gameMode;
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
            //two cards mode
            if (self.gameMode == 0){
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
            }
            //three cards mode
            else if (self.gameMode == 1){
                //matching logic
                NSMutableArray *facedUpPlayableCards = [[NSMutableArray alloc] init];
                for(Card *otherCard in self.cards){
                    //group faceUp palyable card
                    if (otherCard.isFaceUp && !otherCard.isUnplayable){
                        [facedUpPlayableCards addObject:otherCard];
                        if(facedUpPlayableCards.count > 2) break;
                    }
                }
                
                if(facedUpPlayableCards.count == 2){
                    int matchScore = [card match:facedUpPlayableCards];
                    //only if more than one card matches
                    if (matchScore == 2 || matchScore == 8){
                        card.unplayable = YES;
                        for (Card *otherCard in facedUpPlayableCards) {
                            otherCard.unplayable = YES;                            
                        }
                        self.score += matchScore * MATCH_BONUS * 2;
                        self.verbose = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, [facedUpPlayableCards componentsJoinedByString:@" & "], matchScore * MATCH_BONUS * 2];
                    }
                    //else cover the card again
                    else{
                        for (Card *otherCard in facedUpPlayableCards) {
                            otherCard.faceUp = NO;                            
                        }
                        self.score -= MISMATCH_PENALTY;
                        self.verbose = [NSString stringWithFormat:@"%@ & %@ don't match! %d points penalty!", card.contents, [facedUpPlayableCards componentsJoinedByString:@" & "], MISMATCH_PENALTY];
                    }

                    
                }                
                
                
            }
            else{
                //no mode recoganized should throw exception here
            }
            self.score -= FLIP_COST;
            
        }
        card.faceUp = !card.isFaceUp;
    }
}



@end
