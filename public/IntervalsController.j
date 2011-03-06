@import <Foundation/CPObject.j>

@implementation IntervalsController : CPObject
{
    //// View containing intervals list
    IntervalListView     intervalListView @accessors; // @accessors define setters and getters
    //// URL for requesting projects to Rails app
    CPString            baseURL;
    // Connection for listing intervals
    CPURLConnection  listConnection;
    // Connection for start interval
    CPURLConnection  startConnection;
    CPURLConnection  stopConnection;
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
}

- (void)start:(id)sender
{
    var project_id = 1;
    var task_id = 1;

    var request     = [CPURLRequest requestWithURL:baseURL + "/projects/"+project_id+"/tasks/"+task_id+"/intervals/start"];
    [request setHTTPMethod: "POST"];
    //[request setHTTPBody: JSONString];
    startConnection  = [CPURLConnection connectionWithRequest:request delegate:self];
}

- (void)stop:(id)sender
{
    var project_id = 1;
    var task_id = 1;

    var request     = [CPURLRequest requestWithURL:baseURL + "/projects/"+project_id+"/tasks/"+task_id+"/intervals/stop"];
    [request setHTTPMethod: "POST"];
    stopConnection  = [CPURLConnection connectionWithRequest:request delegate:self];
}

// Load real data from Rails app
- (void)loadIntervals
{
    var project_id = 1;
    var task_id = 1;

    // Create request for projects
    var request = [CPURLRequest requestWithURL:baseURL+"/projects/"+project_id+"/tasks/"+task_id+"/intervals.json"];
    [request setHTTPMethod:"GET"];
    // Create connection for handling request and delegating response to
    // this controller
    listConnection = [CPURLConnection connectionWithRequest:request delegate:self];
}

// Callback when receiving data
- (void)connection:(CPURLConnection)connection didReceiveData:(CPString)data
{
    // If connnection is for listing projects
    if (connection===listConnection)
    {
        // Use data result for creating JSON objects
        var results = CPJSObjectCreateWithJSON(data);
        // Create array of projects
        var intervals = [Interval initFromJSONObjects:results] ;
        // Set content pro project list view with array of projects
        [intervalListView setContent:intervals] ;
        [intervalListView setSelectionIndexes:[[CPIndexSet alloc] initWithIndex:0] ] ;
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
