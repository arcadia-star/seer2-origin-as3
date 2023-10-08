package org.taomee.register.util
{
   public class RegisterErrorCode
   {
      
      public static const NET_ERROR:int = 4001;
      
      public static const NEED_COMMAND_ID:int = 4002;
      
      public static const COMMAND_ID_INEXISTENCE:int = 4003;
      
      public static const CONTROLLER_INEXISTENCE:int = 4005;
      
      public static const ACCOUNT_INEXISTENCE:int = 4006;
      
      public static const NEED_PARAMETER:int = 4007;
      
      public static const PARAMETER_ERROR:int = 4008;
      
      public static const ILLEGAL_REQUEST:int = 4009;
      
      public static const PASSWORD_NOT_SAM:int = 4010;
      
      public static const PASSWORD_UNSAFETY:int = 4011;
      
      public static const CAPTCHA_ISNUMBER:int = 4012;
      
      public static const SYSTEM_ERROR:int = 1001;
      
      public static const DB_ERROR:int = 1002;
      
      public static const DATA_LENGTH_ERROR:int = 20002;
      
      public static const TMCID_INEXISTENCE:int = 20003;
      
      public static const SERVER_COMMAND_ID_INEXISTENCE:int = 20004;
      
      public static const SERVER_PARAMETER_ERROR:int = 20005;
      
      public static const EMAIL_ERROR:int = 20010;
      
      public static const GET_MIMINUM_ERROR:int = 10006;
      
      public static const ADD_EMAIL_MAP_ERROR:int = 10007;
      
      public static const ADD_USERINFO_ERROR:int = 10008;
      
      public static const CAPTCHA_ERROR:int = 10009;
       
      
      public function RegisterErrorCode()
      {
         super();
      }
      
      public static function getErrorCodeMsg(param1:int) : String
      {
         switch(param1)
         {
            case NET_ERROR:
               return "网络错误,请稍后再试！";
            case NEED_COMMAND_ID:
               return "系统错误,请稍后再试";
            case COMMAND_ID_INEXISTENCE:
               return "系统错误,请稍后再试！";
            case CONTROLLER_INEXISTENCE:
               return "系统错误,请稍后再试！";
            case ACCOUNT_INEXISTENCE:
               return "系统错误,请稍后再试！";
            case NEED_PARAMETER:
               return "系统错误,请稍后再试！";
            case PARAMETER_ERROR:
               return "系统错误,请稍后再试！";
            case ILLEGAL_REQUEST:
               return "系统错误,请稍后再试！";
            case PASSWORD_NOT_SAM:
               return "2次输入不相同！";
            case PASSWORD_UNSAFETY:
               return "密码太简单！";
            case CAPTCHA_ISNUMBER:
               return "验证码错误,请重新输入！";
            case SYSTEM_ERROR:
               return "系统错误,请稍后再试！";
            case DB_ERROR:
               return "系统错误,请稍后再试！";
            case DATA_LENGTH_ERROR:
               return "系统错误,请稍后再试！";
            case TMCID_INEXISTENCE:
               return "系统错误,请稍后再试！";
            case SERVER_COMMAND_ID_INEXISTENCE:
               return "系统错误,请稍后再试！";
            case SERVER_PARAMETER_ERROR:
               return "系统错误,请稍后再试！";
            case EMAIL_ERROR:
               return "系统错误,请稍后再试！";
            case GET_MIMINUM_ERROR:
               return "系统错误,请稍后再试！";
            case ADD_EMAIL_MAP_ERROR:
               return "系统错误,请稍后再试！";
            case ADD_USERINFO_ERROR:
               return "系统错误,请稍后再试！";
            case CAPTCHA_ERROR:
               return "验证码错误,请重新输入！";
            default:
               return "";
         }
      }
   }
}
