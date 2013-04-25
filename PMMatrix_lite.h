//
//  PMMatrix-lite.h
//  AveMatrix
//
//  Created by Peter Molfese on 9/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PMMatrix_lite : NSObject 
{
	NSArray *theData;
	NSUInteger sizer;
	NSUInteger cols;
	NSUInteger rows;
}
@property(readwrite,copy) NSArray *theData;
@property(readwrite) NSUInteger sizer;
@property(readwrite) NSUInteger cols;
@property(readwrite) NSUInteger rows;
-(id)init;
-(void)readFile:(NSString *)pathToFile;
-(void)writeFile:(NSString *)pathToFile;
-(void)averageFiles:(NSArray *)setOfMatrix;

@end
