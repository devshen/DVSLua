//
//  ViewController.h
//  DVSLua
//
//  Created by Quan.Shen on 1/29/15.
//  Copyright (c) 2015 Quan.Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

@interface ViewController : UIViewController
{
	lua_State *L;
}

@end

