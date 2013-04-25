//
//  PMMatrix-lite.m
//  AveMatrix
//
//  Created by Peter Molfese on 9/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "PMMatrix_lite.h"


@implementation PMMatrix_lite

@synthesize theData;
@synthesize sizer;
@synthesize cols;
@synthesize rows;


-(id)init
{
	[super init];
	self.theData = nil;
	self.sizer = 0;
	self.cols = 0;
	self.rows = 0;
	return self;
}

-(void)readFile:(NSString *)pathToFile
{
	NSString *theFile = [NSString stringWithContentsOfFile:pathToFile];
	NSScanner *myScanner = [NSScanner scannerWithString:theFile];
	[myScanner setCharactersToBeSkipped:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSMutableArray *storageArr = [NSMutableArray arrayWithCapacity:32250]; //129*250 = 32250
	float temp;
	while( [myScanner isAtEnd] == FALSE )
	{
		[myScanner scanFloat:&temp];
		[storageArr addObject:[NSNumber numberWithFloat:temp]];
		//NSLog(@"Debug Number: %@", [NSNumber numberWithFloat:temp]);
	}
	self.theData = storageArr;
	if( [[self theData] count] == 32250 )
	{
		//NSLog(@"Size = 32250");
		self.cols = 129;
		self.rows = 250;
		self.sizer = 32250;
	}
}

-(void)writeFile:(NSString *)pathToFile
{
	NSMutableString *output = [NSMutableString stringWithString:@""];
	int i, j;
	j = 0;
	//NSLog(@"Size %i, Cols %i, Rows %i", [self sizer], [self cols], [self rows]);
	for( i=0; i<self.sizer; i++ )
	{
		if( j == self.cols )
		{
			j=0;
			//i--;	//this was a bug...  shouldn't count trials where we reset cols
			//NSLog(@"Begin new row");
			[output appendString:@"\n"];
		}
		[output appendString:[[[self theData] objectAtIndex:i] stringValue]];
		[output appendString:@"\t"];
		j++;
		
	}
	
	[output writeToFile:pathToFile atomically:YES encoding:1 error:NULL];
}

-(void)averageFiles:(NSArray *)setOfMatrix
{
	NSMutableArray *aveData = [NSMutableArray arrayWithCapacity:32250];
	int newSize = [[setOfMatrix objectAtIndex:0] sizer];
	int i;
	float ave[newSize];
	for( i=0; i<newSize; i++ )
		ave[i] = 0;
	
	for( PMMatrix_lite *myMatrix in setOfMatrix )
	{
		for( i=0; i<newSize; i++ )
		{
			ave[i] += [[[myMatrix theData] objectAtIndex:i] floatValue];
		}
	}
	
	for( i=0; i<newSize; i++ )
	{
		ave[i] /= [setOfMatrix count];
		[aveData addObject:[NSNumber numberWithFloat:ave[i]]];
	}
	self.theData = aveData;
	
	if( [[self theData] count] == 32250 )
	{
		//NSLog(@"Ave Size = 32250");
		self.cols = 129;
		self.rows = 250;
		self.sizer = 32250;
	}
	else
	{
		NSLog(@"Other size... oops");
	}
	
}

@end
