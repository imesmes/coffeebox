@import <AppKit/CPCollectionView.j>

@implementation IntervalListView : CPCollectionView
{
    // Prototype item for collection view
    CPCollectionViewItem itemPrototype;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self)
    {
        // Set height for item
        [self setMinItemSize:CGSizeMake(CGRectGetWidth([self bounds]), 20)];
        [self setMaxItemSize:CGSizeMake(CGRectGetWidth([self bounds]), 20)];
    
        itemPrototype = [[CPCollectionViewItem alloc] init];
        // Set view for item prototype
        [itemPrototype setView:[[TaskItemView alloc] initWithFrame:CGRectMakeZero()]];
        // Set item prototype for collection view
        [self setItemPrototype:itemPrototype];
    }

    return self;
}

- (id)getCurrentObject
{
    return [[self content] objectAtIndex:[self getSelectedIndex]] ;
}

- (int)getSelectedIndex
{
    return [[self selectionIndexes] firstIndex] ;
}

@end
