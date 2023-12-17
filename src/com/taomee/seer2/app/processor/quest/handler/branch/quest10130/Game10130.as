package com.taomee.seer2.app.processor.quest.handler.branch.quest10130
{
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class Game10130
   {
       
      
      private var _mc:MovieClip;
      
      private var _closeBtn:SimpleButton;
      
      private var _currMC:MovieClip;
      
      private var _mcList:Vector.<MovieClip>;
      
      private var _fun:Function;
      
      private var _pointList:Vector.<MovieClip>;
      
      private var _pointBo:Vector.<Boolean>;
      
      private var _sp:Sprite;
      
      private var _isDown:Boolean;
      
      private var _startPoint:Point;
      
      private var _coinsList:Vector.<MovieClip>;
      
      private var _conisBo:Vector.<Boolean>;
      
      private var _pen:MovieClip;
      
      private var _title:MovieClip;
      
      private var _content:MovieClip;
      
      private var _colorList:Vector.<SimpleButton>;
      
      private var _penIndex:int;
      
      private var _titleIndex:int;
      
      private var _contentIndex:int;
      
      public function Game10130(param1:MovieClip, param2:int, param3:Function)
      {
         super();
         this._mc = param1;
         this._closeBtn = this._mc["closeBtn"];
         this._closeBtn.addEventListener(MouseEvent.CLICK,this.dispose);
         this._fun = param3;
         LayerManager.topLayer.addChild(this._mc);
         DisplayUtil.align(this._mc,4,LayerManager.rootRect);
         this._mcList = Vector.<MovieClip>([]);
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            this._mcList.push(this._mc["mc" + _loc4_]);
            this._mcList[_loc4_].visible = false;
            _loc4_++;
         }
         this._currMC = this._mcList[param2];
         this._currMC.visible = true;
         switch(param2)
         {
            case 0:
               this.initMC0();
               break;
            case 1:
               this.initMC1();
               break;
            case 2:
               this.initMC2();
         }
      }
      
      private function initMC0() : void
      {
         this._pointList = Vector.<MovieClip>([]);
         this._pointBo = Vector.<Boolean>([false,false,false,false,false]);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._pointList.push(this._currMC["po" + _loc1_]);
            _loc1_++;
         }
         LayerManager.topLayer.addEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         LayerManager.topLayer.addEventListener(MouseEvent.MOUSE_UP,this.onUp);
      }
      
      private function onDown(param1:MouseEvent) : void
      {
         LayerManager.topLayer.addEventListener(Event.ENTER_FRAME,this.onMove);
         this._startPoint = new Point(this._currMC.mouseX,this._currMC.mouseY);
         this._isDown = true;
         this._sp = new Sprite();
         this._currMC.addChild(this._sp);
         this._sp.graphics.lineStyle(3,52224);
         this._sp.graphics.moveTo(this._currMC.mouseX,this._currMC.mouseY);
      }
      
      private function onUp(param1:MouseEvent) : void
      {
         LayerManager.topLayer.removeEventListener(Event.ENTER_FRAME,this.onMove);
         this._isDown = false;
         this._sp.graphics.endFill();
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            if(this._pointList[_loc3_].hitTestObject(this._sp))
            {
               _loc2_++;
            }
            _loc3_++;
         }
         if(_loc2_ >= 5)
         {
            this.win0();
         }
         this._pointBo = Vector.<Boolean>([false,false,false,false,false]);
         DisplayUtil.removeForParent(this._sp);
      }
      
      private function onMove(param1:Event) : void
      {
         if(this._isDown)
         {
            this._sp.graphics.lineTo(this._currMC.mouseX,this._currMC.mouseY);
         }
      }
      
      private function win0() : void
      {
         LayerManager.topLayer.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         LayerManager.topLayer.removeEventListener(MouseEvent.MOUSE_UP,this.onUp);
         LayerManager.topLayer.removeEventListener(Event.ENTER_FRAME,this.onMove);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.completeStep(10130,8);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(param1.stepId == 8)
         {
            this._mcList[0].visible = false;
            this._currMC = this._mcList[1];
            this._currMC.visible = true;
            this.initMC1();
         }
         if(param1.stepId == 9)
         {
            this._mcList[1].visible = false;
            this._currMC = this._mcList[2];
            this._currMC.visible = true;
            this.initMC2();
         }
      }
      
      private function initMC1() : void
      {
         this._coinsList = Vector.<MovieClip>([]);
         this._conisBo = Vector.<Boolean>([false,false,false,false,false]);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._coinsList.push(this._currMC["coins" + _loc1_]);
            this._coinsList[_loc1_].gotoAndStop(1);
            this._coinsList[_loc1_].buttonMode = true;
            this._coinsList[_loc1_].addEventListener(MouseEvent.CLICK,this.onCoins);
            _loc1_++;
         }
      }
      
      private function onCoins(param1:MouseEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:int = this._coinsList.indexOf(param1.currentTarget as MovieClip);
         this._coinsList[_loc2_].gotoAndStop(2);
         this._conisBo[_loc2_] = true;
         var _loc3_:uint = 0;
         for each(_loc4_ in this._conisBo)
         {
            if(_loc4_)
            {
               _loc3_++;
            }
         }
         if(_loc3_ >= 5)
         {
            this.win1();
         }
      }
      
      private function win1() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.completeStep(10130,9);
      }
      
      private function initMC2() : void
      {
         this._penIndex = 0;
         this._titleIndex = 0;
         this._contentIndex = 0;
         this._colorList = Vector.<SimpleButton>([]);
         this._pen = this._currMC["pen"];
         this._pen.gotoAndStop(1);
         this._pen.mouseChildren = false;
         this._pen.mouseEnabled = false;
         this._title = this._currMC["title"];
         this._title.gotoAndStop(1);
         this._title.addEventListener(MouseEvent.CLICK,this.onTitle);
         this._content = this._currMC["content"];
         this._content.gotoAndStop(1);
         this._content.addEventListener(MouseEvent.CLICK,this.onContent);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._colorList.push(this._currMC["color" + _loc1_]);
            this._colorList[_loc1_].addEventListener(MouseEvent.CLICK,this.onColor);
            _loc1_++;
         }
      }
      
      private function onTitle(param1:MouseEvent) : void
      {
         this._title.gotoAndStop(this._penIndex + 2);
         this._titleIndex = this._penIndex + 2;
         if(this._titleIndex == 2 && this._contentIndex == 4)
         {
            this.win3();
         }
      }
      
      private function onContent(param1:MouseEvent) : void
      {
         this._content.gotoAndStop(this._penIndex + 2);
         this._contentIndex = this._penIndex + 2;
         if(this._titleIndex == 2 && this._contentIndex == 4)
         {
            this.win3();
         }
      }
      
      private function onColor(param1:MouseEvent) : void
      {
         var _loc2_:int = this._colorList.indexOf(param1.currentTarget as SimpleButton);
         this._penIndex = _loc2_;
         this._pen.gotoAndStop(_loc2_ + 1);
      }
      
      private function win3() : void
      {
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.completeStep(10130,10);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         this._fun();
      }
      
      public function dispose(param1:MouseEvent) : void
      {
         LayerManager.topLayer.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         LayerManager.topLayer.removeEventListener(MouseEvent.MOUSE_UP,this.onUp);
         LayerManager.topLayer.removeEventListener(Event.ENTER_FRAME,this.onMove);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc);
      }
   }
}
