//
//  Deck.h
//  Matchismo
//
//  Created by Ken Zhou on 19/09/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
