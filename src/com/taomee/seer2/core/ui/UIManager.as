package com.taomee.seer2.core.ui
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.media.Sound;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import org.taomee.ds.HashMap;
   import org.taomee.utils.DomainUtil;
   
   public class UIManager
   {
      
      private static var _domain:ApplicationDomain;
      
      private static var _cache:HashMap = new HashMap();
       
      
      public function UIManager()
      {
         super();
      }
      
      public static function setup(param1:ApplicationDomain) : void
      {
         _domain = param1;
      }
      
      public static function getClass(param1:String) : Class
      {
         return DomainUtil.getClass(param1,_domain);
      }
      
      public static function getMovieClip(param1:String) : MovieClip
      {
         return DomainUtil.getMovieClip(param1,_domain);
      }
      
      public static function getButton(param1:String) : SimpleButton
      {
         return DomainUtil.getSimpleButton(param1,_domain);
      }
      
      public static function getBitmapData(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = null;
         if(_cache.containsKey(param1))
         {
            return _cache.getValue(param1);
         }
         _loc2_ = DomainUtil.getBitmapData(param1,_domain);
         if(_loc2_)
         {
            _cache.add(param1,_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      public static function getSound(param1:String) : Sound
      {
         var _loc2_:Sound = null;
         if(_cache.containsKey(param1))
         {
            return _cache.getValue(param1);
         }
         _loc2_ = DomainUtil.getSound(param1,_domain);
         if(_loc2_)
         {
            _cache.add(param1,_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      public static function getSprite(param1:String) : Sprite
      {
         return DomainUtil.getSprite(param1,_domain);
      }
      
      public static function getByteArray(param1:String) : ByteArray
      {
         return DomainUtil.getByteArray(param1,_domain);
      }
      
      public static function hasDefinition(param1:String) : Boolean
      {
         return _domain.hasDefinition(param1);
      }
   }
}
