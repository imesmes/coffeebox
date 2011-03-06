/*
 * AppController.j
 *
 * Created by ultrayoshi
 * Copyright 2011 i++. All rights reserved.
 */

@import <Foundation/CPObject.j>

@import "ProjectsController.j"
@import "ProjectListView.j"
@import "ProjectItemView.j"
@import "Project.j"

@import "TasksController.j"
@import "TaskListView.j"
@import "TaskItemView.j"
@import "Task.j"

@import "IntervalsController.j"
@import "IntervalListView.j"
@import "IntervalItemView.j"
@import "Interval.j"

@import "ToolbarDelegate.j"

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // Main window
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];
    // Root view
    var contentView = [theWindow contentView];
    // Projects Controller
    var projectsController  = [[ProjectsController alloc] init] ;
    // Tasks Controller
    var tasksController  = [[TasksController alloc] init] ;
    [projectsController setTasksController:tasksController];
    // Intervals Controller
    var intervalsController = [[IntervalsController alloc] init];
    //[tasksController setIntervalsController:intervalsController];

    var toolbar = [[CPToolbar alloc] initWithIdentifier:"Time-tracking"] ;
    var toolbarDelegate = [[ToolbarDelegate alloc] init] ;
    [toolbarDelegate setIntervalsController:intervalsController] ;
    [toolbar setDelegate:toolbarDelegate] ;
    [toolbar setVisible:YES] ;
    [theWindow setToolbar:toolbar] ;

    // Root split view
    var rootSplitView = [[CPSplitView alloc] initWithFrame:CGRectMake(0.0, 0.0, 
                        CGRectGetWidth([contentView bounds]), CGRectGetHeight([contentView bounds]))];
    // Horizontal
    [rootSplitView setVertical:NO] ;
    [rootSplitView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 
    // Add split view to root view
    [contentView addSubview:rootSplitView] ;

    // Split view for projects and tasks
    var splitView = [[CPSplitView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([contentView bounds]), 200.0)];
    // Vertical
    [splitView setVertical:YES] ;
    [splitView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 
    // Add split view to root view
    [rootSplitView addSubview:splitView] ;

    // ScrollView for projects list
    var projectListScrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, CGRectGetHeight([contentView bounds]))] ;
    [projectListScrollView setHasHorizontalScroller:NO] ;
    // Apparently, hide scroll bar
    [projectListScrollView setAutohidesScrollers:YES] ;
    // Add scrollview to splitView
    [splitView addSubview:projectListScrollView] ;

    // ScrollView for tasks list
    var taskListScrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(200.0, 0.0, 
                             CGRectGetWidth([contentView bounds])-200.0, CGRectGetHeight([contentView bounds]))] ;
    [taskListScrollView setHasHorizontalScroller:NO] ;
    [taskListScrollView setAutohidesScrollers:YES] ;
    // Add scrollview to splitView
    [splitView addSubview:taskListScrollView] ;

    // ScrollView for time log 
    var timeLogListScrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(0.0, 200.0, 
                                CGRectGetWidth([contentView bounds]), CGRectGetHeight([contentView bounds])-200.0)] ;
    [timeLogListScrollView setHasHorizontalScroller:NO] ;
    [timeLogListScrollView setAutohidesScrollers:YES] ;
    // Add scrollview to splitView
    [rootSplitView addSubview:timeLogListScrollView] ;

    // View for projects collection
    var projectListView = [[ProjectListView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([contentView bounds]), 200.0)] ;
    // Delegate functions to postsController
    [projectListView setDelegate:projectsController] ;
    // Using setter for projectListView
    [projectsController setProjectListView:projectListView] ;
    // Load data
    [projectsController loadProjects] ;
    //[projectsController loadExampleProjects] ;
    // Set data for scroll view
    [projectListScrollView setDocumentView:projectListView] ;

    // View for tasks collection
    var taskListView = [[TaskListView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([contentView bounds]), 200.0)] ;
    // Delegate functions to tasksController
    [taskListView setDelegate:tasksController] ;
    // Using setter for taskListView
    [tasksController setTaskListView:taskListView] ;
    // Set data for scroll view
    [taskListScrollView setDocumentView:taskListView] ;

    // View for intervals collection
    var intervalListView = [[IntervalListView alloc] initWithFrame:CGRectMake(0.0, 0.0, 
                           CGRectGetWidth([contentView bounds]), CGRectGetHeight([contentView bounds]))] ;
    // Delegate functions to intervalsController
    [intervalListView setDelegate:intervalsController] ;
    // Using setter for taskListView
    [intervalsController setIntervalListView:intervalListView] ;
    [intervalsController loadIntervals] ;
    // Set data for scroll view
    [timeLogListScrollView setDocumentView:intervalListView] ;

    [theWindow orderFront:self];
}

@end
