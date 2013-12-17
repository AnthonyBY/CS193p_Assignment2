//
//  SetsViewController.h
//  Matchismo
//
//  Created by Anthony Marchenko on 12/17/13.
//  Copyright (c) 2013 Anthony Marchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface SetsViewController : UIViewController
//ptorected for subclass
-(Deck *) createDeck; //abstact cluss

@end
