package com.taomee.seer2.module.login.util
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class HttpURLUtil
   {
      
      private static const registerURL:String = "http://account.61.com/register";
      
      public static const forgetURL:String = "http://account.61.com/forget";
      
      public static const changeURL:String = "http://account.61.com/change";
      
      public static const protectURL:String = "http://account.61.com/protect";
      
      public static const activeCodeURL:String = "http://app.61.com/seer2/";
      
      public static const V_URL:String = "http://jl.61.com/?tad=innermedia.seer2.free.tricon";
      
      public static const MOLE_URL:String = "http://as.61.com/events/as_ad/?tad=innermedia.seer2.free.icon";
      
      public static const SEER_URL:String = "http://seer.61.com/?tad=innermedia.seer2.free.icon2";
      
      public static const GF_URL:String = "http://asw.61.com/events/asw_bsd";
      
      public static const HERO_URL:String = "http://mole2.61.com/";
      
      public static const FLOWER_URL:String = "http://hua.61.com/?tad=innermedia.seer2.free.tricon";
      
      public static const HAQI_URL:String = "http://as.61.com/events/as_ad/?tad=innermedia.seer2.free.icon2";
      
      public static const WOER_URL:String = "http://atm.61.com/?tad=innermedia.seer2.free.homepage_bbanner";
      
      public static const SEER_HELP:String = "http://gf.61.com/?tad=innermedia.seer2.free.icon";
      
      public static const BBS_ACTIVITY:String = "http://mo.61.com/?tad=innermedia.seer.free.icon";
      
      public static const ACTIVITY_TAOMI:String = "http://event.2125.com/signlink?tmcid=31&gamename=ddt&tad=innermedia.seer2.free.trbanner";
      
      public static const JI_ZHAN:String = "http://mo.61.com/events/guoqing/?tad=innermedia.seer2.free.icon";
      
      public static const STL:String = "http://seer.61.com/events/201606seer_ls/?tad=innermedia.seer2.free.icon";
       
      
      public function HttpURLUtil()
      {
         super();
      }
      
      public static function getRegisterURL(param1:uint, param2:int) : String
      {
         var _loc3_:String = registerURL + "?gid=" + param1;
         if(param2 > 0)
         {
            return _loc3_ + "&tmcid=" + param2;
         }
         return _loc3_;
      }
      
      public static function linkToGame(param1:int) : void
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = HttpURLUtil.V_URL;
               break;
            case 1:
               _loc2_ = HttpURLUtil.MOLE_URL;
               break;
            case 2:
               _loc2_ = HttpURLUtil.SEER_URL;
               break;
            case 3:
               _loc2_ = HttpURLUtil.GF_URL;
               break;
            case 4:
               _loc2_ = HttpURLUtil.FLOWER_URL;
               break;
            case 5:
               _loc2_ = HttpURLUtil.HAQI_URL;
               break;
            case 6:
               _loc2_ = HttpURLUtil.SEER_HELP;
               break;
            case 7:
               _loc2_ = HttpURLUtil.ACTIVITY_TAOMI;
               LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_13,"0");
               break;
            case 8:
               _loc2_ = HttpURLUtil.ACTIVITY_TAOMI;
               break;
            case 9:
               _loc2_ = HttpURLUtil.JI_ZHAN;
               break;
            case 10:
               _loc2_ = HttpURLUtil.STL;
         }
         navigateToURL(new URLRequest(_loc2_),"_blank");
      }
   }
}
