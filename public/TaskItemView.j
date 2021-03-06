@import <AppKit/CPView.j>

@implementation TaskItemView : CPView
{
    CPTextField name;
}

- (void)setRepresentedObject:(id)anObject
{    
    if (!name)
    {
        name = [[CPTextField alloc] initWithFrame:CGRectMake (0.0, 0.0, 300.0, 20.0)];
        
        [name setFont:[CPFont boldSystemFontOfSize:12.0]];
        [self addSubview:name];
    }
        
    [name setStringValue:[anObject name]];
}

- (void)setSelected:(BOOL)isSelected
{
    // Task Item style when selected
    [self setBackgroundColor:isSelected ? [CPColor colorWithHexString:"3d80df"] : nil];
    [name setTextColor:isSelected ? [CPColor whiteColor] : [CPColor blackColor]];
}

@end
