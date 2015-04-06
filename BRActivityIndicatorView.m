//
//  BRActivityIndicatorView.m
//
//  Created by Bobby Ren on 12/1/13.

#import "BRActivityIndicatorView.h"
#define PROGRESS_SIZE 10
#define dotWidth 8
#define dotSpacing 5

@implementation BRActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        lastStep = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)startAnimating {
    [self setHidden:NO];
    if (self.isIndeterminate) {
        [self automate:@(currentStep)];
    }
    else {
        [self updateProgress:0];
    }
}

-(void)stopAnimating {
    [self setHidden:YES];
    //[progress setHidden:YES];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void)updateProgress:(float)percent {
    int nextStep = lastStep;
    for (int i=0; i<PROGRESS_SIZE; i++) {
        if (percent < (float)(i+1) / (PROGRESS_SIZE)) {
            nextStep = i;
            break;
        }
    }
    if (nextStep > lastStep) {
        for (int i=lastStep; i<=nextStep; i++) {
            [self animateProgress:i];
        }
        lastStep = nextStep;
    }
}

-(void)automate:(NSNumber *)stepnum {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    int step = [stepnum intValue];
    [self animateProgress:step];
    step = step + 1;
    if (step >= PROGRESS_SIZE)
        step = 0;
    [self performSelector:@selector(automate:) withObject:@(step) afterDelay:.25];
}

-(void)animateProgress:(int)step {
    // can change how the display/animation updates here
    // step can go from 0 to PROGRESS_SIZE-1
    //[progress setCurrentPage:step];
    currentStep = step;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor clearColor] CGColor]));
    CGContextFillPath(ctx);

    CGColorRef pastColor;
    if (!self.isIndeterminate) {
        pastColor = [[UIColor blueColor] CGColor];
    }
    else {
        pastColor = [[UIColor grayColor] CGColor];
    }

    for (int i=0; i<currentStep; i++) {
        int x0 = (rect.size.width-(dotWidth + dotSpacing)*PROGRESS_SIZE)/2 + i * (dotWidth + dotSpacing);
        CGRect rect2 = CGRectMake(x0, rect.size.height/2, dotWidth, dotWidth);
        CGContextAddEllipseInRect(ctx, rect2);
        CGContextSetFillColor(ctx, CGColorGetComponents(pastColor));
        CGContextFillPath(ctx);
    }

    int x0 = (rect.size.width-(dotWidth + dotSpacing)*PROGRESS_SIZE)/2 + currentStep * (dotWidth + dotSpacing);
    CGRect rect2 = CGRectMake(x0, rect.size.height/2, dotWidth, dotWidth);
    CGContextAddEllipseInRect(ctx, rect2);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
    CGContextFillPath(ctx);

    for (int i=currentStep+1; i<PROGRESS_SIZE; i++) {
        int x0 = (rect.size.width-(dotWidth + dotSpacing)*PROGRESS_SIZE)/2 + i * (dotWidth + dotSpacing);
        CGRect rect2 = CGRectMake(x0, rect.size.height/2, dotWidth, dotWidth);
        CGContextAddEllipseInRect(ctx, rect2);
        CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor grayColor] CGColor]));
        CGContextFillPath(ctx);
    }
}

@end
