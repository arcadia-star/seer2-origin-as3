package com.taomee.seer2.app.controls
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NewPlayerGuide extends Sprite
   {
      
      private static var _self:NewPlayerGuide;
      
      private static var _mainUI:MovieClip;
       
      
      private const NEW_QUEST_ID:int = 83;
      
      public function NewPlayerGuide()
      {
         super();
         _mainUI = UIManager.getMovieClip("PlayerGuide");
         _mainUI.x = 58.15;
         _mainUI.y = 131.95;
         _mainUI.buttonMode = true;
      }
      
      public static function getInstance() : NewPlayerGuide
      {
         if(_self == null)
         {
            _self = new NewPlayerGuide();
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
         SceneManager.changeScene(SceneType.COPY,80351);
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
         if(!QuestManager.isComplete(this.NEW_QUEST_ID) && ActorManager.actorInfo.createTime > uint(new Date(2014,8,26).getTime() / 1000))
         {
            addChild(_mainUI);
            this.initEvent();
         }
         else
         {
            this.removeEvent();
            DisplayObjectUtil.removeFromParent(_mainUI);
         }
      }
   }
}
