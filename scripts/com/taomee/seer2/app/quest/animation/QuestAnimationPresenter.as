package com.taomee.seer2.app.quest.animation
{
   import com.taomee.seer2.app.component.ProgressiveAnimationPlayer;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.Event;
   
   public class QuestAnimationPresenter
   {
      
      private static const EVT_ANIMATION_CLOSE:String = "close";
      
      private static var _instance:com.taomee.seer2.app.quest.animation.QuestAnimationPresenter;
       
      
      private var _animation:ProgressiveAnimationPlayer;
      
      private var _params:String;
      
      public function QuestAnimationPresenter()
      {
         super();
      }
      
      private static function getInstance() : com.taomee.seer2.app.quest.animation.QuestAnimationPresenter
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.quest.animation.QuestAnimationPresenter();
         }
         return _instance;
      }
      
      public static function playQuestAnimation(param1:String) : void
      {
         getInstance().playQuestAnimation(param1);
      }
      
      private function playQuestAnimation(param1:String) : void
      {
         this._params = param1;
         this._animation = new ProgressiveAnimationPlayer(URLUtil.getQuestAnimation(param1));
         this._animation.addEventListener(Event.CLOSE,this.onAnimationClose);
         LayerManager.topLayer.addChild(this._animation);
         LayerManager.focusOnTopLayer();
         SoundManager.enabled = false;
      }
      
      private function onAnimationClose(param1:Event) : void
      {
         this._animation.removeEventListener(Event.CLOSE,this.onAnimationClose);
         DisplayObjectUtil.removeFromParent(this._animation);
         this._animation.dispose();
         this._animation = null;
         LayerManager.resetOperation();
         SoundManager.enabled = true;
      }
   }
}
