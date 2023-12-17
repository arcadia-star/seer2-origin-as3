package com.taomee.seer2.app.arena.animation.imples
{
   import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
   import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
   import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.player.FighterMoviePlayer;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class CatchFighterFailAnimation extends BaseAnimation
   {
      
      private static const FAILED_RESOURCE_NAME:String = "UI_FightCatchFailed";
       
      
      private var _failedAnimation:MovieClip;
      
      private var _moviePlayer:FighterMoviePlayer;
      
      public function CatchFighterFailAnimation()
      {
         super();
         this.initialize();
      }
      
      override public function initialize() : void
      {
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      override public function play() : void
      {
         if(this._failedAnimation == null)
         {
            this._failedAnimation = FightAnimationResourcePool.checkOutMC(FAILED_RESOURCE_NAME);
            this._failedAnimation.scaleX = -1;
            this._failedAnimation.x = LayerManager.root.width;
         }
         addChild(this._failedAnimation);
         this._moviePlayer = new FighterMoviePlayer(this._failedAnimation,this.onAnimationEnd,ClientConfig.timeRate);
      }
      
      private function onAnimationEnd() : void
      {
         DisplayObjectUtil.removeFromParent(this._failedAnimation);
         dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
      }
      
      override public function dispose() : void
      {
         if(this._moviePlayer != null)
         {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
         }
         if(this._failedAnimation != null)
         {
            this._failedAnimation.scaleX = 1;
            DisplayObjectUtil.removeFromParent(this._failedAnimation);
            FightAnimationResourcePool.checkInMC(FAILED_RESOURCE_NAME,this._failedAnimation);
            this._failedAnimation = null;
         }
         super.dispose();
      }
   }
}
