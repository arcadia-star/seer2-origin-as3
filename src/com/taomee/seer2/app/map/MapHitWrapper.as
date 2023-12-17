package com.taomee.seer2.app.map
{
   import flash.display.Sprite;
   
   public class MapHitWrapper
   {
       
      
      private var _hit:Sprite;
      
      public function MapHitWrapper(param1:Sprite)
      {
         super();
         this._hit = param1;
      }
      
      public function openInteraction() : void
      {
         this._hit.mouseEnabled = true;
         this._hit.mouseChildren = true;
         this._hit.buttonMode = true;
      }
      
      public function closeInteraction() : void
      {
         this._hit.mouseEnabled = false;
         this._hit.mouseChildren = false;
         this._hit.buttonMode = false;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._hit.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._hit.removeEventListener(param1,param2,param3);
      }
      
      public function dispose() : void
      {
         this._hit = null;
      }
   }
}
