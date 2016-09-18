//
//  LogList.h
//  LogList
//
//  Created by hangnguyen on 9/18/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
    #define LOG(A, ...) [[LogList shared] log:[NSString stringWithFormat:A, __VA_ARGS__]]
#else
    #define LOG(A, ...) //
#endif

@interface LogList : NSObject

+ (LogList*) shared;

- (void) log:(id)data;
- (void) clearList;

@end
