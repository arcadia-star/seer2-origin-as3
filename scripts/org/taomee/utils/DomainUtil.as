package org.taomee.utils
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.media.Sound;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class DomainUtil
   {
       
      
      public function DomainUtil()
      {
         super();
      }
      
      public static function getSimpleButton(param1:String, param2:ApplicationDomain) : SimpleButton
      {
         var _loc3_:DisplayObject = getDisplayObject(param1,param2);
         return _loc3_ == null ? null : _loc3_ as SimpleButton;
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
               trace("DomainUtil getDisplayObject error:" + e.toString());
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
            trace("DomainUtil getClass domain=null");
            return null;
         }
         if(param2.hasDefinition(param1))
         {
            return param2.getDefinition(param1) as Class;
         }
         trace("DomainUtil getClass not hasDefinition:" + param1);
         return null;
      }
      
      public static function getCurrentDomainClass(param1:String) : Class
      {
         var classReference:Class = null;
         var name:String = param1;
         try
         {
            classReference = getDefinitionByName(name) as Class;
         }
         catch(e:Error)
         {
            trace("DomainUtil getCurrentDomainClass " + name + "error" + e.message);
            return null;
         }
         return classReference;
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
               trace("DomainUtil getSound error:" + e.toString());
            }
         }
         return null;
      }
      
      public static function getMovieClip(param1:String, param2:ApplicationDomain) : MovieClip
      {
         var _loc3_:DisplayObject = getDisplayObject(param1,param2);
         return _loc3_ == null ? null : _loc3_ as MovieClip;
      }
      
      public static function getSprite(param1:String, param2:ApplicationDomain) : Sprite
      {
         var _loc3_:DisplayObject = getDisplayObject(param1,param2);
         return _loc3_ == null ? null : _loc3_ as Sprite;
      }
      
      public static function getByteArray(param1:String, param2:ApplicationDomain) : ByteArray
      {
         var name:String = param1;
         var domain:ApplicationDomain = param2;
         var classReference:Class = getClass(name,domain);
         if(classReference != null)
         {
            try
            {
               return new classReference() as ByteArray;
            }
            catch(e:Error)
            {
               trace("DomainUtil getByteArray error:" + e.toString());
               return null;
            }
         }
         else
         {
            return null;
         }
      }
      
      public static function getBitmapData(param1:String, param2:ApplicationDomain) : BitmapData
      {
         var name:String = param1;
         var domain:ApplicationDomain = param2;
         var classReference:Class = getClass(name,domain);
         if(classReference)
         {
            try
            {
               return new classReference(0,0) as BitmapData;
            }
            catch(e:Error)
            {
               trace("DomainUtil getBitmapData error:" + e.toString());
            }
         }
         return null;
      }
   }
}
