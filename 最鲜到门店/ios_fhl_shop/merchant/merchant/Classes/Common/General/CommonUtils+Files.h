//
/******************************************************************************************/
//  共同方法——文件管理



#import <Foundation/Foundation.h>
#import "CommonUtils.h"

@interface CommonUtils (Files)

/****************** 关于文件管理方法 <S> ******************/

/* 
 检查本地文件是否存在 
 */
+ (BOOL)isfileExistsAtPath:(NSString *)filePath;

/* 
 读取本地“FileDocuments”目录下的文件路径
 */
+ (NSString *)readFileOfFileDocuments:(NSString *)filename;

/* 
 保存字符串到本地“FileDocuments”目录 
 */
+ (void)saveStringToLocal:(NSString *)string toFileName:(NSString *)filename;

/* 
 删除本地“FileDocuments”目录下的所有文件 
 */
+ (void)deleteAllFileOfFileDocuments;

/* 
 删除本地“FileDocuments”目录下的指定类型文件 
 */
+ (void)deleteAllFileOfFileDocuments:(NSString *)fileExtension;

/* 
 保存任意数据到本地“FileDocuments”目录，注：读取时直接获取文件路径读数据 
 */
+ (void)saveDataToLocal:(id)data toFileName:(NSString *)filename;

/* 
 创建文件到指定位置 
 */
+ (void)createFileForObject:(id)object toSubDirectorys:(NSString *)subDirectory toFileName:(NSString *)fileName;

/* 
 获取指定文件名、指定目录的本地路径 
 */
+ (NSString *)getFilePath:(NSString *)fileName toSubDirectorys:(NSString *)subDirectory;

// 根据指定路径获取文件大小
+ (long long)fileSizeAtPath:(NSString*)filePath;

//遍历文件夹获得文件夹大小，返回多少M
+ (CGFloat)folderSizeAtPath:(NSString*)folderPath;

@end
