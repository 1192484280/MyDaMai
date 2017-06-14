//
//  Tools.m
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "Tools.h"
#define DBNAME    @"city.sqlite"

@implementation Tools
+ (void)addSqliteList
{
    //获取应用程序的路径
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(
                                                               NSDocumentDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex:0];
    
    //往应用程序路径中添加数据库文件名称，把它们拼接起来， 这里用到了宏定义（目的是不易出错)
    NSString *dbFilePath = [documentFolderPath stringByAppendingPathComponent:DBNAME];
    //1. 创建NSFileManager对象  NSFileManager包含了文件属性的方法
    NSFileManager *fm = [NSFileManager defaultManager];
    
    
    
    
    //2. 通过 NSFileManager 对象 fm 来判断文件是否存在，存在 返回YES  不存在返回NO
    BOOL isExist = [fm fileExistsAtPath:dbFilePath];
    
    //如果不存在 isExist = NO，拷贝工程里的数据库到Documents下
    if (!isExist)
    {
        //拷贝数据库
        //获取工程里，数据库的路径,因为我们已在工程中添加了数据库文件，所以我们要从工程里获取路径
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  pathForResource:@"area_city"
                                  ofType:@"db"];
        //这一步实现数据库的添加，
        // 通过NSFileManager 对象的复制属性，把工程中数据库的路径拼接到应用程序的路径上
        [fm copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
    }
}

+ (NSArray *)queryCityInformation:(NSString *)city
{
    __block NSMutableArray *array = [NSMutableArray array];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:database_path];
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM area where firstLetter = '%@'",city];
        
        FMResultSet *rs = [db executeQuery:sqlQuery];
        
        while ([rs next]) {
            CityInformationModel *model = [[CityInformationModel alloc] init];
            model.id = [rs stringForColumnIndex:0];
            model.name = [rs stringForColumnIndex:1];
            model.postalcode = [rs stringForColumnIndex:2];
            model.telCode = [rs stringForColumnIndex:3];
            model.firstLetter = [rs stringForColumnIndex:4];
            model.parentid = [rs stringForColumnIndex:5];
            [array addObject:model];
        }
    }];
    return array;
}

+ (NSString *)queryCityId:(NSString *)cityName
{
    __block NSString *cityId = @"";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:database_path];
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM area where name = '%@'",cityName];
        
        FMResultSet *rs = [db executeQuery:sqlQuery];
        
        while ([rs next]) {
            cityId = [rs stringForColumnIndex:0];
        }
    }];
    return cityId;
}

+ (CGFloat)getAttributedTextHeight:(NSString *)text MaxWidth:(CGFloat)width Attributes:(NSDictionary *)attributes
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height;
}

@end
