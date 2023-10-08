package com.taomee.seer2.app.home.garbage
{
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.geom.Point;
   
   public class HomeGarbageData
   {
      
      public static const ROACH:String = "roach";
      
      public static const CAPSULE:String = "capsule";
      
      public static const MEDICINE:String = "medicine";
       
      
      public var type:String;
      
      public var pos:Point;
      
      public function HomeGarbageData()
      {
         super();
      }
      
      public function get url() : String
      {
         return URLUtil.getRes("common/home/" + this.type + URLUtil.POSTFIX_SWF);
      }
   }
}
