//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ken Zhou on 19/09/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import "PlayingCard.h"


@implementation PlayingCard
- (NSString *)description {
    NSString *descriptionString = self.contents;
    return descriptionString;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


+ (NSArray *)validSuits
{
    return @[@"♥",@"♠",@"♦",@"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count - 1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank  <= [PlayingCard maxRank]){
        _rank = rank;
    }
}



@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}


- (NSString *)suit
{
    return _suit? _suit : @"?";
}

-(int)match:(NSArray *)otherCards
{
    int matchScore = 0;
    for(PlayingCard *otherCard in otherCards){
        if(self.rank == otherCard.rank){
            matchScore += 4;
        }
        else if (self.suit == otherCard.suit){
            matchScore += 1;
        }
        
    }
    return matchScore;
}




@end























