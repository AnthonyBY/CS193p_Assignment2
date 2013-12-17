//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Anthony Marchenko on 12/12/13.
//  Copyright (c) 2013 Anthony Marchenko. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck * deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)segmentControl:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentContol;
@property (weak, nonatomic) IBOutlet UILabel *flipDescription;

@property (strong, nonatomic) NSMutableArray *flipHistory;

@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@end

@implementation CardGameViewController

- (NSMutableArray *)flipHistory
{
    if (!_flipHistory) {
        _flipHistory = [NSMutableArray array];
    }
    return _flipHistory;
}

- (IBAction)changeSlider:(id)sender {
    int sliderValue;
    sliderValue = lroundf(self.historySlider.value);
    [self.historySlider setValue:sliderValue animated:NO];
    if ([self.flipHistory count]) {
        self.flipDescription.alpha =
        (sliderValue + 1 < [self.flipHistory count]) ? 0.6 : 1.0;
        self.flipDescription.text =
        [self.flipHistory objectAtIndex:sliderValue];
    }
}

- (IBAction)redealPressed:(UIButton *)sender {
    self.scoreLabel.text = @"Score reseted";
    
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
    [self.segmentContol setEnabled:YES];
    self.flipHistory = nil;
}

- (CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
        
}

-(Deck *) createDeck{
    return nil;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
     [self.segmentContol setEnabled:NO];
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    self.flipCount++;
    
}

- (void) updateUI
{
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    
    
    if (self.game) {
        NSString *description = @"";
        if ([self.game.lastChosenCards count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards) {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
            self.flipDescription.text = description;
            self.flipDescription.alpha = 1;
            
            if (![description isEqualToString:@""]
                && ![[self.flipHistory lastObject] isEqualToString:description]) {
                [self.flipHistory addObject:description];
                [self setSliderRange];
            }
        }
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %ld points.", description, (long)self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            
            description = [NSString stringWithFormat:@"%@ don’t match! %i point penalty!", description, -self.game.lastScore];
        }
        self.flipDescription.text = description;
    }
}

- (void)setSliderRange
{
    int maxValue = [self.flipHistory count] - 1;
    self.historySlider.maximumValue = maxValue;
    [self.historySlider setValue:maxValue animated:YES];
}


- (NSString *) titleForCard: (Card *) card
{

    return card.isChosen ? card.contents : @"";
    
    // Make text color for card RED if heards or diamonds apper
    // You can add this little improvement a little later.
    //    if ([string rangeOfString:@"♥️" options:NSCaseInsensitiveSearch].location != NSNotFound ||
    //       [string nrangeOfString:@"♦️" options:NSCaseInsensitiveSearch].location != NSNotFound)
    //        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    else
    //        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

- (UIImage *) backgroundImageForCard:(Card *) card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)segmentControl:(UISegmentedControl *)sender {
    
    self.game.maxMatchingCards = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];

}

@end
