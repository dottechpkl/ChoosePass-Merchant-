//
//  XMLReader.m
//
//  Created by Troy on 9/18/10.
//  Copyright 2010 Troy Brant. All rights reserved.
//

#import "XMLReader.h"

NSString *const kXMLReaderTextNodeKey = @"text";

@interface XMLReader (Internal)

- (id)initWithError:(NSError **)error;
- (NSDictionary *)objectWithData:(NSData *)data;

@end


@implementation XMLReader
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    
    __unsafe_unretained NSError **errorPointer; 
}

#pragma mark -
#pragma mark Public methods

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)error
{
    if (data == nil) {
        return nil;
    }
    
    XMLReader *reader = [[XMLReader alloc] initWithError:error];
    NSDictionary *rootDictionary = [reader objectWithData:data];
    
    return rootDictionary;
}

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)error
{
    if ([string length]==0) {
        return nil;
    }
    
    NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
    
    return [XMLReader dictionaryForXMLData:data error:error];
}

#pragma mark -
#pragma mark Parsing

- (id)initWithError:(NSError **)error
{
    if (self = [super init])
    {
        //*errorPointer = *error;
    }
    return self;
}


- (NSDictionary *)objectWithData:(NSData *)data
{
    // Clear out any old data
    dictionaryStack = [NSMutableArray array];
    textInProgress = [NSMutableString string];
    
    // Initialize the stack with a fresh dictionary
    [dictionaryStack addObject:[NSMutableDictionary dictionary]];
    
    // Parse the XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data] ;
    parser.delegate = (id)self;
    
    BOOL success = [parser parse];
                                                 
    // Return the stack's root dictionary on success
    if (success && dictionaryStack.count)
        return  [dictionaryStack objectAtIndex:0];
    
    return nil;
}

#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // Get the dictionary for the current level in the stack
    NSMutableDictionary *parentDict = [dictionaryStack lastObject];

    // Create the child dictionary for the new element, and initilaize it with the attributes
    NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
    [childDict addEntriesFromDictionary:attributeDict];
    
    // If there's already an item for this key, it means we need to create an array
    id existingValue = [parentDict objectForKey:elementName];
    if (existingValue)
    {
        NSMutableArray *array = nil;
        if ([existingValue isKindOfClass:[NSMutableArray class]])
        {
            // The array exists, so use it
            array = (NSMutableArray *) existingValue;
        }
        else
        {
            // Create an array if it doesn't exist
            array = [NSMutableArray array];
            [array addObject:existingValue];

            // Replace the child dictionary with an array of children dictionaries
            [parentDict setObject:array forKey:elementName];
        }
        
        // Add the new child dictionary to the array
        [array addObject:childDict];
    }
    else
    {
        // No existing value, so update the dictionary
        [parentDict setObject:childDict forKey:elementName];
    }
    
    // Update the stack
    [dictionaryStack addObject:childDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // Update the parent dict with text info
    NSMutableDictionary *dictInProgress = [dictionaryStack lastObject];
 
    if(dictionaryStack.count >= 2 && dictInProgress.count == 0)
    {
        dictInProgress = [dictionaryStack objectAtIndex:dictionaryStack.count-2];
        [dictInProgress setObject:textInProgress forKey:elementName];
    }
    else if(dictInProgress.count !=0 && textInProgress.length > 0)
    {
        [dictInProgress setObject:textInProgress forKey:kXMLReaderTextNodeKey];
    }

    // Reset the text
    textInProgress = [NSMutableString string];
    
    // Pop the current dict
    [dictionaryStack removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // Build the text value
    [textInProgress appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    // Set the error pointer to the parser's error object
    *errorPointer = parseError;
}

@end
