package com.taomee.seer2.app.vip
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.init.LoginInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.app.vip.data.VipInfo;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.manager.GlobalsManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.Util;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   import org.taomee.bean.BaseBean;
   
   public class VipManager extends BaseBean
   {
      
      private static var _vipInfo:VipInfo = new VipInfo();
      
      public static var energyLotteryCnt:int = -1;
      
      private static var _callBack:Function;
       
      
      public function VipManager()
      {
         super();
      }
      
      private static function onSwitchComplete(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
      }
      
      public static function get vipInfo() : VipInfo
      {
         return _vipInfo;
      }
      
      public static function navigateToPayPage() : void
      {
         entryMi();
      }
      
      private static function onGetSession(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.SESSION_1156,onGetSession);
         var _loc2_:ByteArray = param1.message.getRawData();
         var _loc3_:String = String(Util.getSessionString(_loc2_));
         var _loc4_:String = (_loc4_ = (_loc4_ = (_loc4_ = "http://pay.61.com/seer2/mbaccount") + ("?userid=" + ActorManager.actorInfo.id)) + ("&gameid=" + ClientConfig.productID)) + ("&session=" + _loc3_);
         navigateToURL(new URLRequest(_loc4_),"_blank");
      }
      
      public static function setChpher() : void
      {
         var _loc1_:String = "http://pay.61.com/account/pwd";
         _loc1_ += "?userid=" + ActorManager.actorInfo.id;
         _loc1_ += "&gameid=" + ClientConfig.productID;
         _loc1_ += "&session=" + GlobalsManager.session;
         navigateToURL(new URLRequest(_loc1_),"_blank");
      }
      
      private static function onSetChpher(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.SESSION_1156,onGetSession);
         var _loc2_:ByteArray = param1.message.getRawData();
         var _loc3_:String = String(Util.getSessionString(_loc2_));
         var _loc4_:String = (_loc4_ = (_loc4_ = (_loc4_ = "http://pay.61.com/account/pwd") + ("?userid=" + ActorManager.actorInfo.id)) + ("&gameid=" + ClientConfig.productID)) + ("&session=" + _loc3_);
         navigateToURL(new URLRequest(_loc4_),"_blank");
      }
      
      public static function entryMi() : void
      {
         var _loc1_:String = "http://pay.61.com/seer2/seer2pay";
         _loc1_ += "?userid=" + ActorManager.actorInfo.id;
         _loc1_ += "&gameid=" + ClientConfig.productID;
         _loc1_ += "&session=" + GlobalsManager.session;
         navigateToURL(new URLRequest(_loc1_),"_blank");
      }
      
      public static function entryBBS() : void
      {
         var _loc1_:String = "http://bbs.61.com/checksession/";
         var _loc2_:uint = ActorManager.actorInfo.id;
         var _loc3_:* = _loc1_ + "?username=" + _loc2_ + "&gid=" + ClientConfig.productID + "&session=" + GlobalsManager.session + "&fid=37";
         navigateToURL(new URLRequest(_loc3_),"_blank");
      }
      
      public static function appointBBS(param1:uint) : void
      {
         var _loc2_:String = "http://bbs.61.com/checksession/";
         var _loc3_:uint = ActorManager.actorInfo.id;
         var _loc4_:String = _loc2_ + "?username=" + _loc3_ + "&gid=" + ClientConfig.productID + "&session=" + GlobalsManager.session + "&fid=37" + "&tid=" + param1;
         navigateToURL(new URLRequest(_loc4_),"_blank");
      }
      
      public static function openVip() : void
      {
         var _loc1_:String = "http://pay.61.com/buy/paytype";
         _loc1_ += "?userid=" + ActorManager.actorInfo.id;
         _loc1_ += "&gameid=" + ClientConfig.productID;
         _loc1_ += "&session=" + GlobalsManager.session;
         navigateToURL(new URLRequest(_loc1_),"_blank");
      }
      
      public static function entryBBSCheck() : void
      {
         var _loc1_:String = "http://dc.61.com/Question/realQ?qn_id=29";
         navigateToURL(new URLRequest(_loc1_),"_blank");
      }
      
      private static function onEntryMi(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.SESSION_1156,onGetSession);
         var _loc2_:ByteArray = param1.message.getRawData();
         var _loc3_:String = String(Util.getSessionString(_loc2_));
         var _loc4_:String = (_loc4_ = (_loc4_ = (_loc4_ = "http://pay.61.com/buy/paytype") + ("?userid=" + ActorManager.actorInfo.id)) + ("&gameid=" + ClientConfig.productID)) + ("&session=" + _loc3_);
         navigateToURL(new URLRequest(_loc4_),"_blank");
      }
      
      public static function isAddBeFull(param1:uint) : Boolean
      {
         return true;
      }
      
      public static function getMaxPowerNum(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = 20;
               break;
            case 1:
               _loc2_ = 20;
               break;
            case 2:
               _loc2_ = 26;
               break;
            case 3:
               _loc2_ = 34;
               break;
            case 4:
               _loc2_ = 46;
               break;
            case 5:
               _loc2_ = 60;
         }
         return _loc2_;
      }
      
      public static function getEnergyLotteryCnt(param1:Function) : void
      {
         if(energyLotteryCnt == -1)
         {
            _callBack = param1;
            Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065,onGetEnergyLotteryCnt);
            Connection.send(CommandSet.DAILY_LIMIT_1065,343);
         }
         else
         {
            param1();
         }
      }
      
      private static function onGetEnergyLotteryCnt(param1:MessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
         if(_loc2_.id == 343)
         {
            Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,onGetEnergyLotteryCnt);
            if(_callBack != null)
            {
               _loc3_ = VipManager.vipInfo.isVip() ? 5 : 3;
               energyLotteryCnt = _loc3_ - _loc2_.count;
               _callBack();
               _callBack = null;
            }
         }
      }
      
      override public function start() : void
      {
         _vipInfo = LoginInfo.userInfo.vipInfo;
         if(_vipInfo.luckyFlag != 0)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
         }
         finish();
      }
   }
}
