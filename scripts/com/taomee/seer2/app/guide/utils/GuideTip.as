package com.taomee.seer2.app.guide.utils
{
   import com.taomee.seer2.app.guide.info.GudieDirectionType;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.effect.EffectShake;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class GuideTip extends Sprite
   {
       
      
      public var tipMC:MovieClip;
      
      private var _rect:Rectangle;
      
      private var _dir:int;
      
      public function GuideTip()
      {
         super();
         this.tipMC = UIManager.getMovieClip("GuiderUI");
         DisplayObjectUtil.disableSprite(this);
         addChild(this.tipMC);
      }
      
      public function showTip(param1:Vector.<Rectangle>, param2:int) : void
      {
         var _loc3_:uint = param1.length;
         if(_loc3_ > 0)
         {
            this._rect = param1[0];
         }
         this._dir = param2;
         this.turnDirection();
      }
      
      private function turnDirection() : void
      {
         var _loc1_:Number = NaN;
         switch(this._dir)
         {
            case GudieDirectionType.LETF_BOTTOM:
               _loc1_ = 225;
               this.tweenTip(this._rect.x,this._rect.y + this._rect.height,_loc1_);
               break;
            case GudieDirectionType.LETF_TOP:
               _loc1_ = 315;
               this.tweenTip(this._rect.x,this._rect.y,_loc1_);
               break;
            case GudieDirectionType.RIGHT_BOTTOM:
               _loc1_ = 135;
               this.tweenTip(this._rect.x + this._rect.width,this._rect.y + this._rect.height,_loc1_);
               break;
            case GudieDirectionType.RIGHT_TOP:
               _loc1_ = 45;
               this.tweenTip(this._rect.x + this._rect.width,this._rect.y,_loc1_);
               break;
            case GudieDirectionType.TOP:
               _loc1_ = 0;
               this.tweenTip(this._rect.x + this._rect.width / 2,this._rect.y - 5,_loc1_);
               break;
            case GudieDirectionType.BOTTOM:
               _loc1_ = 180;
               this.tweenTip(this._rect.x + this._rect.width / 2,this._rect.y + this._rect.height + 5,_loc1_);
               break;
            case GudieDirectionType.LETF:
               _loc1_ = 270;
               this.tweenTip(this._rect.x - 5,this._rect.y + this._rect.height / 2,_loc1_);
               break;
            case GudieDirectionType.RIGHT:
               _loc1_ = 90;
               this.tweenTip(this._rect.x + this._rect.width + 5,this._rect.y + this._rect.height / 2,_loc1_);
               break;
            case GudieDirectionType.CONTENT:
               _loc1_ = 90;
               this.tweenTip(this._rect.x + this._rect.width / 2,this._rect.y + this._rect.height / 2,_loc1_);
         }
      }
      
      private function tweenTip(param1:Number, param2:Number, param3:Number) : void
      {
         this.tipMC.x = param1;
         this.tipMC.y = param2;
         this.tipMC.gotoAndPlay(2);
      }
      
      private function onTweenCom() : void
      {
         this.tipMC.play();
         EffectShake.addShake(this,20,20,5,5);
      }
      
      public function hideTip() : void
      {
         this.tipMC.gotoAndStop(1);
      }
      
      public function close() : void
      {
      }
   }
}
