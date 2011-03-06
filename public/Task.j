@import <Foundation/CPObject.j>

@implementation Task : CPObject
{
    CPString  name  @accessors;
    int       id    @accessors;
}

- (id)init
{
    self = [super init] ;
    if (self)
    {
        id = 0;
        name = @"" ;
    }
    return self ;
}


// Return a task from a JSON Object
- (id)initFromJSONObject:(CPString)aJSONObject
{
    self = [self init] ;
    if (self)
    {
        id        = aJSONObject.id; 
        name      = aJSONObject.name;
    }
    return self ;
}

// Return tasks from array of JSON Objects
+ (CPArray)initFromJSONObjects:(CPString)someJSONObjects
{
    var tasks   = [[CPArray alloc] init] ;
    
    // Create array of tasks using array of json objects
    for (var i=0; i < someJSONObjects.length; i++) {
        var task    = [[Task alloc] initFromJSONObject:someJSONObjects[i]] ;
        [tasks addObject:task] ;
    };
    
    return tasks ;
}

+ (CPArray)getExampleTasks
{
    var array   = [[CPArray alloc] init] ;
    var task    = [[Project alloc] init] ;
    
    [task setName:@"This is the first task"] ;
    [array addObject:task] ;
     
    task    = [[Project alloc] init] ;
    [task setName:@"This is the second task"] ;
    [array addObject:task] ;
    
    task    = [[Project alloc] init] ;
    [task setName:@"This is the third task"] ;
    [array addObject:task] ;

    task    = [[Project alloc] init] ;
    [task setName:@"This is the fourth task"] ;
    [array addObject:task] ;
            
    task    = [[Project alloc] init] ;
    [task setName:@"This is the fiveth task"] ;
    [array addObject:task] ;

    task    = [[Project alloc] init] ;
    [task setName:@"This is the sixth task"] ;
    [array addObject:task] ;

    return array ;
}

@end
