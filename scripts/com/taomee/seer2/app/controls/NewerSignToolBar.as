package com.taomee.seer2.app.controls
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NewerSignToolBar extends Sprite
   {
      
      private static var _self:com.taomee.seer2.app.controls.NewerSignToolBar;
       
      
      private const FOR_DAY:uint = 205176;
      
      private var _mainUI:MovieClip;
      
      public function NewerSignToolBar()
      {
         super();
         this._mainUI = UIManager.getMovieClip("UI_Toolbar_NewerSign");
         this._mainUI.x = 116.9;
         this._mainUI.y = 133.5;
      }
      
      public static function getInstance() : com.taomee.seer2.app.controls.NewerSignToolBar
      {
         if(_self == null)
         {
            _self = new com.taomee.seer2.app.controls.NewerSignToolBar();
         }
         return _self;
      }
      
      public function show() : void
      {
         this.update();
         LayerManager.uiLayer.addChild(_self);
      }
      
      public function hide() : void
      {
         DisplayObjectUtil.removeFromParent(this._mainUI);
      }
      
      public function update() : void
      {
         if(ActorManager.actorInfo.createTime >= new Date(2014,8,19).getTime() / 1000)
         {
            ActiveCountManager.requestActiveCount(this.FOR_DAY,function(param1:uint, param2:uint):void
            {
               if(param2 < 30)
               {
                  addChild(_mainUI);
                  initMC();
                  initEventListener();
               }
            });
         }
         else
         {
            this.removeEvent();
            DisplayObjectUtil.removeFromParent(this._mainUI);
         }
      }
      
      private function initEventListener() : void
      {
         this._mainUI.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeEvent() : void
      {
         if(this._mainUI)
         {
            this._mainUI.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("NewerSignPanel");
      }
      
      private function initMC() : void
      {
         this._mainUI.buttonMode = true;
      }
   }
}
