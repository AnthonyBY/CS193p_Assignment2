//
//  PlayingCard.h
//  Matchismo
//
//  Created by Anthony Marchenko on 12/12/13.
//  Copyright (c) 2013 Anthony Marchenko. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger)maxRank; 

@end
