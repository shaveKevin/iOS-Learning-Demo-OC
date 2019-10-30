# 唯医骨科iOS架构文件说明

文件夹：
 
## Class：项目主要文件所在
##Resources：资源类盛放图片资源
##Supporting Files:支持文件
##Class文件夹：CommonFunctions 公共方法 比如说埋点统计的网络请求的上传等等
* NIMKit 聊天的UIKit 目前把聊天的Kit整理放到一个文件夹里
* Main ：主要盛放一些工具类以及一些公共的主要方法
 * Other 工程的一些配置文件 比如说HZAppDelegate丶info.plist 以及一些宏定义的头文件 config 
 * Controller 公共的VC
 * Lib 一些第三方
 * Tools 一些管理工具类
     * HZDispatcherTool ：工程中跳转的方法都写在这里
        Dispatcher  类目(action)
     * HZNetworkTool :工程中的网络请求工具
          * Refomer:请求结果处理的基类
          * BaseTool：网络请求基础类
          * Cache ：缓存类
          * Category：网络请求相关类目(NSarray 、NSDic等）
          * CommonParameterTool :网络工具
          * Include：网络请求配置
          * Manager :网络请求类
              * Customized ： 管理网络请求子类
              * Base：APIBaseManager 管理网络请求基类
          * Services：网络请求参数配置类
              * Customized ： 网络请求参数配置子类
              * Base： 网络请求参数配置基类
                 * Service： 网络请求参数配置父类
                 * ServiceFactory：根据manager调度然后确定执行哪个请求
                         
                         
                                              
                         
 * Intercepter：这个类主要是hook系统的方法。
 * Category 类目 比如说 NSString UIColor 以及UIImage
* Functions： 方法
  * VC： Controller
       *  Actions：Target_xxx 跳转工具类
       *  Controller： 
          * Controller：视图控制器
          * TableViewHandle：tableview 代理方法
       * Model：模型
       * DataBaseCenter ：数据库
       *  Model：model
       *  ServerCenter ：网络请求中心
       * View：视图

> 跳转方法：Dispatch控制跳转 通过类名和方法名找到需要跳转的vc Target_Homepage通过target找到homepage目标类然后找到类中的方法       action action_nativeHZChatPrivateVC 这个方法名和Dispatch中的 actionName相匹配 这样跳转的时候通过dispatch 进行跳转和传值
