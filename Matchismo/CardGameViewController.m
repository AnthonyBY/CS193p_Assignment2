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
@property (weak, nonatomic) IBOutlet UILabel *flipDesciption;

@end

@implementation CardGameViewController

- (IBAction)redealPressed:(UIButton *)sender {
    self.scoreLabel.text = @"Score reseted";
    
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
    [self.segmentContol setEnabled:YES];
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
        }
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %ld points.", description, (long)self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            
            description = [NSString stringWithFormat:@"%@ don’t match! %ld point penalty!", description, -self.game.lastScore];
        }
        self.flipDesciption.text = description;
    }
}

- (NSString *) titleForCard: (Card *) card
{

    return card.isChosen ? card.contents : @"";
    
    //  YOU SHOULD IMPLEMENT THIS METHOD!
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
