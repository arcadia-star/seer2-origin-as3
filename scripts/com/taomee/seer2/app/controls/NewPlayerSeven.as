package com.taomee.seer2.app.controls
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NewPlayerSeven extends Sprite
   {
      
      private static var _self:com.taomee.seer2.app.controls.NewPlayerSeven;
      
      private static var _mainUI:MovieClip;
       
      
      private const FOR_LIST:Array = [205273,205274,205275,205276,205277,205278,205279];
      
      private const NEW_QUEST_ID:int = 83;
      
      public function NewPlayerSeven()
      {
         super();
         _mainUI = UIManager.getMovieClip("NewPlayerSeven");
         _mainUI.buttonMode = true;
         _mainUI.x = 182.55;
         _mainUI.y = 136.05;
      }
      
      public static function getInstance() : com.taomee.seer2.app.controls.NewPlayerSeven
      {
         if(_self == null)
         {
            _self = new com.taomee.seer2.app.controls.NewPlayerSeven();
         }
         return _self;
      }
      
      public function show() : void
      {
         this.update();
         LayerManager.uiLayer.addChild(_self);
      }
      
      private function initEvent() : void
      {
         _mainUI.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeEvent() : void
      {
         if(_mainUI)
         {
            _mainUI.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("NewPlayerSevenDaysPanel");
      }
      
      public function hide() : void
      {
         if(_self)
         {
            DisplayObjectUtil.removeFromParent(_self);
         }
      }
      
      public function update() : void
      {
         ActiveCountManager.requestActiveCountList(this.FOR_LIST,function(param1:Parser_1142):void
         {
            var _loc2_:Boolean = true;
            var _loc3_:int = 0;
            while(_loc3_ < 7)
            {
               if(param1.infoVec[_loc3_] != 15)
               {
                  _loc2_ = false;
                  break;
               }
               _loc3_++;
            }
            if(ActorManager.actorInfo.createTime > uint(new Date(2014,8,26).getTime() / 1000) && !_loc2_)
            {
               addChild(_mainUI);
               initEvent();
            }
            else
            {
               removeEvent();
               DisplayObjectUtil.removeFromParent(_mainUI);
            }
         });
      }
   }
}
