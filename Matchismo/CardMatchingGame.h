//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Anthony Marchenko on 12/13/13.
//  Copyright (c) 2013 Anthony Marchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer 
- (instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck;

- (void) chooseCardAtIndex:(NSUInteger) index;
- (Card *) cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score; 

@end
