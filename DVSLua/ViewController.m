//
//  ViewController.m
//  DVSLua
//
//  Created by Quan.Shen on 1/29/15.
//  Copyright (c) 2015 Quan.Shen. All rights reserved.
//

#import "ViewController.h"
#import "CubeView.h"

CubeView *cubeTarget;
CubeView *otherCube;

int go_right(lua_State *L){
	CubeView *sc = (__bridge CubeView *)(lua_touserdata(L, 1));
	[sc goDirection:DirectionRight];
	return 0;
}

int go_left(lua_State *L){
	CubeView *sc = (__bridge CubeView *)(lua_touserdata(L, 1));
	[sc goDirection:DirectionLeft];
	return 0;
}

int go_up(lua_State *L){
	CubeView *sc = (__bridge CubeView *)(lua_touserdata(L, 1));
	[sc goDirection:DirectionUp];
	return 0;
}

int go_down(lua_State *L){
	CubeView *sc = (__bridge CubeView *)(lua_touserdata(L, 1));
	[sc goDirection:DirectionDown];
	return 0;
}

int get_cube_position(lua_State *L){
	CubeView *sc = (__bridge CubeView *)lua_touserdata(L, 1);
	lua_pushnumber(L, sc.center.x);
	lua_pushnumber(L, sc.center.y);
	return 2;
}

int cubeTarget_position(lua_State *L){
	lua_pushnumber(L, cubeTarget.center.x);
	lua_pushnumber(L, cubeTarget.center.y);
	return 2;
}

const struct luaL_Reg cubeLib[] = {
	{"go_right", go_right},
	{"go_left", go_left},
	{"go_up", go_up},
	{"go_down", go_down},
	{"get_cube_Position",get_cube_position},
	{"cubeP", cubeTarget_position},
	{NULL, NULL}
};

int luaopen_cubeLib (lua_State *L){
	luaL_register(L, "myLib", cubeLib);
	return 1;
}

@interface ViewController ()
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	cubeTarget = [[CubeView alloc]initWithFrame:CGRectMake(120,100,20,20)
											   Speed:10
												Name:@"Target"];
	[cubeTarget setBackgroundColor:[UIColor purpleColor]];
	
	otherCube = [[CubeView alloc]initWithFrame:CGRectMake(100, 200, 20, 20)
										 Speed:10
										  Name:@"Other"];
	[otherCube setBackgroundColor:[UIColor greenColor]];
	UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
																			action:@selector(panAction:)];
	[cubeTarget addGestureRecognizer:panGesture];
	
	[self.view addSubview:otherCube];
	[self.view addSubview:cubeTarget];
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
												  target:self
												selector:@selector(runLoop:)
												userInfo:nil
												 repeats:YES];

	[self initLuaState];
}

- (void)panAction:(UIPanGestureRecognizer *)recognizer
{
	if (recognizer.state != UIGestureRecognizerStateEnded && recognizer.state != UIGestureRecognizerStateFailed){
		CGPoint location = [recognizer locationInView:recognizer.view.superview];
		recognizer.view.center = location;
	}
}

- (void)initLuaState
{
	L = luaL_newstate();
	luaL_openlibs(L);
	lua_settop(L, 0);
	luaopen_cubeLib(L);
	
	int err;
	NSString *luaFilePath = [[NSBundle mainBundle] pathForResource:@"Chase" ofType:@"lua"];
	err = luaL_loadfile(L, [luaFilePath cStringUsingEncoding:[NSString defaultCStringEncoding]]);
	
	if (0 != err) {
		luaL_error(L, "compile err: %s",lua_tostring(L, -1));
		return;
	}
	
	err = lua_pcall(L, 0, 0, 0);
	if (0 != err) {
		luaL_error(L, "run err: %s",lua_tostring(L, -1));
		return;
	}
}

- (void)runLoop:(id)sender
{
	lua_getglobal(L, "chase");
	lua_pushlightuserdata(L, (__bridge void *)(otherCube));
	int err = lua_pcall(L, 1, 0, 0);
	if (0 != err) {
		luaL_error(L, "run error: %s",
				   lua_tostring(L, -1));
		return;
	}
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
