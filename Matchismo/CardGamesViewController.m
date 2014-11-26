//
//  CardGamesViewController.m
//  Matchismo
//
//  Created by Ken Zhou on 18/09/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import "CardGamesViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGamesViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *verboseLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeChangeSegCtrl;

@property (strong, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;

@end

@implementation CardGamesViewController

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animation:NO];
    return cell;
}

-(void)updateCell:(UICollectionViewCell *)cell
        usingCard:(Card *)card
        animation:(BOOL)animation
{
    //abstarct
}

-(GameResult *)gameResult
{
    if (!_gameResult){
        _gameResult = [[GameResult alloc] init];
    }
    return _gameResult;
}
-(CardMatchingGame *)game
{
    if (!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

-(Deck *)createDeck
{
    return nil;
} //abstract


- (IBAction)resetGame:(UIButton *)sender {
    //reinitialize the game
    //detroy the game    
    self.game = nil;
    self.flipCount = 0;
    self.gameResult = nil;
    self.modeChangeSegCtrl.selectedSegmentIndex = 0;
    //update UI
    if (self.modeChangeSegCtrl.enabled == NO) {
        self.modeChangeSegCtrl.enabled = YES;
    }
    [self updateUI];
}


- (IBAction)gameModeSegament:(UISegmentedControl *)sender {
    //switch between the 2/3 card match game mode    
    //reset the card game
    self.game = nil;
    //set game mode
    [self.game setMode:(int) sender.selectedSegmentIndex];
    //verbose
    
    //update UI
    [self updateUI];
}




-(void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];

        [self updateCell:cell usingCard:card animation:NO];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.verboseLabel.text = self.game.verbose;
    
}

-(void)updateUIWithAnimationAtIndex:(int)index
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        if (indexPath.item != index) {
            [self updateCell:cell usingCard:card animation:NO] ;
        }
        else{
            [self updateCell:cell usingCard:card animation:YES];
        }
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.verboseLabel.text = self.game.verbose;
    
}





-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLable.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(indexPath)
    {
        int index = indexPath.item;
        [self.game flipCardAtIndex:index];
        if (self.modeChangeSegCtrl.enabled != NO) {
            self.modeChangeSegCtrl.enabled = NO;
        }
        
        self.flipCount++;
        [self updateUIWithAnimationAtIndex:index];
        self.gameResult.score = self.game.score;
    }
    
    
}







@end
