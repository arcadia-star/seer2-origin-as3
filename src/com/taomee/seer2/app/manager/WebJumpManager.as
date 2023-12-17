package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.WebJumpConfig;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.manager.GlobalsManager;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class WebJumpManager
   {
       
      
      public function WebJumpManager()
      {
         super();
      }
      
      public static function toBBSForId(param1:uint) : void
      {
         var currType:String = null;
         var userId:uint = 0;
         var id:uint = param1;
         currType = "http://bbs.61.com/checksession/";
         userId = ActorManager.actorInfo.id;
         WebJumpConfig.Instance.getConfigMap(function():void
         {
            var _loc1_:uint = WebJumpConfig.Instance.getInfo(id).tid;
            var _loc2_:String = currType + "?username=" + userId + "&gid=" + ClientConfig.productID + "&session=" + GlobalsManager.session + "&fid=37" + "&tid=" + _loc1_;
            navigateToURL(new URLRequest(_loc2_),"_blank");
         });
      }
      
      public static function toTouch() : void
      {
         var _loc1_:String = "http://event.2125.com/signlink?tmcid=13&gamename=ddt";
         navigateToURL(new URLRequest(_loc1_),"_blank");
      }
   }
}
