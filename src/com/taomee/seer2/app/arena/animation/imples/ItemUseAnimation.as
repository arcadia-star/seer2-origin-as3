package com.taomee.seer2.app.arena.animation.imples
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Expo;
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
   import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
   import com.taomee.seer2.app.arena.data.FighterPositionInfo;
   import com.taomee.seer2.app.arena.data.ItemUseResultInfo;
   import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.player.FighterMoviePlayer;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.NumberUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class ItemUseAnimation extends BaseAnimation
   {
      
      private static const HP_RESOURCE_NAME:String = "UI_FightHpRecover";
      
      private static const ANGER_RESOURCE_NAME:String = "UI_FightAngerRecover";
       
      
      private var _digitSprite:Sprite;
      
      private var _animation:MovieClip;
      
      private var _numContainer:Sprite;
      
      private var _moviePlayer:FighterMoviePlayer;
      
      private var _itemUseResultInfo:ItemUseResultInfo;
      
      private var _fighter:Fighter;
      
      private var _side:uint;
      
      public function ItemUseAnimation()
      {
         super();
         this.initialize();
      }
      
      override public function initialize() : void
      {
         DisplayObjectUtil.disableSprite(this);
      }
      
      override public function initData(param1:Object) : void
      {
         this._fighter = param1["fighter"];
         this._side = param1["side"];
         this._itemUseResultInfo = param1["itemUseResultInfo"];
      }
      
      override public function play() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._itemUseResultInfo.hp > this._fighter.fighterInfo.hp)
         {
            _loc1_ = this._itemUseResultInfo.hp - this._fighter.fighterInfo.hp;
            this.playHpRecoverAnimation(_loc1_);
         }
         else if(!this._fighter.fighterInfo.checkItemAnger(this._itemUseResultInfo))
         {
            _loc2_ = this._itemUseResultInfo.anger - this._fighter.fighterInfo.fightAnger;
            this.playAngerRecoverAnimation(_loc2_);
         }
         this._fighter.fighterInfo.hp = this._itemUseResultInfo.hp;
         this._fighter.fighterInfo.fightAnger = this._itemUseResultInfo.anger;
      }
      
      override public function dispose() : void
      {
         this._fighter = null;
         this._itemUseResultInfo = null;
         if(this._digitSprite != null)
         {
            TweenLite.killTweensOf(this._digitSprite);
         }
         if(this._moviePlayer != null)
         {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
         }
         if(this._animation != null)
         {
            DisplayObjectUtil.removeFromParent(this._animation);
            FightAnimationResourcePool.checkInMC(ANGER_RESOURCE_NAME,this._animation);
            this._animation = null;
         }
         super.dispose();
      }
      
      private function playHpRecoverAnimation(param1:int) : void
      {
         if(this._animation == null)
         {
            this._animation = FightAnimationResourcePool.checkOutMC(HP_RESOURCE_NAME);
            this._numContainer = new Sprite();
            addChild(this._numContainer);
         }
         this.deployAnimation(this._animation);
         addChild(this._animation);
         this._moviePlayer = new FighterMoviePlayer(this._animation,this.onAnimationEnd,ClientConfig.timeRate,1,this.onAnimationUpdate);
         this.createNumberSprites(param1,"UI_NumberHpIncrease");
      }
      
      private function playAngerRecoverAnimation(param1:int) : void
      {
         if(this._animation == null)
         {
            this._animation = FightAnimationResourcePool.checkOutMC(ANGER_RESOURCE_NAME);
         }
         if(this._numContainer == null)
         {
            this._numContainer = new Sprite();
            addChild(this._numContainer);
         }
         this.deployAnimation(this._animation);
         addChild(this._animation);
         this._moviePlayer = new FighterMoviePlayer(this._animation,this.onAnimationEnd,ClientConfig.timeRate,1,this.onAnimationUpdate);
         this.createNumberSprites(param1,"UI_NumberAngerIncrease");
      }
      
      private function onAnimationUpdate() : void
      {
         this.deployAnimation(this._animation);
      }
      
      private function onAnimationEnd() : void
      {
         DisplayObjectUtil.removeFromParent(this._animation);
         dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
      }
      
      private function deployAnimation(param1:MovieClip) : void
      {
         var _loc2_:FighterPositionInfo = null;
         if(this._fighter == null)
         {
            return;
         }
         _loc2_ = this._fighter.getFighterTargetPosition();
         param1.x = _loc2_.targetX;
         param1.y = _loc2_.targetY;
         if(this._numContainer != null)
         {
            this._numContainer.x = _loc2_.targetX;
            this._numContainer.y = _loc2_.targetY;
         }
      }
      
      private function createNumberSprites(param1:uint, param2:String) : void
      {
         this._digitSprite = this.createNumberSprite(param2,param1);
         this._numContainer.addChild(this._digitSprite);
         this.deployDigitSprite(this._digitSprite,this._side);
         var _loc3_:int = 150;
         TweenLite.to(this._digitSprite,2,{
            "y":_loc3_,
            "ease":Expo.easeOut,
            "onComplete":this.onAnimateComplete
         });
      }
      
      private function createNumberSprite(param1:String, param2:int) : Sprite
      {
         var _loc9_:Sprite = null;
         var _loc3_:int = 25;
         var _loc4_:Sprite = new Sprite();
         var _loc5_:Sprite = UIManager.getSprite(param1 + "Plus");
         _loc4_.addChild(_loc5_);
         var _loc6_:Vector.<int>;
         var _loc7_:int = int((_loc6_ = NumberUtil.parseNumberToDigitVec(param2)).length);
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            (_loc9_ = UIManager.getSprite(param1 + _loc6_[_loc8_])).x = (_loc8_ + 1) * _loc3_;
            _loc4_.addChild(_loc9_);
            _loc8_++;
         }
         return _loc4_;
      }
      
      private function deployDigitSprite(param1:Sprite, param2:uint) : void
      {
         if(param2 == FightSide.LEFT)
         {
            param1.x = 100;
            param1.y = 0;
         }
         else
         {
            param1.x = 760;
            param1.y = 250;
         }
      }
      
      private function onAnimateComplete() : void
      {
         TweenLite.to(this._digitSprite,2,{
            "alpha":0,
            "ease":Expo.easeOut,
            "onComplete":this.onPlayComplete
         });
      }
      
      private function onPlayComplete() : void
      {
         DisplayObjectUtil.removeFromParent(this._numContainer);
         DisplayObjectUtil.removeFromParent(this._digitSprite);
         this._digitSprite = null;
      }
   }
}
