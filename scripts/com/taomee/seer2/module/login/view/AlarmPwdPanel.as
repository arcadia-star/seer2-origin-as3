package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.AlerPWDMc;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   
   public class AlarmPwdPanel extends AlarmPanel
   {
      
      private static var __instance:com.taomee.seer2.module.login.view.AlarmPwdPanel;
       
      
      public function AlarmPwdPanel()
      {
         super();
      }
      
      private static function get instance() : com.taomee.seer2.module.login.view.AlarmPwdPanel
      {
         if(__instance == null)
         {
            __instance = new com.taomee.seer2.module.login.view.AlarmPwdPanel();
         }
         return __instance;
      }
      
      public static function show(param1:DisplayObjectContainer, param2:String, param3:Function = null, param4:Function = null, param5:Point = null) : void
      {
         var _loc6_:com.taomee.seer2.module.login.view.AlarmPwdPanel;
         (_loc6_ = com.taomee.seer2.module.login.view.AlarmPwdPanel.instance)._confirmFun = param3;
         _loc6_._infoTxt.text = param2;
         if(param4 != null)
         {
            _loc6_._cancelFun = param4;
            _loc6_._cancelBtn.visible = true;
         }
         else
         {
            _loc6_._confirmBtn.x = 510;
         }
         if(param5 == null)
         {
            _loc6_.x = 0;
            _loc6_.y = 0;
         }
         else
         {
            _loc6_.x = param5.x;
            _loc6_.y = param5.y;
         }
         if(_loc6_.parent)
         {
            return;
         }
         param1.addChild(_loc6_);
      }
      
      public static function hide() : void
      {
         var _loc1_:com.taomee.seer2.module.login.view.AlarmPwdPanel = com.taomee.seer2.module.login.view.AlarmPwdPanel.__instance;
         if(Boolean(_loc1_) && Boolean(_loc1_.parent))
         {
            _loc1_.parent.removeChild(_loc1_);
            _loc1_._confirmFun = null;
            _loc1_._cancelFun = null;
            com.taomee.seer2.module.login.view.AlarmPwdPanel.__instance = null;
         }
      }
      
      override protected function createChildren() : void
      {
         _back = new AlerPWDMc();
         addChild(_back);
         _infoTxt = _back["infoTxt"];
         _confirmBtn = _back["confirmBtn"];
         _cancelBtn = _back["cancelBtn"];
         _cancelBtn.visible = false;
      }
   }
}
