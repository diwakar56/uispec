//
//  UIRedoer.m
//  UISpec
//
//  Created by Brian Knorr <btknorr@gmail.com>
//  Copyright(c) 2009 StarterStep, Inc., Some rights reserved.
//
#import "UIRedoer.h"


@implementation UIRedoer

@synthesize redo;

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    //NSLog(@"forwardInvocation");
	[super forwardInvocation:anInvocation];
	self.play;
}

-(id)play {
    //NSLog(@"play");
	//NSLog(@"**START playing %@", NSStringFromSelector(invocation.selector));
	[invocation setTarget:target];
	[invocation invoke];
	NSString *returnType = [NSString stringWithFormat:@"%s", [[invocation methodSignature] methodReturnType]];
    //NSLog(@"** UIRedoer Return Type = %@", returnType);
	id value = nil;
    if (![returnType isEqualToString:@"(null)"] && ![returnType isEqualToString:@"v"]) {
		[invocation getReturnValue:&value];
	}
	//NSLog(@"**END playing %@", NSStringFromSelector(invocation.selector));
    
	//NSLog(@"%d, play got = %@ for target %@", [value isKindOfClass:[UIRedoer class]], [value isKindOfClass:[UIRedoer class]] ? [value target] : value, target);
	if ([returnType isEqualToString:@"@"] && [value isKindOfClass:[UIRedoer class]]) {
		//NSLog(@"trying to set redo");
		if ([[value target] respondsToSelector:@selector(setRedoer:)]) {
			//NSLog(@"setting redo");
			[[value target] setRedoer:self];
		}
	}
    //NSLog(@"return value %@", value);
	return value;
}

-(id)redo {
    //NSLog(@"redo");
	[target performSelector:@selector(redo)];
	return self;
}

@end
