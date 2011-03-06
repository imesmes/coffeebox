@import <Foundation/CPObject.j>

var StartToolbarItemIdentifier  = "StartToolbarItemIdentifier",
    StopToolbarItemIdentifier   = "StopToolbarItemIdentifier";

@implementation ToolbarDelegate : CPObject
{
  IntervalsController intervalsController @accessors;
}

- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)aToolbar
{
    return [StartToolbarItemIdentifier, StopToolbarItemIdentifier];
}

- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)aToolbar
{
   return [StartToolbarItemIdentifier, StopToolbarItemIdentifier];
}

- (CPToolbarItem)toolbar:(CPToolbar)aToolbar itemForItemIdentifier:(CPString)anItemIdentifier willBeInsertedIntoToolbar:(BOOL)aFlag
{
    var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:anItemIdentifier];
	  var mainBundle = [CPBundle mainBundle];

    if (anItemIdentifier === StartToolbarItemIdentifier)
    {
    	var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"add.png"] size:CPSizeMake(30, 25)];
    	var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"addHighlighted.png"] size:CPSizeMake(30, 25)];

    	[toolbarItem setImage:image];
    	[toolbarItem setAlternateImage:highlighted];

      [toolbarItem setTarget:intervalsController];
      [toolbarItem setAction:@selector(start:)];
    	[toolbarItem setLabel:"Start"];

    	[toolbarItem setMinSize:CGSizeMake(32, 32)];
    	[toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }
    else if (anItemIdentifier === StopToolbarItemIdentifier)
    {
    	var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"remove.png"] size:CPSizeMake(30, 25)];
    	var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"removeHighlighted.png"] size:CPSizeMake(30, 25)];

    	[toolbarItem setImage:image];
    	[toolbarItem setAlternateImage:highlighted];

      [toolbarItem setTarget:intervalsController];
      [toolbarItem setAction:@selector(stop:)];
    	[toolbarItem setLabel:"Stop"];

    	[toolbarItem setMinSize:CGSizeMake(32, 32)];
    	[toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }
    
    return toolbarItem;
}

@end
