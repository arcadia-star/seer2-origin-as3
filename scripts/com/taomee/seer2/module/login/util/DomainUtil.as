package com.taomee.seer2.module.login.util
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.media.Sound;
   import flash.system.ApplicationDomain;
   
   public class DomainUtil
   {
       
      
      public function DomainUtil()
      {
         super();
      }
      
      public static function getMovieClip(param1:String, param2:ApplicationDomain) : MovieClip
      {
         var _loc3_:DisplayObject = getDisplayObject(param1,param2);
         return _loc3_ == null ? null : _loc3_ as MovieClip;
      }
      
      public static function getSimpleButton(param1:String, param2:ApplicationDomain) : SimpleButton
      {
         var _loc3_:DisplayObject = getDisplayObject(param1,param2);
         return _loc3_ == null ? null : _loc3_ as SimpleButton;
      }
      
      public static function getSound(param1:String, param2:ApplicationDomain) : Sound
      {
         var name:String = param1;
         var domain:ApplicationDomain = param2;
         var classReference:Class = getClass(name,domain);
         if(classReference)
         {
            try
            {
               return new classReference() as Sound;
            }
            catch(e:Error)
            {
            }
         }
         return null;
      }
      
      public static function getDisplayObject(param1:String, param2:ApplicationDomain) : DisplayObject
      {
         var name:String = param1;
         var domain:ApplicationDomain = param2;
         var classReference:Class = getClass(name,domain);
         if(classReference != null)
         {
            try
            {
               return new classReference() as DisplayObject;
            }
            catch(e:Error)
            {
               return null;
            }
         }
         else
         {
            return null;
         }
      }
      
      public static function getClass(param1:String, param2:ApplicationDomain) : Class
      {
         if(param2 == null)
         {
            return null;
         }
         if(param2.hasDefinition(param1))
         {
            return param2.getDefinition(param1) as Class;
         }
         return null;
      }
   }
}
