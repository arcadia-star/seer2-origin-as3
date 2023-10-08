package com.taomee.seer2.app.arena.animation.imples
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Expo;
   import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
   import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
   import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.config.skill.SkillTypeRelation;
   import com.taomee.seer2.core.utils.NumberUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class HpDecreaseAnimation extends BaseAnimation
   {
      
      private static const DIGIT_WIDTH:int = 30;
      
      private static const DIGIT_HEIGHT:int = 38;
      
      private static const DIGIT_VERTICAL_GAP:int = 2;
       
      
      private var _back:MovieClip;
      
      private var _digitSpriteVec:Vector.<MovieClip>;
      
      private var _digitResNameVec:Vector.<String>;
      
      private var _reducedHp:int;
      
      private var _initChangeHp:int;
      
      private var _fightSide:int;
      
      private var _isBaoJi:Boolean;
      
      private var _skillTypeRelation:uint;
      
      private var _isShowTip:Boolean;
      
      public function HpDecreaseAnimation()
      {
         super();
         this.initialize();
      }
      
      override public function initData(param1:Object) : void
      {
         this._reducedHp = param1["reducedHp"];
         this._initChangeHp = param1["initChangeHp"];
         this._fightSide = param1["fightSide"];
         this._isBaoJi = param1["isBaoJi"];
         this._skillTypeRelation = param1["skillTypeRelation"];
      }
      
      override public function initialize() : void
      {
         if(this._back == null)
         {
            this._back = FightAnimationResourcePool.checkOutMC("UI_FightSplash");
         }
         this._back.gotoAndStop(1);
         addChild(this._back);
      }
      
      override public function play() : void
      {
         var _loc5_:Number = NaN;
         this.y = 200;
         this.x = this._fightSide == FightSide.LEFT ? 200 : 760;
         var _loc1_:uint = 1;
         if(this._skillTypeRelation == SkillTypeRelation.KEZHI)
         {
            _loc1_ = 2;
         }
         else if(this._skillTypeRelation == SkillTypeRelation.WEIRUO)
         {
            _loc1_ = 3;
         }
         this._back.gotoAndStop(_loc1_);
         this._digitSpriteVec = new Vector.<MovieClip>();
         this._digitResNameVec = new Vector.<String>();
         this.createHurtTip();
         this.createDigitSpriteVec();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = Math.random() * 100;
         if(this._fightSide == FightSide.LEFT)
         {
            _loc5_ = 300;
            if(_loc4_ > 50 && _loc4_ < 80)
            {
               _loc5_ = 200;
            }
            else if(_loc4_ < 50)
            {
               _loc5_ = 350;
            }
            _loc2_ = _loc5_ + NumberUtil.getRandomInt(80);
            _loc3_ = 75 + NumberUtil.getRandomInt(40);
         }
         else
         {
            _loc5_ = 500;
            if(_loc4_ > 30 && _loc4_ < 60)
            {
               _loc5_ = 600;
            }
            else if(_loc4_ > 60 && _loc4_ < 80)
            {
               _loc5_ = 650;
            }
            else if(_loc4_ > 80)
            {
               _loc5_ = 450;
            }
            _loc2_ = _loc5_ + NumberUtil.getRandomInt(80);
            _loc3_ = 75 + NumberUtil.getRandomInt(40);
         }
         var _loc6_:uint = 2;
         var _loc7_:uint = 2;
         if(this._isBaoJi == true)
         {
            _loc6_ = _loc7_ = 3;
         }
         TweenLite.to(this,0.5,{
            "x":_loc2_,
            "y":_loc3_,
            "scaleX":_loc6_,
            "scaleY":_loc7_,
            "ease":Expo.easeOut,
            "onComplete":this.onAnimateComplete
         });
      }
      
      private function onAnimateComplete() : void
      {
         TweenLite.to(this,1,{
            "alpha":0,
            "ease":Expo.easeOut,
            "onComplete":this.onPlayComplete
         });
      }
      
      private function onPlayComplete() : void
      {
         dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         TweenLite.killTweensOf(this);
         if(this._back != null)
         {
            FightAnimationResourcePool.checkInMC("UI_FightSplash",this._back);
            DisplayUtil.removeForParent(this._back);
            this._back = null;
         }
         if(this._digitSpriteVec != null)
         {
            _loc1_ = int(this._digitSpriteVec.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               FightAnimationResourcePool.checkInMC(this._digitResNameVec[_loc2_],this._digitSpriteVec[_loc2_]);
               DisplayUtil.removeForParent(this._digitSpriteVec[_loc2_]);
               _loc2_++;
            }
            this._digitSpriteVec = null;
         }
         this._digitResNameVec = null;
         super.dispose();
      }
      
      private function deployDigitSpriteVec() : void
      {
         var _loc7_:MovieClip = null;
         var _loc1_:int = int(this._digitSpriteVec.length);
         var _loc2_:int = _loc1_ * DIGIT_WIDTH;
         var _loc3_:int = _loc1_ * DIGIT_VERTICAL_GAP + DIGIT_HEIGHT;
         var _loc4_:* = 100 - _loc2_ >> 1;
         var _loc5_:* = 100 - _loc3_ >> 1;
         var _loc6_:int = 0;
         while(_loc6_ < _loc1_)
         {
            _loc7_ = this._digitSpriteVec[_loc6_];
            if(_loc6_ == 0 && this._isShowTip)
            {
               _loc7_.x = _loc4_ - 10;
               _loc7_.y = _loc5_ + 10;
            }
            else
            {
               _loc7_.x = _loc4_ + _loc6_ * DIGIT_WIDTH;
               _loc7_.y = _loc5_ + _loc6_ * DIGIT_VERTICAL_GAP;
            }
            _loc6_++;
         }
      }
      
      private function createHurtTip() : void
      {
         var _loc1_:MovieClip = FightAnimationResourcePool.checkOutMC("UI_FightHurtTip");
         var _loc2_:int = 1;
         if(this._isBaoJi)
         {
            _loc2_ = 4;
         }
         else if(this._skillTypeRelation == SkillTypeRelation.KEZHI)
         {
            _loc2_ = 2;
         }
         else if(this._skillTypeRelation == SkillTypeRelation.WEIRUO)
         {
            _loc2_ = 3;
         }
         if(_loc2_ == 1)
         {
            return;
         }
         this._isShowTip = true;
         _loc1_.gotoAndStop(_loc2_);
         _loc1_.x = -_loc1_.width;
         addChild(_loc1_);
         this._digitSpriteVec.push(_loc1_);
         this._digitResNameVec.push("UI_FightHurtTip");
      }
      
      private function createDigitSpriteVec(param1:uint = 1) : void
      {
         var _loc6_:MovieClip = null;
         var _loc2_:MovieClip = FightAnimationResourcePool.checkOutMC("UI_FightSplashMinus");
         _loc2_.gotoAndStop(param1);
         this._digitSpriteVec.push(_loc2_);
         this._digitResNameVec.push("UI_FightSplashMinus");
         addChild(_loc2_);
         var _loc3_:Vector.<int> = NumberUtil.parseNumberToDigitVec(this._reducedHp);
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            (_loc6_ = FightAnimationResourcePool.checkOutMC("UI_FightSplash" + _loc3_[_loc5_])).gotoAndStop(param1);
            this._digitSpriteVec.push(_loc6_);
            this._digitResNameVec.push("UI_FightSplash" + _loc3_[_loc5_]);
            addChild(_loc6_);
            _loc5_++;
         }
         this.deployDigitSpriteVec();
      }
   }
}
