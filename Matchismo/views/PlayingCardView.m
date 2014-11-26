//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Ken Zhou on 15/10/13.
//  Copyright (c) 2013 Ken Zhou. All rights reserved.
//

#import "PlayingCardView.h"





@implementation PlayingCardView

- (NSString *)rankAsString{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

- (NSString *)suitAsString{
    return @{@"♥" : @"H",
             @"♠" : @"S",
             @"♦" : @"D",
             @"♣" : @"C"}[self.suit];
}

- (void)drawRect:(CGRect)rect
{
  //Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5.0];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    CGRect imageRect = self.bounds;
//    CGRect imageRect = CGRectMake(2.5, 2.5, self.bounds.size.width - 5, self.bounds.size.height - 5);
    if (self.faceup) {
        
        
        UIImage *faceImage  = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], [self suitAsString]]];
        NSLog(@"%@%@", [self rankAsString], [self suitAsString]);
        if (faceImage) {
            [faceImage drawInRect:imageRect];
        }
        
    }
    else{
        [[UIImage imageNamed:@"_cardback"] drawInRect:imageRect];
    }
//    [self drawCorners];
    
    
    
    
    
    
}


-(void)drawCorners
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont systemFontOfSize:self.bounds.size.width * 0.20];
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : cornerFont}];
    
    
    CGRect textBounds;
    textBounds.origin = CGPointMake(2.0, 2.0);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    [self pushContextAndRotateUpsideDown];
    [cornerText drawInRect:textBounds];
    [self popContext];
    
}
-(void)pushContextAndRotateUpsideDown{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(UIGraphicsGetCurrentContext());
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    
}

-(void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}
                                 
- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

-(void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

-(void)setFaceup:(BOOL)faceup
{
    _faceup = faceup;
    [self setNeedsDisplay];
}

#pragma mark - Initialization
- (void) setup
{
    //do initialization here
}

-(void)awakeFromNib
{
    [self setup];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}





@end
