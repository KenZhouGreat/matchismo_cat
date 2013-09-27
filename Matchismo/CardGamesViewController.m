//
//  CardGamesViewController.m
//  Matchismo
//
//  Created by Ken Zhou on 18/09/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import "CardGamesViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGamesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *verboseLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeChangeSegCtrl;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGamesViewController

-(CardMatchingGame *)game
{
    if (!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}


- (IBAction)resetGame:(UIButton *)sender {
    //reinitialize the game
    //detroy the game    
    self.game = nil;
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



-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void)updateUI
{
    
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.verboseLabel.text = self.game.verbose;
    
    
    
}

-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLable.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    if (self.modeChangeSegCtrl.enabled != NO) {
        self.modeChangeSegCtrl.enabled = NO;
    }
    
    self.flipCount++;
    [self updateUI];
}







@end
