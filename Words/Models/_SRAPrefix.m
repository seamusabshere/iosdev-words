// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRAPrefix.m instead.

#import "_SRAPrefix.h"

const struct SRAPrefixAttributes SRAPrefixAttributes = {
	.content = @"content",
};

const struct SRAPrefixRelationships SRAPrefixRelationships = {
	.words = @"words",
};

const struct SRAPrefixFetchedProperties SRAPrefixFetchedProperties = {
};

@implementation SRAPrefixID
@end

@implementation _SRAPrefix

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SRAPrefix" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SRAPrefix";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SRAPrefix" inManagedObjectContext:moc_];
}

- (SRAPrefixID*)objectID {
	return (SRAPrefixID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic content;






@dynamic words;

	
- (NSMutableSet*)wordsSet {
	[self willAccessValueForKey:@"words"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"words"];
  
	[self didAccessValueForKey:@"words"];
	return result;
}
	






@end
