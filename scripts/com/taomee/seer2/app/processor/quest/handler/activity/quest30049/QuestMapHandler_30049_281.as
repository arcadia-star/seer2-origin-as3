package com.taomee.seer2.app.processor.quest.handler.activity.quest30049
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.controls.MapTitlePanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import org.taomee.filter.ColorFilter;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30049_281 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _ballList:Vector.<MovieClip>;
      
      private var _currIndex:int;
      
      private var pointList:Vector.<Point>;
      
      private var titleList:Vector.<int>;
      
      private var _alert:MovieClip;
      
      private var _switchList:Vector.<MovieClip>;
      
      private var _title:MovieClip;
      
      private var _setTimeOut:uint;
      
      public function QuestMapHandler_30049_281(param1:QuestProcessor)
      {
         this.pointList = Vector.<Point>([new Point(332,415),new Point(431,335),new Point(582,413)]);
         this.titleList = Vector.<int>([0,2,0]);
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(30049))
         {
            this.openNpc();
         }
         else if(QuestManager.isAccepted(30049) && QuestManager.isStepComplete(30049,1) == false)
         {
            this.startQuest1();
         }
      }
      
      private function openNpc() : void
      {
         this._npc = _processor.resLib.getMovieClip("npc");
         _map.content.addChild(this._npc);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30049_1"),function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"她是怎么了，一句话也不说，只是紧紧的抱着手中的玩具。"]],["……"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[0,"她原本是一个有着丰富情感的精灵，可是，现在不知道怎么变成了一只没有任何情感波动的精灵。"]],["要不去问问博士看"],[function():void
               {
                  _mc1 = _processor.resLib.getMovieClip("mc1");
                  _map.front.addChild(_mc1);
                  MovieClipUtil.playMc(_mc1,2,_mc1.totalFrames,function():void
                  {
                     _mc2 = _processor.resLib.getMovieClip("mc2");
                     _map.front.addChild(_mc2);
                     MovieClipUtil.playMc(_mc2,2,_mc2.totalFrames,function():void
                     {
                        DisplayUtil.removeForParent(_mc1);
                        DisplayUtil.removeForParent(_mc2);
                        QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                        QuestManager.accept(30049);
                     },true);
                  },true);
               }]);
            }]);
         },true,false,2);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         this.startQuest1();
      }
      
      private function startQuest1() : void
      {
         if(this._npc == null)
         {
            this._npc = _processor.resLib.getMovieClip("npc");
         }
         if(this._npc.parent == null)
         {
            _map.content.addChild(this._npc);
         }
         _processor.showMouseHintAt(543,269);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onShiguang);
      }
      
      private function onShiguang(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"我们开始吧，万能的时光穿梭机！"]],["（拿出时光穿梭机）"],[function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30049_2"),function():void
            {
               openTime();
            },true,false,2);
         }]);
      }
      
      private function openTime() : void
      {
         _processor.hideMouseClickHint();
         this._npc.removeEventListener(MouseEvent.CLICK,this.onShiguang);
         DisplayUtil.removeForParent(this._npc);
         LayerManager.uiLayer.visible = false;
         ActorManager.getActor().x = 367;
         ActorManager.getActor().y = 552;
         MonsterManager.hideAllMonster();
         MapTitlePanel.hide();
         ActorManager.showRemoteActor = false;
         ColorFilter.setGrayscale(LayerManager.mapLayer);
         this._mc3 = _processor.resLib.getMovieClip("mc3");
         _map.front.addChild(this._mc3);
         MovieClipUtil.playMc(this._mc3,2,this._mc3.totalFrames,function():void
         {
            var _loc1_:int = 0;
            DisplayUtil.removeForParent(_mc3);
            _ballList = Vector.<MovieClip>([]);
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               _ballList.push(_processor.resLib.getMovieClip("ball" + _loc1_));
               _ballList[_loc1_].mouseChildren = false;
               _ballList[_loc1_].mouseEnabled = false;
               _map.content.addChild(_ballList[_loc1_]);
               _loc1_++;
            }
            _currIndex = 0;
            openBall();
         },true);
      }
      
      private function openBall() : void
      {
         _processor.showMouseHintAt(this.pointList[this._currIndex].x,this.pointList[this._currIndex].y);
         ActorManager.getActor().addEventListener(MoveEvent.MOVE,this.onMove);
      }
      
      private function onMove(param1:MoveEvent) : void
      {
         var _loc2_:MovieClip = this._ballList[this._currIndex];
         if(ActorManager.getActor().hitTestObject(_loc2_["mc"]))
         {
            _processor.hideMouseClickHint();
            ActorManager.getActor().removeEventListener(MoveEvent.MOVE,this.onMove);
            this.showAlert();
         }
      }
      
      private function showAlert() : void
      {
         this._alert = _processor.resLib.getMovieClip("questAlert");
         LayerManager.topLayer.addChild(this._alert);
         DisplayUtil.align(this._alert,4,LayerManager.rootRect);
         this._switchList = Vector.<MovieClip>([]);
         this._title = this._alert["title"];
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._switchList.push(this._alert["switch" + _loc1_]);
            this._switchList[_loc1_].gotoAndStop(1);
            this._switchList[_loc1_].addEventListener(MouseEvent.CLICK,this.onSwitch);
            _loc1_++;
         }
         this._title.gotoAndStop(this._currIndex + 1);
      }
      
      private function onSwitch(param1:MouseEvent) : void
      {
         var switchMC:MovieClip = null;
         var mc:MovieClip = null;
         var index:int = 0;
         var yesTitle:int = 0;
         var event:MouseEvent = param1;
         for each(switchMC in this._switchList)
         {
            switchMC.removeEventListener(MouseEvent.CLICK,this.onSwitch);
         }
         mc = event.currentTarget as MovieClip;
         index = this._switchList.indexOf(mc);
         mc.gotoAndStop(2);
         yesTitle = this.titleList[this._currIndex];
         this._setTimeOut = setTimeout(function():void
         {
            hideAlert();
            if(yesTitle == index)
            {
               if(_currIndex == 2)
               {
                  titleWin();
               }
               else
               {
                  titleYes();
               }
            }
            else
            {
               titleNo();
            }
         },1500);
      }
      
      private function titleWin() : void
      {
         AlertManager.showAlert("恭喜你！你很了解晨璨，5年前的故事就到此结束。",function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30049_3"),function():void
            {
               QuestManager.completeStep(30049,1);
               QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestComplete);
            },true,false,2);
         });
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         this.removeAll();
      }
      
      private function removeAll() : void
      {
         this.hideTime();
         this.hideAlert();
         if(_processor)
         {
            _processor.hideMouseClickHint();
         }
         ActorManager.getActor().removeEventListener(MoveEvent.MOVE,this.onMove);
         DisplayUtil.removeForParent(this._npc);
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mc2);
         DisplayUtil.removeForParent(this._mc3);
      }
      
      private function titleYes() : void
      {
         AlertManager.showAlert("恭喜你！答对了，继续前进吧！",function():void
         {
            ++_currIndex;
            openBall();
         });
      }
      
      private function titleNo() : void
      {
         AlertManager.showAlert("对不起，你回答错误，导致时空错乱，需要返回到现实世界，重新开始！",function():void
         {
            hideTime();
            startQuest1();
         });
      }
      
      private function hideTime() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._ballList)
         {
            DisplayUtil.removeForParent(_loc1_);
         }
         MonsterManager.showAllMonster();
         LayerManager.uiLayer.visible = true;
         MapTitlePanel.show();
         ActorManager.showRemoteActor = true;
         LayerManager.mapLayer.filters = [];
      }
      
      private function hideAlert() : void
      {
         this._title = null;
         DisplayUtil.removeForParent(this._alert);
         this._alert = null;
      }
      
      override public function processMapDispose() : void
      {
         this.removeAll();
         this._npc = null;
         this._mc1 = null;
         this._mc2 = null;
         this._mc3 = null;
         super.processMapDispose();
      }
   }
}
