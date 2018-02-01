#import "RootViewController.h"
#include <spawn.h>
#include <signal.h>

@implementation RootViewController{
	UIView *_newView;
	UIView *_newView2;
}
- (void)loadView {
	CGRect bounds=CGRectMake(0,0,15,[UIScreen mainScreen].bounds.size.height);
	self.view = [[[UIView alloc] initWithFrame:bounds] autorelease];
	self.view.backgroundColor = [UIColor clearColor];
	
	_newView=[(UIView *)[[objc_getClass("_UIBackdropView") alloc] initWithFrame:bounds style:nil] autorelease];
	_newView.userInteractionEnabled=YES;
	_newView.alpha = 0.1;
	UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
	self.view.userInteractionEnabled = YES;
	tap.numberOfTapsRequired=2;
	[_newView addGestureRecognizer:tap];
	[tap release];
	
}
-(void)tapped:(UITapGestureRecognizer*)recog{
	pid_t pid;
	int status;
	const char *argv[] = {"killall", "SpringBoard", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
	waitpid(pid, &status, WEXITED);
}
-(void)viewDidAppear:(BOOL)animated{

	// called here, just for _UIBackdropView to get the correct layout
	[super viewDidAppear:animated];
	[[self.view window] addSubview:_newView];
}
@end
