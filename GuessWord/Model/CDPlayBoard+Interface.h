//
//  CDPlayBoard+Interface.h
//  GuessWord

//  数据库的接口
//  islocked star volNumber是必须填写的

//  Created by WangJZ on 12/10/13.
//  Copyright (c) 2013 BUPTMITC. All rights reserved.
//

#import "CDPlayBoard.h"
#import "PlayBoard.h"

@interface CDPlayBoard (Interface)

+(void)inserToDatabaseWithPlayBoard:(PlayBoard *)thePlayBoard               //将PlayBoard插入到数据库中
             inManagedObjectContext:(NSManagedObjectContext *)context;


+(CDPlayBoard *)cdPlayBoardByVolNumber:(NSNumber *)vol_number               //通过vol_number和level获取CDPlayBoard
                              andLevel:(NSNumber *)level
                inManagedObjectContext:(NSManagedObjectContext *)context;

+(CDPlayBoard *)cdPlayBoardByUniqueID:(NSNumber *)uniqueID                  //通过id获取CDPlayBoard
               inManagedObjectContext:(NSManagedObjectContext *)context;



+(NSArray *)cdPlayBoardsByVolNumber:(NSNumber *)volNumber                   //通过volNumber来获取一堆CDPlayBoards
             inManagedObjectContext:(NSManagedObjectContext *)context;

@end
