#import "ConnectButton.h"


@implementation ConnectButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    ConnectButton *button = [super buttonWithType:buttonType];
    button.backgroundColor = [self customBackgroundColor];
    button.contentEdgeInsets = UIEdgeInsetsMake(11.75, 32.0, 11.75, 32.0);
    button.layer.cornerRadius = 20.0;
    button.translatesAutoresizingMaskIntoConstraints = NO;

    return button;
}

+ (UIColor *)customBackgroundColor
{
    static UIColor *color;

    if (!color)
        color = [UIColor colorWithRed:(29.0 / 255.0) green:(185.0 / 255.0) blue:(84.0 / 255.0) alpha:1.0];

    return color;
}

+ (UIColor *)customHighlightedBackgroundColor
{
    static UIColor *color;

    if (!color)
        color = [UIColor colorWithRed:(24.0 / 255.0) green:(172.0 / 255.0) blue:(77.0 / 255.0) alpha:1.0];

    return color;
}

- (void)setHighlighted:(BOOL)highlighted
{
    self.backgroundColor = highlighted ? [self.class customHighlightedBackgroundColor] : [self.class customBackgroundColor];
}

@end
