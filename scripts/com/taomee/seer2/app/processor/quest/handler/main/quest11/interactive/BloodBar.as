package com.taomee.seer2.app.processor.quest.handler.main.quest11.interactive
{
   import com.taomee.seer2.core.map.ResourceLibrary;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BloodBar extends Sprite
   {
      
      public static const BLOOD_OVER:String = "bloodOver";
       
      
      private var _type:int;
      
      private var _totalBlood:int;
      
      private var _displayMC:MovieClip;
      
      private var _currentBlood:int;
      
      public function BloodBar(param1:int, param2:int, param3:ResourceLibrary)
      {
         super();
         this._type = param1;
         this._totalBlood = param2;
         this._currentBlood = param2;
         this._displayMC = param3.getMovieClip("BloodBar_" + this._type);
         addChild(this._displayMC);
      }
      
      public function updataBlood(param1:int) : void
      {
         this._currentBlood -= param1;
         if(this._currentBlood >= 50)
         {
            this._currentBlood = 50;
         }
         if(this._currentBlood <= 0)
         {
            this.dispatchEvent(new Event(BLOOD_OVER));
            return;
         }
         var _loc2_:Number = this._currentBlood / this._totalBlood;
         this._displayMC["blood"].scaleX = _loc2_;
      }
   }
}
