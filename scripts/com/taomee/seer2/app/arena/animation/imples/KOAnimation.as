package com.taomee.seer2.app.arena.animation.imples
{
   import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
   import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
   import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.player.FighterMoviePlayer;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class KOAnimation extends BaseAnimation
   {
      
      private static const RESOURCE_NAME:String = "UI_FightKOAnimation";
       
      
      private var _animation:MovieClip;
      
      private var _moviePlayer:FighterMoviePlayer;
      
      public function KOAnimation()
      {
         super();
         this.initialize();
      }
      
      override public function initialize() : void
      {
         DisplayObjectUtil.disableSprite(this);
      }
      
      override public function play() : void
      {
         this._animation = FightAnimationResourcePool.checkOutMC(RESOURCE_NAME);
         this._animation.x = 32;
         this._animation.y = 181;
         addChild(this._animation);
         this._moviePlayer = new FighterMoviePlayer(this._animation,this.onAnimationEnd,ClientConfig.timeRate);
      }
      
      private function onAnimationEnd() : void
      {
         dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
      }
      
      override public function dispose() : void
      {
         if(this._moviePlayer != null)
         {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
         }
         DisplayObjectUtil.removeFromParent(this._animation);
         FightAnimationResourcePool.checkInMC(RESOURCE_NAME,this._animation);
         this._animation = null;
         super.dispose();
      }
   }
}
