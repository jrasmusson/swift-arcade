#import "ConnectView.h"


@implementation ConnectView

- (instancetype)init
{
    if ((self = [super init])) {
        UILabel *label = [UILabel new];
        self.label = label;

        ConnectButton *connectButton = [self buttonWithTitle:@"CONNECT"];
        self.connectButton = connectButton;

        self.backgroundColor = UIColor.whiteColor;
        self.translatesAutoresizingMaskIntoConstraints = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        label.text = @"Connect your Spotify account";
        label.translatesAutoresizingMaskIntoConstraints = NO;

        [self addSubview:label];
        [self addSubview:connectButton];
        [connectButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [connectButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;

        [connectButton sizeToFit];

        [label.centerXAnchor constraintEqualToAnchor:connectButton.centerXAnchor].active = YES;
        [label.bottomAnchor constraintEqualToAnchor:connectButton.topAnchor constant:-16.0].active = YES;
        [label sizeToFit];
    }

    return self;
}

#pragma mark - Private

- (ConnectButton *)buttonWithTitle:(NSString *)title
{
    ConnectButton *connectButton = [ConnectButton buttonWithType:UIButtonTypeSystem];
    NSDictionary<NSAttributedStringKey, id> *attributes = @{
                                                            NSFontAttributeName: [UIFont systemFontOfSize:UIFont.systemFontSize weight:UIFontWeightHeavy],
                                                            NSForegroundColorAttributeName: UIColor.whiteColor,
                                                            NSKernAttributeName: @2.0,
                                                            };
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    [connectButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    return connectButton;
}

@end
