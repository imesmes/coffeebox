@import <Foundation/CPObject.j>

@implementation TasksController : CPObject
{
    // View containing projects list
    TaskListView     taskListView @accessors; // @accessors define setters and getters
    // Intervals Controller
    IntervalsController intervalsController @accessors;
    // URL for requesting projects to Rails app
    CPString         baseURL;
    // Connection for listing tasks
    CPURLConnection  listConnection;
}

- (id)init
{
    self = [super init];
    if(self) {
      baseURL = "http://localhost:3000"
    }
    return self;
} 

// Callback when changing collection item
- (void)collectionViewDidChangeSelection:(CPCollectionView)collectionView
{
    // Get current object
    var currentObject = [collectionView getCurrentObject] ;
    [intervalsController loadIntervals:currentObject.id] ;
}

// Fake data for test
- (void)loadExampleTasks
{
    var tasks = [Task getExampleTasks] ;
    [taskListView setContent:tasks] ;
}

// Load real data from Rails app
- (void)loadTasks:(int)projectId
{
    // Empty TaskListView
    [taskListView setContent:[]] ;
    // Create request for tasks
    var request = [CPURLRequest requestWithURL:baseURL+"/projects/"+projectId+"/tasks.json"];
    [request setHTTPMethod:"GET"];
    // Create connection for handling request and delegating response to
    // this controller
    listConnection = [CPURLConnection connectionWithRequest:request delegate:self];
}

// Callback when receiving data
- (void)connection:(CPURLConnection)connection didReceiveData:(CPString)data
{
    // If connnection is for listing tasks
    if (connection===listConnection)
    {
        // Use data result for creating JSON objects
        var results = CPJSObjectCreateWithJSON(data);
        // Create array of tasks
        var tasks = [Task initFromJSONObjects:results] ;
        // Set content pro task list view with array of tasks
        [taskListView setContent:tasks] ;
        [taskListView setSelectionIndexes:[[CPIndexSet alloc] initWithIndex:0] ] ;
    }
}

// Callback when error
- (void)connection:(CPURLConnection)connection didFailWithError:(CPString)error
{
    alert("Connection did fail with error : " + error) ;
}

// Callback when finish loading
- (void)connectionDidFinishLoading:(CPURLConnection)aConnection
{
    console.log("Connection did finish loading.") ;
}

@end
