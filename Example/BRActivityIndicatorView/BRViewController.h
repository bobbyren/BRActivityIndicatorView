//
//  BRViewController.h
//  BRActivityIndicatorView
//
//  Created by mitrenegade on 04/06/2015.
//  Copyright (c) 2014 mitrenegade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BRActivityIndicatorView/BRActivityIndicatorView.h>

@interface BRViewController : UIViewController

@property (nonatomic) IBOutlet UILabel *label;
@property (nonatomic) IBOutlet UILabel *percent;
@property (nonatomic) BRActivityIndicatorView *activityIndicator;

@end
