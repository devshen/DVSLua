//
//  CubeView.h
//  DVSLua
//
//  Created by Quan.Shen on 1/30/15.
//  Copyright (c) 2015 Quan.Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
	DirectionUp,
	DirectionDown,
	DirectionLeft,
	DirectionRight
} Direction;

@interface CubeView : UIView
{
	float cubeSpeed;
}
@property (nonatomic,strong)NSString *name;

- (id)initWithFrame:(CGRect)frame Speed:(float)speed Name:(NSString *)name;
- (void)goDirection:(Direction)direction;

@end
