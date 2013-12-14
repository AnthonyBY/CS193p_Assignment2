//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Anthony Marchenko on 12/14/13.
//  Copyright (c) 2013 Anthony Marchenko. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardViewController

-(Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
