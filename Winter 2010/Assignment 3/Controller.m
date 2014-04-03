#import "Controller.h"

@implementation Controller
- (IBAction)decrease {
	int currentSides = polygon.numberOfSides;
	
	if(currentSides > polygon.minimumNumberOfSides) {
		currentSides = currentSides - 1;
		[polygon setNumberOfSides:currentSides];
		[self updateInterface];
	}
}

- (IBAction)increase {
	int currentSides = polygon.numberOfSides;
	
	if(currentSides < polygon.maximumNumberOfSides) {
		currentSides = currentSides + 1;
		[polygon setNumberOfSides:currentSides];
		[self updateInterface];
	}
}

- (void)awakeFromNib {
	[polygon setMinimumNumberOfSides:3];
	[polygon setMaximumNumberOfSides:12];
	
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if ([standardUserDefaults integerForKey:@"numberOfSides"] > 2 && [standardUserDefaults integerForKey:@"numberOfSides"] < 13) {
		[polygon setNumberOfSides:[standardUserDefaults integerForKey:@"numberOfSides"]];
		numberOfSidesLabel.text = [NSString stringWithFormat:@"%d", [standardUserDefaults integerForKey:@"numberOfSides"]];
	}
	else
		[polygon setNumberOfSides:numberOfSidesLabel.text.integerValue];
	
	CGRect frame = CGRectMake(85, 130, 110, 25);
	nameLabel = [[UILabel alloc] initWithFrame:frame];
	[pView addSubview:nameLabel];
	[nameLabel setTextAlignment:UITextAlignmentCenter];
	
	[self updateInterface];
}

- (void)dealloc {
	[nameLabel release];
	[decreaseButton release];
    [increaseButton release];
    [numberOfSidesLabel release];
	[polygon release];
	[pView release];
	
	[super dealloc];
}

- (void)updateInterface {
	if(polygon.numberOfSides > polygon.minimumNumberOfSides)
		decreaseButton.enabled = YES;
	else
		decreaseButton.enabled = NO;
	if(polygon.numberOfSides < polygon.maximumNumberOfSides)
		increaseButton.enabled = YES;
	else
		increaseButton.enabled = NO;
	numberOfSidesLabel.text = [NSString stringWithFormat:@"%d", polygon.numberOfSides];
	[nameLabel setText:polygon.name];
	
	[pView setNeedsDisplay];
}

@end
