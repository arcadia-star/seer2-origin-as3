package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.activity.data.ActivityDefinition;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.net.SharedObject;
   
   public class GiftFromSeer extends ActivityProcessor
   {
       
      
      public var hasGetMiKa:Boolean;
      
      public var boxCount:int = -1;
      
      public var box:SimpleButton;
      
      public var openBox:MovieClip;
      
      public var miKa:MovieClip;
      
      public var coldTime:Array;
      
      private var hasPlayStartAnimation:Boolean;
      
      public function GiftFromSeer(param1:ActivityDefinition)
      {
         this.coldTime = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         _relatedMapIDArr = [133,141,152,240,262,302,320,330,380,390,480,540,570,610,50,30,10,310];
         super(param1);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapEnd);
         this.onMapEnd(null);
      }
      
      private function onMapEnd(param1:SceneEvent) : void
      {
         if(Boolean(SceneManager.active) && SceneManager.active.type == SceneType.LOBBY)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapEnd);
            this.showStartAnimation();
         }
      }
      
      private function showStartAnimation() : void
      {
         var so:SharedObject = null;
         if(this.hasPlayStartAnimation == false)
         {
            so = SharedObjectManager.getUserSharedObject(SharedObjectManager.SEER_GIFT_START);
            if(so.data != null && so.data[this.generateSeerGiftTVKey()] != null && so.data[this.generateSeerGiftTVKey()] == 1)
            {
               this.hasPlayStartAnimation = true;
            }
            else
            {
               ActorManager.getActor().stand();
               MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("giftFromSeer/startAnimation"),function():void
               {
                  hasPlayStartAnimation = true;
                  var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.SEER_GIFT_START);
                  _loc1_.data[generateSeerGiftTVKey()] = 1;
                  SharedObjectManager.flush(_loc1_);
               });
            }
         }
      }
      
      private function generateSeerGiftTVKey() : String
      {
         return Connection.netType.toString() + ActorManager.getActor().getInfo().id.toString();
      }
      
      override public function refresh() : void
      {
         var _loc1_:uint = this.coldTime.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.coldTime[_loc2_])
            {
               this.coldTime[_loc2_] = this.coldTime[_loc2_] >= 10 ? this.coldTime[_loc2_] - 10 : 0;
            }
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapEnd);
         super.dispose();
      }
   }
}
