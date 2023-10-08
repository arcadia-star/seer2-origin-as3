package com.taomee.seer2.module.login.event
{
   import flash.events.Event;
   
   public class LoginEvent extends Event
   {
      
      public static const LOGIN_START:String = "loginStart";
      
      public static const LOGIN_ERROR:String = "loginError";
      
      public static const LOGIN_SUCCESS:String = "loginSuccess";
      
      public static const LOGIN_FAIL:String = "loginFail";
      
      public static const CONNECT:String = "connect";
      
      public static const CLOSE:String = "close";
      
      public static const GET_VERIFY_CODE:String = "getVerifyCode";
      
      public static const NO_VERITY_CODE:String = "noVerityCode";
      
      public static const GET_SERVER_LIST:String = "getServerList";
      
      public static const GET_SINGLE_SERVER:String = "getSingleServer";
      
      public static const CREATE_ROLE_SUCCESS:String = "createRoleSuccess";
      
      public static const ONLINE_SERVER_SELECTED:String = "onlineServerSelected";
      
      public static const CHANNEL_LOAD_SUCCESS:String = "channelLoadSuccess";
      
      public static const CHANNEL_LOAD_FAIL:String = "channelLoadFail";
      
      public static const CHANNEL_CHACK_OVER:String = "channelChackFail";
      
      public static const ACTIVECODE_SUCCESS:String = "activeCodeSuccess";
      
      public static const ACTIVECODE_FAIL:String = "activeCodeFail";
      
      public static const CHECK_ACTIVE_OVER:String = "checkActiveOver";
      
      public static const LOAD_IP_CONFIG_COMPLETE:String = "loadIpConfigComplete";
      
      public static const LOAD_CNC_TEL_COMPLETE:String = "loadCncTelComplete";
      
      public static const ONE_USER_LOGIN:String = "oneUserLogin";
      
      public static const OTHER_USER_LOGIN:String = "otherUserLogin";
      
      public static const APPLY_MIMI:String = "applyMimi";
      
      public static const REG_BACK_LOGIN:String = "backToLogin";
      
      public static const REG_SUCCESS_LOGIN:String = "regSuccessLogin";
       
      
      private var _info;
      
      public function LoginEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._info = param2;
      }
      
      public function get info() : *
      {
         return this._info;
      }
   }
}
