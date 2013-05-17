// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRAPrefix.h instead.

#import <CoreData/CoreData.h>


extern const struct SRAPrefixAttributes {
	__unsafe_unretained NSString *content;
} SRAPrefixAttributes;

extern const struct SRAPrefixRelationships {
	__unsafe_unretained NSString *words;
} SRAPrefixRelationships;

extern const struct SRAPrefixFetchedProperties {
} SRAPrefixFetchedProperties;

@class SRAWord;



@interface SRAPrefixID : NSManagedObjectID {}
@end

@interface _SRAPrefix : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SRAPrefixID*)objectID;





@property (nonatomic, strong) NSString* content;



//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *words;

- (NSMutableSet*)wordsSet;





@end

@interface _SRAPrefix (CoreDataGeneratedAccessors)

- (void)addWords:(NSSet*)value_;
- (void)removeWords:(NSSet*)value_;
- (void)addWordsObject:(SRAWord*)value_;
- (void)removeWordsObject:(SRAWord*)value_;

@end

@interface _SRAPrefix (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;





- (NSMutableSet*)primitiveWords;
- (void)setPrimitiveWords:(NSMutableSet*)value;


@end
