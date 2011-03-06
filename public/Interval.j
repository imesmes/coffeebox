@import <Foundation/CPObject.j>

@implementation Interval : CPObject
{
    int       id            @accessors;
    CPString  start         @accessors;
    CPString  stop          @accessors;
    int       task_id       @accessors;
}

- (id)init
{
    self = [super init] ;
    if (self)
    {
        id = 0;
        start = @"" ;
        stop  = @"" ;
        task_id = 0;
    }
    return self ;
}


// Return a interval from a JSON Object
- (id)initFromJSONObject:(CPString)aJSONObject
{
    self = [self init] ;
    if (self)
    {
        id       = aJSONObject.id; 
        start    = aJSONObject.start;
        stop     = aJSONObject.stop;
        task_id  = aJSONObject.task_id;
    }
    return self ;
}

// Return intervals from array of JSON Objects
+ (CPArray)initFromJSONObjects:(CPString)someJSONObjects
{
    var intervals   = [[CPArray alloc] init] ;
    
    // Create array of intervals using array of json objects
    for (var i=0; i < someJSONObjects.length; i++) {
        var interval    = [[Interval alloc] initFromJSONObject:someJSONObjects[i].interval] ;
        [intervals addObject:interval] ;
    };
    
    return intervals ;
}
