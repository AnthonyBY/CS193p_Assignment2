//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Anthony Marchenko on 12/12/13.
//  Copyright (c) 2013 Anthony Marchenko. All rights reserved.
//
// Abstract class. Should implment method as described below

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

//ptorected for subclass
-(Deck *) createDeck; //abstact cluss


@end
