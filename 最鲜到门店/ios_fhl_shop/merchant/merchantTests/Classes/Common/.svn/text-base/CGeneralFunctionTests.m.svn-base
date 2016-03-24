//
//  CGeneralFunctionTests.m
//  merchant
//
//  Created by 郏国上 on 15/4/13.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CGeneralFunction.h"

@interface CGeneralFunctionTests : XCTestCase

@end

@implementation CGeneralFunctionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample {
//    // This is an example of a functional test case.
//    XCTAssert(YES, @"Pass");
//}
//
//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

- (void)testGetEncodeConfusionKeysSrcNil {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        //        CGeneralFunction *pCGeneralFunction = [[CGeneralFunction alloc] init];
        //key进行md5加密后混淆：[0,15],[3,18],[5,12],[6,30],[11,20],[17,25]
        //key进行md5加密后混淆：[0,6], [1,7], [2,8], [3,9], [4,A],  [5,B]
        //key进行混淆后：      [15,0],[18,3],[12,5],[30,6],[20,11],[25,17]
        //key进行混淆后：      [6,0], [7,1], [8,2], [9,3], [A,4],  [B,5]
        NSString *src =    nil;
        XCTAssertNil(src, @"混淆失败");
    }];
}
- (void)testGetEncodeConfusionKeysSrcError {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        //        CGeneralFunction *pCGeneralFunction = [[CGeneralFunction alloc] init];
        //key进行md5加密后混淆：[0,15],[3,18],[5,12],[6,30],[11,20],[17,25]
        //key进行md5加密后混淆：[0,6], [1,7], [2,8], [3,9], [4,A],  [5,B]
        //key进行混淆后：      [15,0],[18,3],[12,5],[30,6],[20,11],[25,17]
        //key进行混淆后：      [6,0], [7,1], [8,2], [9,3], [A,4],  [B,5]
        //                 [CGeneralFunction getEncodeConfusionKey:@"01234567890123456789012345678901"];
        NSString *src =    [CGeneralFunction getEncodeConfusionKey:@"0##1#23####48##6#57#A####B####9#1"];
        XCTAssertNil(src, @"混淆失败");
    }];
}


- (void)testGetEncodeConfusionKey {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        //        CGeneralFunction *pCGeneralFunction = [[CGeneralFunction alloc] init];
        //key进行md5加密后混淆：[0,15],[3,18],[5,12],[6,30],[11,20],[17,25]
        //key进行md5加密后混淆：[0,6], [1,7], [2,8], [3,9], [4,A],  [5,B]
        //key进行混淆后：      [15,0],[18,3],[12,5],[30,6],[20,11],[25,17]
        //key进行混淆后：      [6,0], [7,1], [8,2], [9,3], [A,4],  [B,5]
        //                 [CGeneralFunction getEncodeConfusionKey:@"01234567890123456789012345678901"];
        NSString *src =    [CGeneralFunction getEncodeConfusionKey:@"0##1#23####48##6#57#A####B####9#"];
        NSString *dec =                                            @"6##7#89####A2##0#B1#4####5####3#";
//        FLDDLogVerbose(@"src = %@, dec = %@, length = %lu", src, dec, (unsigned long)src.length);
        XCTAssertEqualObjects(src,dec, @"混淆失败");
    }];

}

- (void)testSwitchNSStringValue {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        //[0,15]
        NSString *src =    [CGeneralFunction switchNSStringValue:@"0##1#23####48##6#57#A####B####9#":0:15];
        NSString *dec =                                          @"6##1#23####48##0#57#A####B####9#";
//        FLDDLogVerbose(@"src = %@, dec = %@, length = %lu", src, dec, (unsigned long)src.length);
        XCTAssertEqualObjects(src,dec, @"交换失败");
        //[17,25]
        src =              [CGeneralFunction switchNSStringValue:@"0##1#23####48##6#57#A####B####9#":17:25];
        dec =                                                    @"0##1#23####48##6#B7#A####5####9#";
//        FLDDLogVerbose(@"src = %@, dec = %@, length = %lu", src, dec, (unsigned long)src.length);
        XCTAssertEqualObjects(src,dec, @"交换失败");
        //[0,31]
        src =              [CGeneralFunction switchNSStringValue:@"0##1#23####48##6#57#A####B####9C":0:31];
        dec =                                                    @"C##1#23####48##6#57#A####B####90";
//        FLDDLogVerbose(@"src = %@, dec = %@, length = %lu", src, dec, (unsigned long)src.length);
        XCTAssertEqualObjects(src,dec, @"交换失败");
        //[31,0]
        src =              [CGeneralFunction switchNSStringValue:@"0##1#23####48##6#57#A####B####9C":31:0];
        dec =                                                    @"C##1#23####48##6#57#A####B####90";
//        FLDDLogVerbose(@"src = %@, dec = %@, length = %lu", src, dec, (unsigned long)src.length);
        XCTAssertEqualObjects(src,dec, @"交换失败");
        //[31,31]
        src =              [CGeneralFunction switchNSStringValue:@"0##1#23####48##6#57#A####B####9C":31:31];
        dec =                                                    @"0##1#23####48##6#57#A####B####9C";
//        FLDDLogVerbose(@"src = %@, dec = %@, length = %lu", src, dec, (unsigned long)src.length);
        XCTAssertEqualObjects(src,dec, @"交换失败");
        //[0,32]
        src =              [CGeneralFunction switchNSStringValue:@"0##1#23####48##6#57#A####B####9C":0:32];
        dec =                                                    @"C##1#23####48##6#57#A####B####90";
//        FLDDLogVerbose(@"src = %@, dec = %@, length = %lu", src, dec, (unsigned long)src.length);
        XCTAssertNil(src, @"交换失败");
        
        //nil
        src =              [CGeneralFunction switchNSStringValue:nil:0:31];
        dec =                                                    @"C##1#23####48##6#57#A####B####90";
//        FLDDLogVerbose(@"src = %@, dec = %@, length = %lu", src, dec, (unsigned long)src.length);
        XCTAssertNil(src, @"交换失败");
        
    }];
    
}

@end
