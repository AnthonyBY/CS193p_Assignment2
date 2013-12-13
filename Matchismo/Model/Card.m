//
//  Card.m
//  Matchismo
//
//  Created by Anthony Marchenko on 12/12/13.
//  Copyright (c) 2013 Anthony Marchenko. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(int) match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
