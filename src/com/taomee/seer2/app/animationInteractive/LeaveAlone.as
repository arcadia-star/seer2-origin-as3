package com.taomee.seer2.app.animationInteractive
{
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class LeaveAlone extends BaseAniamationInteractive
   {
       
      
      private var _treeBtnVec:Vector.<MovieClip>;
      
      private var _animationVec:Vector.<MovieClip>;
      
      private const TREEBTNCOUNT:int = 17;
      
      private const ANIMATIONCOUNT:int = 7;
      
      private const POINTDIS:Number = 12;
      
      private var _startPos:Point;
      
      private var _lineLength:Number;
      
      private var _currentLine:MovieClip;
      
      private var _lineSp:Sprite;
      
      private var _lineCount:int;
      
      private var _treeLineVec:Vector.<Line>;
      
      private var _animationLineVec:Vector.<Line>;
      
      private var _delay:int;
      
      public function LeaveAlone()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         this._treeBtnVec = new Vector.<MovieClip>();
         this._animationVec = new Vector.<MovieClip>();
         this._lineCount = 0;
         this._lineSp = new Sprite();
         _animation.addChild(this._lineSp);
         this._treeLineVec = new Vector.<Line>();
         var _loc1_:int = 0;
         while(_loc1_ < this.TREEBTNCOUNT)
         {
            _loc3_ = _animation["treeBtn_" + _loc1_];
            _loc3_.buttonMode = true;
            _loc3_.addEventListener(MouseEvent.CLICK,this.onTreeBtnClick);
            this._treeBtnVec.push(_loc3_);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.ANIMATIONCOUNT)
         {
            _loc4_ = _animation["animation_" + _loc2_];
            this._animationVec.push(_loc4_);
            _loc2_++;
         }
         _animation.addEventListener(Event.ENTER_FRAME,this.onEnterFramer);
         this.createAnimationLines();
      }
      
      private function createAnimationLines() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:Line = null;
         this._animationLineVec = new Vector.<Line>();
         var _loc1_:int = 0;
         while(_loc1_ < this.ANIMATIONCOUNT - 1)
         {
            _loc2_ = _loc1_ + 1;
            while(_loc2_ < this.ANIMATIONCOUNT)
            {
               _loc3_ = new Point(this._animationVec[_loc1_].x,this._animationVec[_loc1_].y);
               _loc4_ = new Point(this._animationVec[_loc2_].x,this._animationVec[_loc2_].y);
               _loc5_ = new Line(_loc3_,_loc4_);
               this._animationLineVec.push(_loc5_);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function onTreeBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:Line = null;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:Point = new Point(_loc2_.x,_loc2_.y);
         if(this._startPos == null)
         {
            this._startPos = new Point(_loc2_.x,_loc2_.y);
            this._currentLine = this.createLine();
            this._currentLine.x = this._startPos.x;
            this._currentLine.y = this._startPos.y;
            this._currentLine.scaleX = 0.1;
            this._lineSp.addChild(this._currentLine);
         }
         else
         {
            if(_loc3_.x == this._startPos.x && _loc3_.y == this._startPos.y)
            {
               return;
            }
            _loc4_ = new Line(this._startPos,_loc3_);
            this._treeLineVec.push(_loc4_);
            ++this._lineCount;
            if(this._lineCount >= 3)
            {
               this.checkAnswer();
            }
            this._startPos = null;
            this._currentLine = null;
         }
      }
      
      private function onEnterFramer(param1:Event) : void
      {
         if(this._startPos != null)
         {
            this.drawLine();
         }
      }
      
      private function createLine() : MovieClip
      {
         var _loc1_:MovieClip = getMovieClip("line");
         this._lineLength = _loc1_.width;
         _loc1_.mouseEnabled = false;
         _loc1_.mouseChildren = false;
         return _loc1_;
      }
      
      private function drawLine() : void
      {
         var _loc1_:Point = new Point(LayerManager.topLayer.mouseX - 120,LayerManager.topLayer.mouseY - 50);
         var _loc2_:Number = this._startPos.x - _loc1_.x;
         var _loc3_:Number = this._startPos.y - _loc1_.y;
         var _loc4_:Number = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
         this._currentLine.scaleX = _loc4_ / this._lineLength;
         this._currentLine.rotation = Math.atan2(_loc3_,_loc2_) * 180 / Math.PI + 180;
      }
      
      private function isAllAlone() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._animationLineVec.length)
         {
            if(this.isAlone(_loc1_) == false)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function isAlone(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._treeLineVec.length)
         {
            if(this.isCross(this._animationLineVec[param1],this._treeLineVec[_loc2_]) == true)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function isCross(param1:Line, param2:Line) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param1.k == param2.k)
         {
            return false;
         }
         if(param1.k == int.MAX_VALUE)
         {
            _loc3_ = param1.b;
            _loc4_ = param2.k * param1.b + param2.b;
         }
         else
         {
            _loc3_ = (param2.b - param1.b) / (param1.k - param2.k);
            _loc4_ = param1.b - param1.k * (param1.b - param2.b) / (param1.k - param2.k);
         }
         if(_loc3_ >= param1.minX && _loc3_ <= param1.maxX && _loc4_ >= param1.minY && _loc4_ <= param1.maxY)
         {
            if(_loc3_ >= param2.minX && _loc3_ <= param2.maxX && _loc4_ >= param2.minY && _loc4_ <= param2.maxY)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkAnswer() : void
      {
         if(this.isAllAlone())
         {
            _closeBtn.mouseEnabled = false;
            this.clearEvent();
            this._delay = setTimeout(function():void
            {
               clearTimeout(_delay);
               dispatchEvent(new Event(AnimationEvent.LEAVEALONE));
               dispose();
            },2000);
         }
         else
         {
            AlertManager.showConfirm("3根连线已用完，未解开谜题，再来一次吗？",function():void
            {
               reset();
            },function():void
            {
               dispose();
            });
         }
      }
      
      private function reset() : void
      {
         DisplayObjectUtil.removeAllChildren(this._lineSp);
         this._startPos = null;
         this._currentLine = null;
         this._lineCount = 0;
         var _loc1_:int = int(this._treeLineVec.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._treeLineVec.pop();
            _loc2_++;
         }
      }
      
      private function clearEvent() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.TREEBTNCOUNT)
         {
            this._treeBtnVec[_loc1_].removeEventListener(MouseEvent.CLICK,this.onTreeBtnClick);
            _loc1_++;
         }
         _animation.removeEventListener(Event.ENTER_FRAME,this.onEnterFramer);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.clearEvent();
         this.reset();
      }
   }
}

import flash.geom.Point;

class Line
{
    
   
   public var startPt:Point;
   
   public var endPt:Point;
   
   public var k:Number;
   
   public var b:Number;
   
   public function Line(param1:Point, param2:Point)
   {
      super();
      this.startPt = param1;
      this.endPt = param2;
      if(param2.x == param1.x)
      {
         this.b = param1.x;
         this.k = int.MAX_VALUE;
         return;
      }
      this.k = (param2.y - param1.y) / (param2.x - param1.x);
      this.b = param2.y - param2.x * this.k;
   }
   
   public function get maxX() : Number
   {
      if(this.startPt.x >= this.endPt.x)
      {
         return this.startPt.x;
      }
      return this.endPt.x;
   }
   
   public function get minX() : Number
   {
      if(this.startPt.x >= this.endPt.x)
      {
         return this.endPt.x;
      }
      return this.startPt.x;
   }
   
   public function get maxY() : Number
   {
      if(this.startPt.y >= this.endPt.y)
      {
         return this.startPt.y;
      }
      return this.endPt.y;
   }
   
   public function get minY() : Number
   {
      if(this.startPt.y >= this.endPt.y)
      {
         return this.endPt.y;
      }
      return this.startPt.y;
   }
}
