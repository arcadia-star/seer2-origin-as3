package com.taomee.analytics.type
{
   import com.taomee.analytics.item.ErrorItem;
   
   public class ErrorTypes
   {
      
      public static const SECURITY_HOME:ErrorItem = new ErrorItem(106,"安全沙箱（小屋）");
      
      public static const SYSTEM_BUSY:ErrorItem = new ErrorItem(110,"系统繁忙");
      
      public static const SECURITY_LOGIN:ErrorItem = new ErrorItem(104,"安全沙箱（登录）");
      
      public static const SYSTEM_ERROR_FIGHT:ErrorItem = new ErrorItem(112,"对战系统出错");
      
      public static const DISCONNECTION_LOGIN:ErrorItem = new ErrorItem(101,"断线（登录）");
      
      public static const SYSTEM_ERROR:ErrorItem = new ErrorItem(111,"系统出错");
      
      public static const TEST:ErrorItem = new ErrorItem(100,"开发测试",1000);
      
      public static const LOADING_TIMEOUT:ErrorItem = new ErrorItem(108,"加载（超时）");
      
      public static const LOADING_IOERROR:ErrorItem = new ErrorItem(107,"加载（IO错误）");
      
      public static const DISCONNECTION_ONLINE:ErrorItem = new ErrorItem(102,"断线（online）");
      
      public static const SECURITY_ONLINE:ErrorItem = new ErrorItem(105,"安全沙箱（online）");
      
      public static const PLUG_IN:ErrorItem = new ErrorItem(109,"加速器外挂");
      
      public static const DISCONNECTION_HOME:ErrorItem = new ErrorItem(103,"断线（小屋）");
       
      
      public function ErrorTypes()
      {
         super();
      }
   }
}
