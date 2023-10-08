package com.taomee.seer2.app.processor.activity.shootingCloud
{
   import flash.display.MovieClip;
   
   public class Cloud
   {
       
      
      private var _mc:MovieClip;
      
      private var _blood:int;
      
      public function Cloud(param1:MovieClip)
      {
         super();
         this._mc = param1;
      }
      
      public function setBlood(param1:int) : void
      {
         this._blood = param1;
      }
      
      public function getBlood() : int
      {
         return this._blood;
      }
      
      public function get mc() : MovieClip
      {
         return this._mc;
      }
   }
}
