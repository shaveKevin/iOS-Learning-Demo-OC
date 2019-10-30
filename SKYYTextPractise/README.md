# SKYYTextPractise
解析html标签

解析html标签 类似微博上 @功能 因为微博上面 微博名字就是ID ，但是项目中  用户名可能相同  不可能按照微博那样来实现。
所以，这里给做了处理。 点击用户名 然后跳转到相关界面。


如何处理？


这里用了一个第三方库

 TFHpple 解析标签
 
 
  标签举例：
  
  ```
  <a href=http://www.shavekevin.com/#blog>@秦小风 </a>
  
  ```
  显示为下面的样式
  
  <a href=http://www.shavekevin.com/#blog>@秦小风 </a>
  
  一个标签开始 到结束 
  
  这算是一个完整的标签
  
  然后处理标签采用的是 yytext
  
  具体使用见demo。
  
   处理了特殊字符crash的问题
   ```
   &#263;
   ```
   
   编码的问题
   &#263;
   
   ```
   <a href=http://www.shavekevin.com/#blog>@Krunoslav Margi&#263; </a> 

   ```
   <a href=http://www.shavekevin.com/#blog>@Krunoslav Margi&#263; </a> 
   
   
   解析标签容错：
   标签中带有&符号容错
   ```
       <a href=1451271967030>@田Ÿ˜ 	‘€@¥@^_^&¥¥ </a>
   ```
   在使用TFHpple解析的时候采用
  下面的方法：
  ```
   TFHpple * doc = [TFHpple hppleWithHTMLData:htmlData];
   ```
   会把& 解析成   ```&amp;   ``` 这里做下替换就好了
   把解析后的   ```&amp;   ``` 替换成&
   

    
