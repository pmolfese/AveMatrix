#import <Foundation/Foundation.h>
#import "PMMatrix_lite.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int i;
	//NSLog(@"Args: %i", argc);
	NSMutableArray *allFiles = [NSMutableArray arrayWithCapacity:argc-1];
	
	for( i=2; i<argc; i++ )
	{
		PMMatrix_lite *myMat = [[PMMatrix_lite alloc] init];
		[myMat readFile:[NSString stringWithCString:argv[i]]];
		[allFiles addObject:myMat];
		NSLog(@"Added: %@", [NSString stringWithCString:argv[i]]);
	}
	NSLog(@"Read all files");
	
	PMMatrix_lite *aveMat = [[PMMatrix_lite alloc] init];
	[aveMat averageFiles:allFiles];
	NSLog(@"Averaged Files");
	
	[aveMat writeFile:[NSString stringWithCString:argv[1]]];
	NSLog(@"Wrote output");
	
    [pool drain];
    return 0;
}
