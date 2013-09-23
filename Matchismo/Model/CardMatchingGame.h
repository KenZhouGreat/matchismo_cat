//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ken Zhou on 20/09/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *) deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;

@property (strong, nonatomic, readonly)NSString *verbose;

@end


