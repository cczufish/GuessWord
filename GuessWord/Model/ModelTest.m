//
//  ModelTest.m
//  GuessWord
//
//  Created by WangJZ on 12/10/13.
//  Copyright (c) 2013 BUPTMITC. All rights reserved.
//

#import "ModelTest.h"
#import "PlayBoard.h"
#import "PlayBoardHelper.h"
@implementation ModelTest

+(void)testFunction{
    PlayBoard *pb = [PlayBoardHelper playBoardFromFile:@"td"];
    NSArray *a = [pb current_state];
    NSLog(@"%@",a);
    [pb updateBoardWithInputValue:@"A" atPoint:CGPointMake(3, 2)];
    [pb updateBoardWithInputValue:@"A" atPoint:CGPointMake(1, 1)];
    BOOL bingo = [pb isBingoOfWordAtPoint:CGPointMake(2, 2) inDirection:NO];
    
    a = [pb current_state];
    
    [pb updateBoardWithInputValue:@"h" atPoint:CGPointMake(1, 2)];
    [pb updateBoardWithInputValue:@"y" atPoint:CGPointMake(2, 2)];
    [pb updateBoardWithInputValue:@"l" atPoint:CGPointMake(3, 2)];
    a = [pb current_state];
    //BOOL suc = [pb isGameBoardCompleted];

    NSLog(@"%@",pb);


}
@end
