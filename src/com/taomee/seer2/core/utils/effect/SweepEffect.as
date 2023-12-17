package com.taomee.seer2.core.utils.effect
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Elastic;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import org.taomee.ds.HashMap;
   
   public class SweepEffect
   {
      
      private static var _instance:SweepEffect;
       
      
      private var _hashMap:HashMap;
      
      public function SweepEffect()
      {
         super();
         this._hashMap = new HashMap();
      }
      
      public static function get instance() : SweepEffect
      {
         if(_instance == null)
         {
            _instance = new SweepEffect();
         }
         return _instance;
      }
      
      public function add(param1:InteractiveObject, param2:DisplayObject) : void
      {
         if(!this._hashMap.containsKey(param1))
         {
            this._hashMap.add(param1,param2);
            param1.mouseEnabled = true;
            param1.addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
         }
      }
      
      public function remove(param1:InteractiveObject) : void
      {
         if(this._hashMap.containsKey(param1))
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
            this._hashMap.remove(param1);
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:InteractiveObject = param1.currentTarget as InteractiveObject;
         var _loc3_:DisplayObject = this._hashMap.getValue(_loc2_);
         _loc3_.scaleX = _loc3_.scaleY = 0.7;
         TweenLite.to(_loc3_,1,{
            "scaleX":1,
            "scaleY":1,
            "ease":Elastic.easeOut
         });
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:InteractiveObject = param1.currentTarget as InteractiveObject;
         var _loc3_:DisplayObject = this._hashMap.getValue(_loc2_);
         _loc3_.scaleX = 1;
         _loc3_.scaleY = 1;
      }
   }
}
