package com.taomee.seer2.module.login.util
{
   import com.taomee.seer2.module.login.config.LoginConfig;
   import flash.net.URLRequest;
   import flash.net.sendToURL;
   import org.taomee.stat.StatisticsManager;
   
   public class LoginStatistics
   {
      
      public static const loginFailed:String = "login_conn_failed";
      
      public static const loginSandbox:String = "safe_sandbox";
      
      public static const openFirstPage:String = "hp_1";
      
      public static const clickStartBtn:String = "hp_2";
      
      public static const mainPage:String = "hp_3";
      
      public static const telSuccess:String = "hp_4";
      
      public static const clickTelBtn:String = "hp_5";
      
      public static const cncSuccess:String = "hp_6";
      
      public static const clickCnsBtn:String = "hp_7";
      
      public static const QuickEnterServer:String = "noob_8";
      
      public static const EnterGame:String = "hp_8";
      
      public static const LoadSuccess:String = "hp_9";
      
      public static const LoadFail:String = "hp_10";
      
      public static const clickRegister:String = "hp_11";
      
      public static const clickRegister2:String = "hp_19";
      
      public static const clickFavorite:String = "hp_12";
      
      public static const Tel_Pwd_Error:String = "hp_13";
      
      public static const Cnc_Pwd_Error:String = "hp_14";
      
      public static const Tel_Net_Fail:String = "hp_15";
      
      public static const Cnc_Net_Fail:String = "hp_16";
      
      public static const RegistBackLogin:String = "hp_17";
      
      public static const openServerPage_Old:String = "vet_1";
      
      public static const selectServerSuc_Old:String = "vet_2";
      
      public static const ClickServerBtn_Old:String = "vet_3";
      
      public static const QuickEnterServer_Old:String = "vet_4";
      
      public static const openServerPage_New:String = "noob_1";
      
      public static const selectServerSuc_New:String = "noob_2";
      
      public static const ClickServerBtn_New:String = "noob_3";
      
      public static const clickTalkDailog:String = "noob_4";
      
      public static const selectRoleSex:String = "noob_5";
      
      public static const selectRoleColor:String = "noob_6";
      
      public static const selectRoleName:String = "noob_7";
      
      public static const introStartLoading:String = "noob_mission_4";
      
      public static const introPlaySuccess:String = "noob_mission_5";
      
      public static const introFinish:String = "noob_mission_6";
      
      public static const selectServerGrabSuccess:String = "noob_mission_1";
      
      public static const selectServerSelectOne:String = "noob_mission_2";
      
      public static const selectServerLogin:String = "noob_mission_3";
      
      public static const talkToCaptenPlayEnd:String = "noob_mission_7";
      
      public static const selectSex:String = "noob_mission_8";
      
      public static const selectColor:String = "noob_mission_9";
      
      public static const selectName:String = "noob_mission_10";
      
      public static const STATISTICS_1:String = "mimi_in";
      
      public static const STATISTICS_2:String = "mail_in";
      
      public static const STATISTICS_3:String = "mimi_out";
      
      public static const STATISTICS_4:String = "mail_out";
      
      public static const STATISTICS_5:String = "check_in";
      
      public static const STATISTICS_6:String = "check_out";
      
      public static const STATISTICS_7:String = "query_in";
      
      public static const STATISTICS_8:String = "query_out";
      
      public static const STATISTICS_9:String = "server1";
      
      public static const STATISTICS_10:String = "server2";
      
      public static const STATISTICS_11:String = "server3";
      
      public static const STATISTICS_12:String = "server4";
      
      public static const STATISTICS_13:String = "0x1003381F";
       
      
      public function LoginStatistics()
      {
         super();
      }
      
      public static function sendError(param1:String) : void
      {
         sendToURL(new URLRequest("http://misc.taomee.com/monitor/technical_report.php?game=" + LoginConfig.productID + "&type=" + param1));
      }
      
      public static function sendNovice(param1:String, param2:String) : void
      {
      }
      
      public static function sendAccountNovice(param1:String, param2:String) : void
      {
      }
      
      public static function newSendNovice(param1:String, param2:String, param3:String, param4:String = "") : void
      {
         StatisticsManager.sendHttpStat(param1,param3,param4,int(param2));
      }
   }
}
