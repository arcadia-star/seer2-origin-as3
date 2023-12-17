package com.taomee.seer2.app.home.panel
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.home.data.HomeInfo;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class HomeWelcome extends Sprite
   {
       
      
      private var _container:MovieClip;
      
      private var _nick:String;
      
      public function HomeWelcome()
      {
         super();
         this.createChildren();
      }
      
      private function createChildren() : void
      {
         this._container = UIManager.getMovieClip("UI_HomeWelcome");
         this._container.x = 268;
         this._container.y = 163;
         this._container.gotoAndStop(1);
         addChild(this._container);
      }
      
      public function setData(param1:HomeInfo) : void
      {
         if(param1.userId == ActorManager.actorInfo.id)
         {
            this._container.gotoAndStop(1);
         }
         else
         {
            this._nick = param1.userInfo.nick;
            this._container.addEventListener(Event.FRAME_CONSTRUCTED,this.onFrameConstructed);
            this._container.gotoAndPlay(1);
         }
      }
      
      private function onFrameConstructed(param1:Event) : void
      {
         var _loc2_:String = "小屋";
         if(SceneManager.active.type == SceneType.PLANT)
         {
            _loc2_ = "花园";
         }
         if(this._container.currentFrame == 5)
         {
            this._container["txt"].text = this._nick + _loc2_;
         }
         if(this._container.currentFrame == this._container.totalFrames)
         {
            this._container.removeEventListener(Event.FRAME_CONSTRUCTED,this.onFrameConstructed);
            this._container.stop();
         }
      }
   }
}
