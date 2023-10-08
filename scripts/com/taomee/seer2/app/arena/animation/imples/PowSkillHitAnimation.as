package com.taomee.seer2.app.arena.animation.imples
{
   import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
   import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
   import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.player.FighterMoviePlayer;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class PowSkillHitAnimation extends BaseAnimation
   {
      
      private static const RESOURCE_NAME:String = "UI_PowerSkillHit";
       
      
      private var _animationSkillHit:MovieClip;
      
      private var _moviePlayer:FighterMoviePlayer;
      
      public function PowSkillHitAnimation()
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
         if(this._animationSkillHit == null)
         {
            this._animationSkillHit = FightAnimationResourcePool.checkOutMC(RESOURCE_NAME);
         }
         addChild(this._animationSkillHit);
         this._moviePlayer = new FighterMoviePlayer(this._animationSkillHit,this.onAnimationEnd,ClientConfig.timeRate);
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
         if(this._animationSkillHit != null)
         {
            DisplayUtil.removeForParent(this._animationSkillHit);
            FightAnimationResourcePool.checkInMC(RESOURCE_NAME,this._animationSkillHit);
            this._animationSkillHit = null;
         }
         super.dispose();
      }
   }
}
