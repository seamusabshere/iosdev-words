// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRALetter.h instead.

#import <CoreData/CoreData.h>


extern const struct SRALetterAttributes {
	__unsafe_unretained NSString *content;
} SRALetterAttributes;

extern const struct SRALetterRelationships {
	__unsafe_unretained NSString *words;
} SRALetterRelationships;

extern const struct SRALetterFetchedProperties {
} SRALetterFetchedProperties;

@class SRAWord;



@interface SRALetterID : NSManagedObjectID {}
@end

@interface _SRALetter : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SRALetterID*)objectID;





@property (nonatomic, strong) NSString* content;



//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *words;

- (NSMutableSet*)wordsSet;





@end

@interface _SRALetter (CoreDataGeneratedAccessors)

- (void)addWords:(NSSet*)value_;
- (void)removeWords:(NSSet*)value_;
- (void)addWordsObject:(SRAWord*)value_;
- (void)removeWordsObject:(SRAWord*)value_;

@end

@interface _SRALetter (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;





- (NSMutableSet*)primitiveWords;
- (void)setPrimitiveWords:(NSMutableSet*)value;


@end
