//
//  Parser.h
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 17/03/2023.
//

#ifndef Parser_h
#define Parser_h

#import <Foundation/Foundation.h>
#import "SensorAdvertisementFrame.h"
#import "ParsingResult.h"

NS_ASSUME_NONNULL_BEGIN

static const unsigned char MESSAGE_START = 0x9E;
static const unsigned char MESSAGE_END = 0x17;
static const unsigned char MIN_FRAME_LENGHT = 0x01;
static const int POSITION_NOT_FOUND = -1;
static const int TEMPERATURE_OFFSET = 3;
static const int BATTERY_OFFSET = TEMPERATURE_OFFSET + 22;

@interface Parser: NSObject

- (instancetype)init;

+ (void)misc;

- (ParsingResult *)parse:(NSData *)data;

+ (void)parseByte:(unsigned char)byte
        valAtBit0:(unsigned char *)valAtBit0
 valAtBitFrom2To5:(unsigned char *)valAtBitFrom2To5
 valAtBitFrom6to7:(unsigned char *)valAtBitFrom6to7;
 
@end

NS_ASSUME_NONNULL_END

#endif /* Parser_h */
