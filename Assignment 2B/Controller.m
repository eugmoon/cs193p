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
	[polygon setNumberOfSides:numberOfSidesLabel.text.integerValue];
	
	[self updateInterface];
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
}

- (void)dealloc {
    [decreaseButton release];
	[increaseButton release];
	[numberOfSidesLabel release];
	[polygon release];
	
    [super dealloc];
}

@end
