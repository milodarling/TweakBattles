@interface SBAppSwitcherScrollView : UIScrollView
@end

@interface SBAppSwitcherPageViewController
{
	SBAppSwitcherScrollView* _scrollView;
}
@end 

%hook SBAppSwitcherPageViewController
-(void)loadView
{
	%orig;
	SBAppSwitcherScrollView *slowPagedScrollView = MSHookIvar<SBAppSwitcherScrollView*>(self, "_scrollView");
	[slowPagedScrollView setPagingEnabled:YES];
}

%end