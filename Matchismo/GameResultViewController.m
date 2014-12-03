//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Ken Zhou on 2/10/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (strong, nonatomic) NSMutableArray * gameResultArray;

@end

@implementation GameResultViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:15/255.0 green:112/255.0 blue:49/255.0 alpha:1]];
    self.gameResultArray = [[GameResult allGameResults] mutableCopy];
    

}

    



-(void)updateUI{
    NSString *displayText = @"";
    for (GameResult *result in self.gameResultArray){
        displayText = [displayText stringByAppendingFormat:@"Score: %d \t(%@, \t%0gs)\n", result.score, result.start, round(result.duration)];
    }
    self.display.text = displayText;
    
    [self.display setTextColor:[UIColor whiteColor]];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self updateUI];
    
    

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
- (IBAction)sortByDateAction:(id)sender {
    NSArray *sortResult = [self.gameResultArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        NSDate *firstDate = ((GameResult *) a).start;
        NSDate *secondDate =  ((GameResult *) b).start;

        return [firstDate compare:secondDate];
    }];
    
    self.gameResultArray = [sortResult mutableCopy];
    [self updateUI];
}

- (IBAction)sortByScoreAction:(id)sender {
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    
    NSArray *sortResult = [self.gameResultArray sortedArrayUsingDescriptors:sortDescriptors ];
                           
    self.gameResultArray = [sortResult mutableCopy];
    [self updateUI];
    
}

- (IBAction)sortByDurationAction:(id)sender {
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"duration"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    
    NSArray *sortResult = [self.gameResultArray sortedArrayUsingDescriptors:sortDescriptors ];
    
    self.gameResultArray = [sortResult mutableCopy];
    [self updateUI];
}



@end
