//
//  GameResult.h
//  Matchismo
//
//  Created by Ken Zhou on 2/10/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject
+ (NSArray *)allGameResults; 

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
@end
