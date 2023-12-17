package com.taomee.seer2.app.animationInteractive
{
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.taomee.utils.Tick;
   
   public class Interactive_10222 extends BaseAniamationInteractive
   {
       
      
      private var _timeTxt:TextField;
      
      private var _playMC:MovieClip;
      
      private var _mc1List:Vector.<MovieClip>;
      
      private var _mc1Play:Vector.<MovieClip>;
      
      private var _mc2List:Vector.<MovieClip>;
      
      private var _mc2Play:Vector.<MovieClip>;
      
      private var _timeCount:uint;
      
      public function Interactive_10222()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         LayerManager.showMap();
         this._timeTxt = _animation["timeTxt"];
         this._playMC = _animation["playMC"];
         this._mc1List = Vector.<MovieClip>([]);
         this._mc1Play = Vector.<MovieClip>([]);
         this._mc2List = Vector.<MovieClip>([]);
         this._mc2Play = Vector.<MovieClip>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._mc1List.push(_animation["mc1_" + _loc1_]);
            this._mc1List[_loc1_].addEventListener(MouseEvent.CLICK,this.onMC1);
            this._mc2List.push(_animation["mc2_" + _loc1_]);
            this._mc2List[_loc1_].addEventListener(MouseEvent.CLICK,this.onMC2);
            this._mc1Play.push(_animation["mcPlay1_" + _loc1_]);
            this._mc2Play.push(_animation["mcPlay2_" + _loc1_]);
            this._mc1Play[_loc1_].visible = false;
            this._mc2Play[_loc1_].visible = false;
            _loc1_++;
         }
         this._playMC.gotoAndStop(1);
         this._timeCount = 120;
         this._timeTxt.text = "02:00";
         Tick.instance.addRender(this.onTick,1000);
      }
      
      private function onTick(param1:uint) : void
      {
         var _loc2_:uint = this._timeCount % 60;
         var _loc3_:String = _loc2_.toString();
         if(_loc2_ < 10)
         {
            _loc3_ = "0" + _loc2_;
         }
         this._timeTxt.text = "0" + uint(this._timeCount / 60) + ":" + _loc3_;
         --this._timeCount;
         if(this._timeCount <= 0)
         {
            this.win();
         }
      }
      
      private function onMC1(param1:MouseEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = this._mc1List.indexOf(param1.currentTarget as MovieClip);
         if(_loc2_ != -1)
         {
            _loc3_ = param1.currentTarget as MovieClip;
            _loc3_.removeEventListener(MouseEvent.CLICK,this.onMC1);
            this._mc1Play[_loc2_].visible = true;
            this._mc2Play[_loc2_].visible = true;
            this.checkWin();
         }
      }
      
      private function onMC2(param1:MouseEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = this._mc2List.indexOf(param1.currentTarget as MovieClip);
         if(_loc2_ != -1)
         {
            _loc3_ = param1.currentTarget as MovieClip;
            _loc3_.removeEventListener(MouseEvent.CLICK,this.onMC2);
            this._mc1Play[_loc2_].visible = true;
            this._mc2Play[_loc2_].visible = true;
            this.checkWin();
         }
      }
      
      private function checkWin() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this._mc1Play)
         {
            if(_loc2_.visible == false)
            {
               _loc1_ = false;
            }
         }
         if(_loc1_)
         {
            this.win();
         }
      }
      
      private function win() : void
      {
         var i:int;
         Tick.instance.removeRender(this.onTick);
         i = 0;
         while(i < 5)
         {
            this._mc1Play[i].visible = false;
            this._mc2Play[i].visible = false;
            i++;
         }
         this._playMC.visible = true;
         MovieClipUtil.playMc(this._playMC,2,this._playMC.totalFrames,function():void
         {
            _playMC.visible = false;
            dispatchEvent(new Event(AnimationEvent.STONE));
            dispose();
         },true);
      }
      
      override public function dispose() : void
      {
         this._timeTxt = null;
         this._playMC = null;
         this._mc1List = null;
         this._mc1Play = null;
         this._mc2List = null;
         this._mc2Play = null;
         super.dispose();
      }
   }
}
