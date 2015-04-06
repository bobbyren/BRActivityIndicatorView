//
//  BRActivityIndicatorView.h
//
//  Created by Bobby Ren on 12/1/13.

#import <UIKit/UIKit.h>

@interface BRActivityIndicatorView : UIView
{
    int lastStep;
    int currentStep;
}
@property (nonatomic) BOOL isIndeterminate;

-(void)startAnimating;
-(void)stopAnimating;
-(void)updateProgress:(float)percent;
@end
