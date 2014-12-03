//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Ken Zhou on 2/10/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:15/255.0 green:112/255.0 blue:49/255.0 alpha:1]];
    }



-(void)updateUI{
    NSString *displayText = @"";
    for (GameResult *result in [GameResult allGameResults]){
        displayText = [displayText stringByAppendingFormat:@"Score: %d \t(%@, \t%0g)\n", result.score, result.start, round(result.duration)];
    }
    self.display.text = displayText;
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self updateUI];
    
    [self.display setTextColor:[UIColor whiteColor]];

}


-(void)setup
{
    //initialization that can't wait until viewDidLoad
    
}

-(void)awakeFromNib{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
