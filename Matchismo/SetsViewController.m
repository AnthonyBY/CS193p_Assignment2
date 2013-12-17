//
//  SetsViewController.m
//  Matchismo
//
//  Created by Anthony Marchenko on 12/17/13.
//  Copyright (c) 2013 Anthony Marchenko. All rights reserved.
//

#import "SetsViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface SetsViewController ()

@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck * deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipDesciption;


@end

@implementation SetsViewController

-(Deck *) createDeck{
    
   return [[PlayingCardDeck alloc] init];
}


- (CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
    
}

- (IBAction)touchCardButton:(UIButton *)sender
{
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
            
            description = [NSString stringWithFormat:@"%@ don’t match! %i point penalty!", description, -self.game.lastScore];
        }
        self.flipDesciption.text = description;
    }
}

- (NSString *) titleForCard: (Card *) card
{
    
    return card.isChosen ? card.contents : @"";
    
    
}

- (UIImage *) backgroundImageForCard:(Card *) card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end
