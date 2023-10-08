package com.taomee.seer2.app.processor.quest.handler.branch.quest10128
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.utils.Timer;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10128_213 extends QuestMapHandler
   {
       
      
      private var _cookContent:MovieClip;
      
      private var _bottle:MovieClip;
      
      private var _dragMcVec:Vector.<MovieClip>;
      
      private var _dragPosVec:Vector.<Point>;
      
      private var _dragIndex:int;
      
      private var _dragMc:MovieClip;
      
      private var _dragTimer:Timer;
      
      private var _hotArea:MovieClip;
      
      private var _stopHotAreaOut:Boolean;
      
      private var _handMc:MovieClip;
      
      private var _xuanzhuanMc:MovieClip;
      
      private var _isDrawing:Boolean;
      
      private var _interactRect:Rectangle;
      
      private var _matchAreaArr:Array;
      
      private var _matchResultArr:Array;
      
      public function QuestMapHandler_10128_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStart);
         }
      }
      
      private function onStart(param1:DialogPanelEvent) : void
      {
         this.playGame();
      }
      
      private function playGame() : void
      {
         this._interactRect = new Rectangle(298,175,364,198);
         this._dragTimer = new Timer(500);
         this._dragTimer.addEventListener(TimerEvent.TIMER,this.onTimer);
         MovieClipUtil.getSwfContent(URLUtil.getQuestAnimation("9/cook"),function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            _cookContent = mc;
            MovieClipUtil.getChildList(mc,2,["bottle","water","chilli","pepper","salt","spoon","hand","xuanzhuan","hotArea","areaHolder"],function(param1:Vector.<DisplayObject>):void
            {
               var _loc4_:MovieClip = null;
               LayerManager.topLayer.addChild(_cookContent);
               LayerManager.focusOnTopLayer();
               _bottle = param1[0] as MovieClip;
               _bottle.gotoAndStop(1);
               _dragMcVec = new Vector.<MovieClip>();
               _dragPosVec = new Vector.<Point>();
               var _loc2_:int = 1;
               while(_loc2_ < 6)
               {
                  (_loc4_ = param1[_loc2_] as MovieClip).gotoAndStop(1);
                  _loc4_.visible = false;
                  _dragMcVec.push(_loc4_);
                  _dragPosVec.push(new Point(_loc4_.x,_loc4_.y));
                  _loc2_++;
               }
               _dragIndex = 0;
               updateDragMc();
               _handMc = param1[6] as MovieClip;
               _handMc.visible = false;
               _handMc.mouseEnabled = false;
               _handMc.mouseChildren = false;
               _xuanzhuanMc = param1[7] as MovieClip;
               _xuanzhuanMc.mouseEnabled = false;
               _xuanzhuanMc.mouseChildren = false;
               _xuanzhuanMc.visible = false;
               _hotArea = param1[8] as MovieClip;
               _hotArea.addEventListener(MouseEvent.MOUSE_OUT,onHotAreaOut);
               _hotArea.addEventListener(MouseEvent.MOUSE_DOWN,onHotAreaDown);
               _hotArea.addEventListener(MouseEvent.MOUSE_UP,onHotAreaUp);
               _hotArea.addEventListener(MouseEvent.MOUSE_MOVE,onHotAreaMove);
               _hotArea.addEventListener(MouseEvent.CLICK,onHotAreaClick);
               DisplayObjectUtil.disableSprite(_hotArea);
               var _loc3_:MovieClip = param1[9] as MovieClip;
               _loc3_.mouseEnabled = false;
               _loc3_.mouseChildren = false;
               _matchAreaArr = [];
               _loc2_ = 0;
               while(_loc2_ < 10)
               {
                  _matchAreaArr.push(DisplayObject(_loc3_["area" + _loc2_]).getBounds(LayerManager.stage));
                  _loc2_++;
               }
            });
         });
      }
      
      private function updateDragMc() : void
      {
         Mouse.show();
         this._dragMc = this._dragMcVec[this._dragIndex];
         this._dragMc.x = this._dragPosVec[this._dragIndex].x;
         this._dragMc.y = this._dragPosVec[this._dragIndex].y;
         this._dragMc.visible = true;
         this._dragMc.addEventListener(MouseEvent.ROLL_OVER,this.onDragMcOver);
         this._dragMc.addEventListener(MouseEvent.ROLL_OUT,this.onDragMcOut);
         this._dragMc.addEventListener(MouseEvent.CLICK,this.onDragMcClick);
         this._isDrawing = false;
      }
      
      private function onDragMcOver(param1:MouseEvent) : void
      {
         Mouse.hide();
         this._handMc.visible = true;
         this._handMc.startDrag(true);
      }
      
      private function onDragMcOut(param1:MouseEvent) : void
      {
         Mouse.show();
         this._handMc.visible = false;
         this._handMc.stopDrag();
      }
      
      private function onDragMcClick(param1:MouseEvent) : void
      {
         this._handMc.visible = false;
         this._dragMc.startDrag(true,new Rectangle(172,81,608,311));
         this._dragMc.removeEventListener(MouseEvent.ROLL_OVER,this.onDragMcOver);
         this._dragMc.removeEventListener(MouseEvent.ROLL_OUT,this.onDragMcOut);
         this._dragMc.removeEventListener(MouseEvent.CLICK,this.onDragMcClick);
         DisplayObjectUtil.enableSprite(this._hotArea);
         this._stopHotAreaOut = false;
      }
      
      private function onHotAreaOut(param1:MouseEvent) : void
      {
         if(this._stopHotAreaOut)
         {
            return;
         }
         if(this._isDrawing)
         {
            this._hotArea.graphics.clear();
         }
         this._dragMc.stopDrag();
         this.updateDragMc();
         DisplayObjectUtil.disableSprite(this._hotArea);
      }
      
      private function onHotAreaMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         Mouse.hide();
         if(this._isDrawing)
         {
            this._hotArea.graphics.lineTo(param1.localX,param1.localY);
            _loc2_ = 0;
            while(_loc2_ < this._matchAreaArr.length)
            {
               if(Rectangle(this._matchAreaArr[_loc2_]).contains(param1.stageX,param1.stageY))
               {
                  this._matchResultArr[_loc2_] = true;
               }
               _loc2_++;
            }
         }
      }
      
      private function onHotAreaDown(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this._dragIndex == this._dragMcVec.length - 1)
         {
            this._isDrawing = true;
            this._hotArea.graphics.lineStyle(10,16711680);
            this._hotArea.graphics.moveTo(param1.localX,param1.localY);
            this._matchResultArr = [];
            _loc2_ = 0;
            while(_loc2_ < 9)
            {
               this._matchResultArr.push(false);
               _loc2_++;
            }
         }
      }
      
      private function onHotAreaUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._isDrawing)
         {
            this._isDrawing = false;
            this._hotArea.graphics.clear();
            this._dragMc.stopDrag();
            this.updateDragMc();
            DisplayObjectUtil.disableSprite(this._hotArea);
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < this._matchResultArr.length)
            {
               if(this._matchResultArr[_loc3_])
               {
                  _loc2_++;
               }
               _loc3_++;
            }
            if(_loc2_ >= 7)
            {
               this.closeCook(true);
            }
         }
      }
      
      private function onHotAreaClick(param1:MouseEvent) : void
      {
         if(this._dragIndex <= this._dragMcVec.length - 1 && this._interactRect.intersects(this._dragMc.getBounds(this._dragMc.stage)))
         {
            DisplayObjectUtil.disableSprite(this._hotArea);
            this._dragTimer.start();
            this._dragMc.stopDrag();
            this._dragMc.visible = false;
            this._stopHotAreaOut = true;
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var evt:TimerEvent = param1;
         this._dragTimer.stop();
         this._dragMc.x = this._dragPosVec[this._dragIndex].x;
         this._dragMc.y = this._dragPosVec[this._dragIndex].y;
         this._dragMc.visible = true;
         MovieClipUtil.getChildList(this._dragMc,2,[0],function(param1:Vector.<DisplayObject>):void
         {
            var children:Vector.<DisplayObject> = param1;
            var mc:MovieClip = children[0] as MovieClip;
            MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
            {
               if(_dragIndex <= 1)
               {
                  _bottle.gotoAndStop(_dragIndex + 2);
               }
               else if(_dragIndex == _dragMcVec.length - 2)
               {
                  _xuanzhuanMc.visible = true;
               }
               ++_dragIndex;
               if(_dragIndex == _dragMcVec.length)
               {
                  closeCook(true);
               }
               else
               {
                  _dragMc.visible = false;
                  updateDragMc();
               }
            });
         });
      }
      
      private function closeCook(param1:Boolean) : void
      {
         var popo:MovieClip = null;
         var isSuccess:Boolean = param1;
         this._dragTimer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this._dragTimer.stop();
         if(this._hotArea != null)
         {
            this._hotArea.removeEventListener(MouseEvent.MOUSE_OUT,this.onHotAreaOut);
            this._hotArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.onHotAreaDown);
            this._hotArea.removeEventListener(MouseEvent.MOUSE_UP,this.onHotAreaUp);
            this._hotArea.removeEventListener(MouseEvent.MOUSE_MOVE,this.onHotAreaMove);
            this._hotArea.removeEventListener(MouseEvent.CLICK,this.onHotAreaClick);
         }
         if(this._dragMc != null)
         {
            this._dragMc.removeEventListener(MouseEvent.ROLL_OVER,this.onDragMcOver);
            this._dragMc.removeEventListener(MouseEvent.ROLL_OUT,this.onDragMcOut);
            this._dragMc.removeEventListener(MouseEvent.CLICK,this.onDragMcClick);
         }
         DisplayObjectUtil.removeFromParent(this._cookContent);
         LayerManager.resetOperation();
         if(isSuccess)
         {
            MobileManager.getMobile(27,MobileType.NPC).visible = false;
            popo = _processor.resLib.getMovieClip("popo");
            _map.content.addChild(popo);
            MovieClipUtil.playMc(popo,1,popo.totalFrames,function():void
            {
               DisplayUtil.removeForParent(popo);
               MobileManager.getMobile(27,MobileType.NPC).visible = true;
               NpcDialog.show(27,"占卜婆婆",[[0,"哦。不错哦不错哦。耳朵凑过来，记住我这句咒语：西拉金拉泰拉哈皮拉薇拉吉。"]],["西拉金拉泰拉哈皮拉薇拉吉……我这就去给祭司！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1CompleteHandler);
                  QuestManager.completeStep(_quest.id,1);
               }]);
            },true);
         }
      }
      
      private function onStep1CompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1CompleteHandler);
         SceneManager.changeScene(SceneType.LOBBY,160);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStart);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1CompleteHandler);
      }
   }
}
