//
//  CubeView.m
//  DVSLua
//
//  Created by Quan.Shen on 1/30/15.
//  Copyright (c) 2015 Quan.Shen. All rights reserved.
//

#import "CubeView.h"

@implementation CubeView

- (id)initWithFrame:(CGRect)frame Speed:(float)speed Name:(NSString *)name;
{
	self = [super init];
	if (self) {
		[self setFrame:frame];
		cubeSpeed = speed;
		_name = name;
	}
	
	return self;
}

- (void)goDirection:(Direction)direction
{
	CGPoint newPoint = self.center;
	switch (direction) {
		case DirectionUp:
			newPoint.y -= cubeSpeed;
			break;
		case DirectionDown:
			newPoint.y += cubeSpeed;
			break;
		case DirectionLeft:
			newPoint.x -= cubeSpeed;
			break;
		case DirectionRight:
			newPoint.x += cubeSpeed;
			break;
		default:
			break;
	}
	[self setCenter:newPoint];
}

@end
