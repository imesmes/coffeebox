@import <AppKit/CPView.j>

@implementation IntervalItemView : CPView
{
    CPTextField count;
    CPTextField start;
    CPTextField stop;
    CPTextField details;
}

- (void)setRepresentedObject:(id)anObject
{    
    if (!start || !stop)
    {
        count = [[CPTextField alloc] initWithFrame:CGRectMake (0.0, 0.0, 200.0, 20.0)];
        [count setFont:[CPFont boldSystemFontOfSize:12.0]];
        [self addSubview:count];

        start = [[CPTextField alloc] initWithFrame:CGRectMake (200.0, 0.0, 200.0, 20.0)];
        [start setFont:[CPFont boldSystemFontOfSize:12.0]];
        [self addSubview:start];

        stop = [[CPTextField alloc] initWithFrame:CGRectMake (400.0, 0.0, 200.0, 20.0)];
        [stop setFont:[CPFont boldSystemFontOfSize:12.0]];
        [self addSubview:stop];
        
        details = [[CPTextField alloc] initWithFrame:CGRectMake (600.0, 0.0, 500.0, 20.0)];
        [details setFont:[CPFont boldSystemFontOfSize:12.0]];
        [self addSubview:details];
    }
        
    [count setStringValue:[anObject count]];
    [start setStringValue:[anObject start]];
    [stop setStringValue:[anObject stop]];
    [details setStringValue:[anObject details]];
}

- (void)setSelected:(BOOL)isSelected
{
    // Task Item style when selected
    [self setBackgroundColor:isSelected ? [CPColor colorWithHexString:"3d80df"] : nil];
    [count setTextColor:isSelected ? [CPColor whiteColor] : [CPColor blackColor]];
    [start setTextColor:isSelected ? [CPColor whiteColor] : [CPColor blackColor]];
    [stop setTextColor:isSelected ? [CPColor whiteColor] : [CPColor blackColor]];
    [details setTextColor:isSelected ? [CPColor whiteColor] : [CPColor blackColor]];
}

@end
