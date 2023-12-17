package com.taomee.seer2.app.animationInteractive
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class StoneInteractive extends BaseAniamationInteractive
   {
       
      
      private var _stoneVec:Vector.<MovieClip>;
      
      private var _stonePitVec:Vector.<MovieClip>;
      
      private var _stonePoint:Point;
      
      private var _stoneMC:MovieClip;
      
      public function StoneInteractive()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         this._stoneVec = Vector.<MovieClip>([]);
         this._stonePitVec = Vector.<MovieClip>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this._stoneVec.push(_animation["stone" + _loc1_]);
            this._stonePitVec.push(_animation["stonePit" + _loc1_]);
            _loc1_++;
         }
         this.addMouseClick();
      }
      
      private function addMouseClick() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._stoneVec)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onStoneClick);
            _loc1_.buttonMode = true;
         }
      }
      
      private function onStoneClick(param1:MouseEvent) : void
      {
         this._stoneMC = param1.currentTarget as MovieClip;
         this._stoneMC.gotoAndStop(2);
         this._stoneMC.mouseChildren = false;
         this._stoneMC.mouseEnabled = false;
         this._stonePoint = new Point(this._stoneMC.x,this._stoneMC.y);
         this.removeMouseClick();
         this.addPitMouseClick();
         this._stoneMC.addEventListener(Event.ENTER_FRAME,this.onStoneEnterFrame);
      }
      
      private function addPitMouseClick() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._stonePitVec)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onPitClick);
            _loc1_.buttonMode = true;
         }
      }
      
      private function onPitClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:int = this._stonePitVec.indexOf(_loc2_);
         _loc4_ = this._stoneVec.indexOf(this._stoneMC);
         if(_loc3_ == _loc4_)
         {
            this._stoneMC.x = _loc2_.x;
            this._stoneMC.y = _loc2_.y;
            this.removePitMouseClick();
            this._stonePitVec.splice(_loc4_,1);
            this._stoneVec.splice(_loc4_,1);
            this.addMouseClick();
         }
         else
         {
            this._stoneMC.x = this._stonePoint.x;
            this._stoneMC.y = this._stonePoint.y;
            this._stoneMC.gotoAndStop(1);
            this._stoneMC.mouseChildren = true;
            this._stoneMC.mouseEnabled = true;
            this.addMouseClick();
            this.removePitMouseClick();
         }
         this._stoneMC.removeEventListener(Event.ENTER_FRAME,this.onStoneEnterFrame);
         if(this._stoneVec.length <= 0)
         {
            this.gameWin();
         }
      }
      
      private function gameWin() : void
      {
         _closeBtn.mouseEnabled = false;
         this.clear();
         setTimeout(function():void
         {
            dispatchEvent(new Event(AnimationEvent.STONE));
            dispose();
         },1000);
      }
      
      private function onStoneEnterFrame(param1:Event) : void
      {
         this._stoneMC.x = LayerManager.stage.mouseX - this._stoneMC.width / 2;
         this._stoneMC.y = LayerManager.stage.mouseY - this._stoneMC.height / 2;
      }
      
      private function removeMouseClick() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._stoneVec)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onStoneClick);
         }
      }
      
      private function removePitMouseClick() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._stonePitVec)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onPitClick);
            _loc1_.buttonMode = false;
         }
      }
      
      private function clear() : void
      {
         this.removeMouseClick();
         this.removePitMouseClick();
         this._stoneVec = Vector.<MovieClip>([]);
         this._stonePitVec = Vector.<MovieClip>([]);
         if(this._stoneMC)
         {
            this._stoneMC.removeEventListener(Event.ENTER_FRAME,this.onStoneEnterFrame);
            this._stoneMC = null;
         }
      }
      
      override public function dispose() : void
      {
         this.clear();
         _closeBtn.mouseEnabled = true;
         super.dispose();
      }
   }
}
