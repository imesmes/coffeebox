@import <Foundation/CPObject.j>

@implementation ProjectsController : CPObject
{
    // View containing projects list
    ProjectListView     projectListView @accessors; // @accessors define setters and getters
    // Tasks Controller
    TasksController     tasksController;
    // URL for requesting projects to Rails app
    CPString            baseURL;
    // Connection for listing projects
    CPURLConnection  listConnection;
}

- (id)init:(TasksController)aTasksController
{
    self = [super init];
    if(self) {
      baseURL = "http://localhost:3000"
      tasksController = aTasksController;
    }
    return self;
}

// Callback when changing collection item
- (void)collectionViewDidChangeSelection:(CPCollectionView)collectionView
{
    // Get current object
    var currentObject = [collectionView getCurrentObject] ;
    //[tasksController loadTasks:currentObject.id] ;
}

// Fake data for test
- (void)loadExampleProjects
{
    var projects = [Project getExampleProjects] ;
    [projectListView setContent:projects] ;
}

// Load real data from Rails app
- (void)loadProjects
{
    // Create request for projects
    var request = [CPURLRequest requestWithURL:baseURL+"/projects.json"];
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
        var projects = [Project initFromJSONObjects:results] ;
        // Set content pro project list view with array of projects
        [projectListView setContent:projects] ;
        [projectListView setSelectionIndexes:[[CPIndexSet alloc] initWithIndex:0] ] ;
    }
    //else if (connection===addConnection)
    //{
    //    [self loadPosts] ;
    //}
    //else if (connection===updateConnection)
    //{
    //    [self loadPosts] ;
    //}
    //else if (connection===deleteConnection)
    //{
    //    [self loadPosts] ;
    //}
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
