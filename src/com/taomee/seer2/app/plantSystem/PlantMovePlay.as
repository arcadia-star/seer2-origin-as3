package com.taomee.seer2.app.plantSystem
{
   import flash.display.Sprite;
   
   public class PlantMovePlay
   {
      
      public static const PATH_UP:String = "up";
      
      public static const PATH_DOWN:String = "down";
      
      public static const PATH_LEFT:String = "left";
      
      public static const PATH_RIGHT:String = "right";
       
      
      public function PlantMovePlay()
      {
         super();
      }
      
      public static function playNumber(param1:String, param2:Sprite) : Sprite
      {
         return new NumMovePlay(param1,param2);
      }
   }
}

import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.taomee.seer2.core.ui.UIManager;
import flash.display.Sprite;
import org.taomee.utils.DisplayUtil;

class NumMovePlay extends Sprite
{
    
   
   private var _sprite:Sprite;
   
   public function NumMovePlay(param1:String, param2:Sprite)
   {
      super();
      this._sprite = this.getNumDisplay(param1,param2);
      addChild(this._sprite);
      TweenLite.to(this._sprite,2,{
         "y":param2.y - 30,
         "ease":Expo.easeOut,
         "onComplete":this.onAnimateComplete
      });
   }
   
   private function onAnimateComplete() : void
   {
      TweenLite.to(this._sprite,2,{
         "alpha":0,
         "ease":Expo.easeOut,
         "onComplete":this.onPlayComplete
      });
   }
   
   private function onPlayComplete() : void
   {
      DisplayUtil.removeForParent(this._sprite);
      this._sprite = null;
   }
   
   private function getNumDisplay(param1:String, param2:Sprite) : Sprite
   {
      var _loc6_:Sprite = null;
      var _loc3_:Sprite = new Sprite();
      var _loc4_:uint = uint(param1.length);
      var _loc5_:int = 0;
      while(_loc5_ < _loc4_)
      {
         if(param1.charAt(_loc5_) == "+")
         {
            _loc6_ = UIManager.getSprite("UI_NumberHpIncrease" + "Plus");
         }
         else
         {
            _loc6_ = UIManager.getSprite("UI_NumberHpIncrease" + param1.charAt(_loc5_));
         }
         _loc6_.x = _loc5_ * 25;
         _loc3_.addChild(_loc6_);
         _loc3_.x = 45;
         _loc3_.y = 10;
         param2.addChild(_loc3_);
         _loc5_++;
      }
      return param2;
   }
}
