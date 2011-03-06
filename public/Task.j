@import <Foundation/CPObject.j>

@implementation Task : CPObject
{
    int       id            @accessors;
    CPString  name          @accessors;
    int       project_id    @accessors;
}

- (id)init
{
    self = [super init] ;
    if (self)
    {
        id = 0;
        name = @"" ;
        project_id = 0;
    }
    return self ;
}


// Return a task from a JSON Object
- (id)initFromJSONObject:(CPString)aJSONObject
{
    self = [self init] ;
    if (self)
    {
        id          = aJSONObject.id; 
        name        = aJSONObject.name;
        project_id  = aJSONObject.project_id;
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
