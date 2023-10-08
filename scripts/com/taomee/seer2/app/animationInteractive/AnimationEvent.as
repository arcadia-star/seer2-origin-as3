package com.taomee.seer2.app.animationInteractive
{
   import flash.events.Event;
   
   public class AnimationEvent extends Event
   {
      
      public static const MAKEBUBBLE:String = "makeBubble";
      
      public static const MAKECOLOR:String = "makeColor";
      
      public static const PUZZLEPICTURE:String = "puzzlePicture";
      
      public static const STONE:String = "stone";
      
      public static const FINDDUDU:String = "findDudu";
      
      public static const KEEPBALANCE:String = "keepBalance";
      
      public static const LEAVEALONE:String = "leaveAlone";
      
      public static const SELECT:String = "select";
       
      
      public function AnimationEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
