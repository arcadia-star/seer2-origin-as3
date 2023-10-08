package com.taomee.seer2.app.arena.resource
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import org.taomee.ds.HashMap;
   
   public class FightAnimationResourcePool
   {
      
      private static var _resourceMap:HashMap = new HashMap();
      
      private static var _spriteResourceMap:HashMap = new HashMap();
       
      
      public function FightAnimationResourcePool()
      {
         super();
      }
      
      public static function checkInSprite(param1:String, param2:Sprite) : void
      {
         var _loc3_:Vector.<Sprite> = getSpriteVec(param1);
         _loc3_.push(param2);
      }
      
      public static function checkOutSprite(param1:String) : Sprite
      {
         var _loc3_:Sprite = null;
         var _loc2_:Vector.<Sprite> = getSpriteVec(param1);
         if(_loc2_.length > 0)
         {
            return _loc2_.pop();
         }
         return FightUIManager.getSprite(param1);
      }
      
      private static function getSpriteVec(param1:String) : Vector.<Sprite>
      {
         var _loc2_:Vector.<Sprite> = null;
         if(_spriteResourceMap.containsKey(param1) == false)
         {
            _loc2_ = new Vector.<Sprite>();
            _spriteResourceMap.add(param1,_loc2_);
         }
         return _spriteResourceMap.getValue(param1) as Vector.<Sprite>;
      }
      
      public static function checkOutMC(param1:String) : MovieClip
      {
         var _loc3_:MovieClip = null;
         var _loc2_:Vector.<MovieClip> = getMcVec(param1);
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc2_.pop();
            _loc3_.gotoAndPlay(1);
            return _loc3_;
         }
         return FightUIManager.getMovieClip(param1);
      }
      
      private static function getMcVec(param1:String) : Vector.<MovieClip>
      {
         var _loc2_:Vector.<MovieClip> = null;
         if(_resourceMap.containsKey(param1) == false)
         {
            _loc2_ = new Vector.<MovieClip>();
            _resourceMap.add(param1,_loc2_);
         }
         return _resourceMap.getValue(param1) as Vector.<MovieClip>;
      }
      
      public static function checkInMC(param1:String, param2:MovieClip) : void
      {
         param2.gotoAndStop(param2.totalFrames);
         var _loc3_:Vector.<MovieClip> = getMcVec(param1);
         _loc3_.push(param2);
      }
   }
}
