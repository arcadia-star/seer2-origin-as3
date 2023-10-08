package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.TongHunChapter2Support;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_950 extends MapProcessor_920
   {
       
      
      private var keyBtnVec:Vector.<MovieClip>;
      
      private var keyOrder:Array;
      
      private var creakNum:int = 0;
      
      private var stairMc:MovieClip;
      
      private var _isCrack:Boolean = false;
      
      private var nextMc:MovieClip;
      
      private var hinderPath:MovieClip;
      
      public function MapProcessor_950(param1:MapModel)
      {
         this.keyOrder = [2,3,1,4];
         super(param1);
      }
      
      public function get isCrack() : Boolean
      {
         return this._isCrack;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.keyBtnVec[_loc1_].removeEventListener(MouseEvent.CLICK,this.showLight);
            _loc1_++;
         }
         this.keyBtnVec = null;
         TongHunChapter2Support.getInstance().dispose();
      }
      
      override public function init() : void
      {
         var _loc1_:int = 0;
         super.init();
         this.keyBtnVec = new Vector.<MovieClip>();
         this.hinderPath = _map.path["hinder"];
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this.keyBtnVec.push(_map.content["keyMc"]["key" + _loc1_]);
            this.keyBtnVec[_loc1_].addEventListener(MouseEvent.CLICK,this.showLight);
            this.keyBtnVec[_loc1_].mouseChildren = false;
            this.keyBtnVec[_loc1_].buttonMode = true;
            if(_loc1_ != 0)
            {
               this.keyBtnVec[_loc1_].gotoAndStop(1);
            }
            else
            {
               this.keyBtnVec[0].gotoAndStop(2);
            }
            _loc1_++;
         }
         this.nextMc = this.keyBtnVec[0];
         this.stairMc = _map.content["stairMc"];
         this.stairMc.gotoAndStop(1);
         this.stairMc.mouseChildren = false;
         this.stairMc.mouseEnabled = true;
         TongHunChapter2Support.getInstance().setup();
      }
      
      private function showLight(param1:MouseEvent) : void
      {
         var pushMc:MovieClip;
         var mc:MovieClip = null;
         var event:MouseEvent = param1;
         mc = event.target as MovieClip;
         if(this.nextMc != mc)
         {
            return;
         }
         mc.removeEventListener(MouseEvent.CLICK,this.showLight);
         mc.gotoAndStop(3);
         pushMc = mc.getChildAt(0) as MovieClip;
         MovieClipUtil.playMc(pushMc,1,pushMc.totalFrames,function():void
         {
            ++creakNum;
            if(mc == keyBtnVec[4])
            {
               MovieClipUtil.playMc(stairMc,2,stairMc.totalFrames,playend);
            }
            else
            {
               nextMc = keyBtnVec[keyOrder[keyBtnVec.indexOf(mc)]];
               nextMc.gotoAndStop(2);
            }
         });
      }
      
      private function playend() : void
      {
         this.stairMc.mouseEnabled = false;
         this._isCrack = true;
         DisplayObjectUtil.removeFromParent(this.hinderPath);
         _map.recalculatePathData();
      }
   }
}
