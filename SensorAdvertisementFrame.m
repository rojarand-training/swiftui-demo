//
//  SensorAdvertisementFrame.m
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 18/03/2023.
//

#import <Foundation/Foundation.h>
#import "SensorAdvertisementFrame.h"

@interface SensorAdvertisementFrame()
@property(readwrite) SensorAdvertisementMessage message;
@end

@implementation SensorAdvertisementFrame

- (instancetype)initWithMessage:(SensorAdvertisementMessage)message {
    self = [super init];
    if (self != nil) {
        self.message = message;
    }
    return self;
}
@end
