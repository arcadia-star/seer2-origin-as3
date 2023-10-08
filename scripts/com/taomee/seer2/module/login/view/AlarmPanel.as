package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.AlerMc;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class AlarmPanel extends Sprite
   {
      
      private static var __instance:com.taomee.seer2.module.login.view.AlarmPanel;
       
      
      protected var _back:Sprite;
      
      protected var _infoTxt:TextField;
      
      protected var _confirmBtn:SimpleButton;
      
      protected var _confirmFun:Function;
      
      protected var _cancelBtn:SimpleButton;
      
      protected var _cancelFun:Function;
      
      public function AlarmPanel()
      {
         super();
         this.initialize();
      }
      
      private static function get instance() : com.taomee.seer2.module.login.view.AlarmPanel
      {
         if(__instance == null)
         {
            __instance = new com.taomee.seer2.module.login.view.AlarmPanel();
         }
         return __instance;
      }
      
      public static function show(param1:DisplayObjectContainer, param2:String, param3:Function = null, param4:Function = null, param5:Point = null) : void
      {
         var _loc6_:com.taomee.seer2.module.login.view.AlarmPanel;
         (_loc6_ = com.taomee.seer2.module.login.view.AlarmPanel.instance)._confirmFun = param3;
         _loc6_._infoTxt.text = param2;
         if(param4 != null)
         {
            _loc6_._cancelFun = param4;
            _loc6_._cancelBtn.visible = true;
         }
         else
         {
            _loc6_._confirmBtn.x = 660;
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
         var _loc1_:com.taomee.seer2.module.login.view.AlarmPanel = com.taomee.seer2.module.login.view.AlarmPanel.__instance;
         if(Boolean(_loc1_) && Boolean(_loc1_.parent))
         {
            _loc1_.parent.removeChild(_loc1_);
            _loc1_._confirmFun = null;
            _loc1_._cancelFun = null;
            com.taomee.seer2.module.login.view.AlarmPanel.__instance = null;
         }
      }
      
      private function initialize() : void
      {
         this.createChildren();
         this.initEventListener();
      }
      
      protected function createChildren() : void
      {
         this._back = new AlerMc();
         addChild(this._back);
         this._infoTxt = this._back["infoTxt"];
         this._confirmBtn = this._back["confirmBtn"];
         this._cancelBtn = this._back["cancelBtn"];
         this._cancelBtn.visible = false;
      }
      
      private function initEventListener() : void
      {
         this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirm);
         this._cancelBtn.addEventListener(MouseEvent.CLICK,this.onCancel);
      }
      
      private function onConfirm(param1:MouseEvent) : void
      {
         if(this._confirmFun != null)
         {
            this._confirmFun();
         }
         com.taomee.seer2.module.login.view.AlarmPanel.hide();
      }
      
      private function onCancel(param1:MouseEvent) : void
      {
         if(this._cancelFun != null)
         {
            this._cancelFun();
         }
         com.taomee.seer2.module.login.view.AlarmPanel.hide();
      }
   }
}

class Blocker
{
    
   
   public function Blocker()
   {
      super();
   }
}
