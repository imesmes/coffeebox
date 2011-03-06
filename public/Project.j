@import <Foundation/CPObject.j>

@implementation Project : CPObject
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


// Return a project from a JSON Object
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

// Return projects from array of JSON Objects
+ (CPArray)initFromJSONObjects:(CPString)someJSONObjects
{
    var projects   = [[CPArray alloc] init] ;
    
    // Create array of projects using array of json objects
    for (var i=0; i < someJSONObjects.length; i++) {
        var project    = [[Project alloc] initFromJSONObject:someJSONObjects[i]] ;
        [projects addObject:project] ;
    };
    
    return projects ;
}

+ (CPArray)getExampleProjects
{
    var array   = [[CPArray alloc] init] ;
    var project    = [[Project alloc] init] ;
    
    [project setName:@"This is the first project"] ;
    [array addObject:project] ;
     
    project    = [[Project alloc] init] ;
    [project setName:@"This is the second project"] ;
    [array addObject:project] ;
    
    project    = [[Project alloc] init] ;
    [project setName:@"This is the third project"] ;
    [array addObject:project] ;

    project    = [[Project alloc] init] ;
    [project setName:@"This is the fourth project"] ;
    [array addObject:project] ;
            
    project    = [[Project alloc] init] ;
    [project setName:@"This is the fiveth project"] ;
    [array addObject:project] ;

    project    = [[Project alloc] init] ;
    [project setName:@"This is the sixth project"] ;
    [array addObject:project] ;

    return array ;
}

@end
