@import <AppKit/CPView.j>

@implementation IntervalItemView : CPView
{
    CPTextField start;
    CPTextField stop;
}

- (void)setRepresentedObject:(id)anObject
{    
    if (!start || !stop)
    {
        start = [[CPTextField alloc] initWithFrame:CGRectMake (0.0, 0.0, 20.0, 20.0)];
        [start setFont:[CPFont boldSystemFontOfSize:12.0]];
        [self addSubview:start];

        stop = [[CPTextField alloc] initWithFrame:CGRectMake (50.0, 0.0, 20.0, 20.0)];
        [stop setFont:[CPFont boldSystemFontOfSize:12.0]];
        [self addSubview:stop];
        
    }
        
    [start setStringValue:[anObject start]];
    [stop setStringValue:[anObject stop]];
}

- (void)setSelected:(BOOL)isSelected
{
    // Task Item style when selected
    [self setBackgroundColor:isSelected ? [CPColor colorWithHexString:"3d80df"] : nil];
    [start setTextColor:isSelected ? [CPColor whiteColor] : [CPColor blackColor]];
    [stop setTextColor:isSelected ? [CPColor whiteColor] : [CPColor blackColor]];
}

@end
