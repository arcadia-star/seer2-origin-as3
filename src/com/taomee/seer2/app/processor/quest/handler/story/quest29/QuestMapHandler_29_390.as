package com.taomee.seer2.app.processor.quest.handler.story.quest29
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_29_390 extends QuestMapHandler
   {
      
      private static const NPC_BOSS_1:uint = 8;
       
      
      private var _diNpc:MovieClip;
      
      private var _xianZhiNpc:MovieClip;
      
      private var _shaNpc:MovieClip;
      
      private var _tinaNpc:MovieClip;
      
      private var _aXiuNpc:MovieClip;
      
      private var _sNpc:MovieClip;
      
      private var _surpriseMark:MovieClip;
      
      private var _askMark:MovieClip;
      
      private var _tinaIn:MovieClip;
      
      public function QuestMapHandler_29_390(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id) && QuestManager.isAccepted(_quest.id) == false)
         {
            this.createNpc_0();
            this.addSurpriseMark(this._diNpc);
            this._diNpc.addEventListener(MouseEvent.CLICK,this.onAcceptClick);
         }
         else if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.createNpc_0();
            this.addAskMark(this._diNpc);
            this._diNpc.addEventListener(MouseEvent.CLICK,this.onNpcClick_0_1);
         }
         else if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.createNpc_2();
            this.processorStep2();
         }
      }
      
      private function processorStep2() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == NPC_BOSS_1 && FightManager.fightWinnerSide == FightSide.LEFT)
         {
            _quest.setStepData(2,0,1);
            QuestManager.setStepBufferServer(_quest.id,2);
            this._diNpc.addEventListener(MouseEvent.CLICK,this.onShowDialog_2_1);
            this.showDialog_2_1();
         }
         else if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == NPC_BOSS_1 && FightManager.fightWinnerSide == FightSide.RIGHT)
         {
            this._shaNpc.addEventListener(MouseEvent.CLICK,this.onShowFailDialog_2_0);
            this.showFailDialog_2_0();
         }
         else if(_quest.getStepData(2,0) == 0)
         {
            this.addAskMark(this._shaNpc);
            this._shaNpc.addEventListener(MouseEvent.CLICK,this.onShowDialog_2_0);
         }
         else if(_quest.getStepData(2,0) == 1)
         {
            this.addAskMark(this._diNpc);
            this._diNpc.addEventListener(MouseEvent.CLICK,this.onShowDialog_2_1);
         }
         else if(_quest.getStepData(2,0) == 2)
         {
            this.createNpc_2_2();
            this.addAskMark(this._tinaNpc);
            this._tinaNpc.addEventListener(MouseEvent.CLICK,this.onShowDialog_2_2);
         }
         else if(_quest.getStepData(2,0) == 3)
         {
            this.clearXianZhiNpc();
            this.createNpc_2_2();
            this.createNpc_2_3();
            this.addAskMark(this._diNpc);
            this._diNpc.addEventListener(MouseEvent.CLICK,this.onShowDialog_2_3);
         }
      }
      
      private function onShowDialog_2_0(param1:MouseEvent) : void
      {
         this.clearAskMark();
         this._shaNpc.removeEventListener(MouseEvent.CLICK,this.onShowDialog_2_0);
         this.showDialog_2_0();
      }
      
      private function showDialog_2_0() : void
      {
         NpcDialog.show(56,"神爪财团老板",[[3,"如你所愿……我们决斗吧！！！"]],["等一下……既然大家都到了！！"],[function():void
         {
            FightManager.addEventListener(FightStartEvent.START_ERROR,onStartFightError_2_0);
            FightManager.addEventListener(FightStartEvent.START_SUCCESS,onStartFight_2_0);
            FightManager.startFightWithNPC(NPC_BOSS_1);
         }]);
      }
      
      private function onStartFight_2_0(param1:FightStartEvent) : void
      {
         FightManager.removeEventListener(FightStartEvent.START_ERROR,this.onStartFightError_2_0);
         FightManager.removeEventListener(FightStartEvent.START_SUCCESS,this.onStartFight_2_0);
      }
      
      private function onStartFightError_2_0(param1:FightStartEvent) : void
      {
         FightManager.removeEventListener(FightStartEvent.START_ERROR,this.onStartFightError_2_0);
         FightManager.removeEventListener(FightStartEvent.START_SUCCESS,this.onStartFight_2_0);
         this.addAskMark(this._shaNpc);
         this._shaNpc.addEventListener(MouseEvent.CLICK,this.onShowDialog_2_0);
      }
      
      private function onShowFailDialog_2_0(param1:MouseEvent) : void
      {
         this.clearAskMark();
         this._shaNpc.removeEventListener(MouseEvent.CLICK,this.onShowFailDialog_2_0);
         this.showFailDialog_2_0();
      }
      
      private function showFailDialog_2_0() : void
      {
         NpcDialog.show(56,"神爪财团老板",[[3,"还没有结束……！！"]],["T．T停手吧……"],[function():void
         {
            FightManager.addEventListener(FightStartEvent.START_ERROR,onStartFightError_2_1);
            FightManager.addEventListener(FightStartEvent.START_SUCCESS,onStartFight_2_1);
            FightManager.startFightWithNPC(NPC_BOSS_1);
         }]);
      }
      
      private function onStartFight_2_1(param1:FightStartEvent) : void
      {
         FightManager.removeEventListener(FightStartEvent.START_ERROR,this.onStartFightError_2_1);
         FightManager.removeEventListener(FightStartEvent.START_SUCCESS,this.onStartFight_2_1);
      }
      
      private function onStartFightError_2_1(param1:FightStartEvent) : void
      {
         FightManager.removeEventListener(FightStartEvent.START_ERROR,this.onStartFightError_2_1);
         FightManager.removeEventListener(FightStartEvent.START_SUCCESS,this.onStartFight_2_1);
         this.addAskMark(this._shaNpc);
         this._shaNpc.addEventListener(MouseEvent.CLICK,this.onShowFailDialog_2_0);
      }
      
      private function onShowDialog_2_1(param1:MouseEvent) : void
      {
         this.clearAskMark();
         this._diNpc.removeEventListener(MouseEvent.CLICK,this.onShowDialog_2_1);
         this.showDialog_2_1();
      }
      
      private function showDialog_2_1() : void
      {
         NpcDialog.show(55,"神月老大",[[3,"真看不出来，每天唠叨着风度的大老板不过也是个不打招呼就开打的粗人而已！！洒家甚至比你更有风度，还特地派出使者！"]],["不是你先动手的嘛！"],[function():void
         {
            NpcDialog.show(57,"先知",[[1,"呵呵呵……看来那一招很管用……继续……继续争斗……然后，毁灭吧……！"]],["难道刚才袭击大老板的是你？！"],[function():void
            {
               _quest.setStepData(2,0,2);
               QuestManager.setStepBufferServer(_quest.id,2);
               _tinaIn = _processor.resLib.getMovieClip("mc_2_0");
               _map.front.addChild(_tinaIn);
               MovieClipUtil.playMc(_tinaIn,1,_tinaIn.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(_tinaIn);
                  _tinaIn = null;
                  createNpc_2_2();
                  _tinaNpc.addEventListener(MouseEvent.CLICK,onShowDialog_2_2);
                  showDialog_2_2();
               },true);
            }]);
         }]);
      }
      
      private function onShowDialog_2_2(param1:MouseEvent) : void
      {
         this.clearAskMark();
         this._tinaNpc.removeEventListener(MouseEvent.CLICK,this.onShowDialog_2_2);
         this.showDialog_2_2();
      }
      
      private function showDialog_2_2() : void
      {
         NpcDialog.show(39,"缇娜",[[0,"很好……呵呵呵……哈哈哈哈哈！吾等一直等待着沙地自相残杀的一天，而这一天终于到来了！！"]],["你你你你你是萨伦帝国的……！"],[function():void
         {
            NpcDialog.show(13,"阿修",[[1,"我的女王，请下达下一步指令。"]],["阿修也来了？怎么回事……"],[function():void
            {
               NpcDialog.show(57,"先知",[[1,"那么，我的使命也达成了。啊~早就想摆脱这个丑陋的外表了！"]],[" ……"],[function():void
               {
                  _quest.setStepData(2,0,3);
                  QuestManager.setStepBufferServer(_quest.id,2);
                  clearXianZhiNpc();
                  _tinaIn = _processor.resLib.getMovieClip("mc_2_1");
                  _map.front.addChild(_tinaIn);
                  MovieClipUtil.playMc(_tinaIn,1,_tinaIn.totalFrames,function():void
                  {
                     DisplayObjectUtil.removeFromParent(_tinaIn);
                     _tinaIn = null;
                     createNpc_2_3();
                     _diNpc.addEventListener(MouseEvent.CLICK,onShowDialog_2_3);
                     showDialog_2_3();
                  },true);
               }]);
            }]);
         }]);
      }
      
      private function onShowDialog_2_3(param1:MouseEvent) : void
      {
         this.clearAskMark();
         this._diNpc.removeEventListener(MouseEvent.CLICK,this.onShowDialog_2_3);
         this.showDialog_2_3();
      }
      
      private function showDialog_2_3() : void
      {
         NpcDialog.show(55,"神月老大",[[3,"先知……先知？！洒家不明白……！！"]],["你们被骗了！很久以前开始就被骗了！！！"],[function():void
         {
            NpcDialog.show(56,"神爪财团老板",[[3,"不可能……带领我们发家致富的先知……不对，先知一定被你们绑架了！对不对！！！"]],["……"],[function():void
            {
               NpcDialog.show(14,"S",[[1,"太丑陋……太愚蠢了……哈哈哈哈哈！就因为你们生来只有这样的智商，我才能成功完成任务！"]],["你们究竟有什么目的！！"],[function():void
               {
                  NpcDialog.show(39,"缇娜",[[0,"地沙二族倘若合力就会对吾等造成莫大的威胁，所以吾多年以前就委派S潜伏于此，分裂地沙二族。"]],["真是大言不惭啊！"],[function():void
                  {
                     NpcDialog.show(39,"缇娜",[[0,"住口！可惜……居然让当年那对孪生子活了下来，真是没用的东西。所幸现在还算顺利。"]],["孪生子？兰德和蒂萨特？！"],[function():void
                     {
                        NpcDialog.show(14,"S",[[1,"禁忌的孪生子……必须铲除……\n哈哈哈，对，我就是那个先知！！愚蠢的人们！！"]],["愤怒……愤怒……愤怒！！"],[function():void
                        {
                           NpcDialog.show(13,"阿修",[[1,"阻我铁骑者……坐等毁灭吧！！"]],["该怎么办……究竟该怎么办！！！"],[function():void
                           {
                              QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                              QuestManager.completeStep(_quest.id,2);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 29)
         {
            this.processMapDispose();
         }
      }
      
      private function onAcceptClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this.clearSurpriseMark();
         this._diNpc.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
         NpcDialog.show(55,"神月老大",[[0,"怎么，沙爪的财奴已经到了吗？"]],["大老板在三八跑道线（沙）"],[function():void
         {
            NpcDialog.show(55,"神月老大",[[0,"哈哈哈哈，那个畏缩的财奴，就不敢当面来吗？"]],["你们还是不要打了……"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.ACCEPT,onAccepted);
               QuestManager.accept(_quest.id);
            }]);
         }]);
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
            this._diNpc.addEventListener(MouseEvent.CLICK,this.onNpcClick_0_1);
            this.showDialog_0_1();
         }
      }
      
      private function onNpcClick_0_1(param1:MouseEvent) : void
      {
         this.clearAskMark();
         this._diNpc.removeEventListener(MouseEvent.CLICK,this.onNpcClick_0_1);
         this.showDialog_0_1();
      }
      
      private function showDialog_0_1() : void
      {
         NpcDialog.show(55,"神月老大",[[0,"洒家一言九鼎，说打就是打！！你去告诉那个财奴，洒家就在这里等他！！"]],["（去三八跑道线（沙）找神爪财团老板）"],[function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,310);
         }]);
      }
      
      private function createNpc_0() : void
      {
         this.createDiNpc();
      }
      
      private function createNpc_2() : void
      {
         this.createDiNpc();
         this.createShaNpc();
         this.createXianZhiNpc();
      }
      
      private function createNpc_2_2() : void
      {
         this.createTinaNpc();
         this.createAXiuNpc();
      }
      
      private function createNpc_2_3() : void
      {
         this.createSNpc();
      }
      
      private function createDiNpc() : void
      {
         this._diNpc = _processor.resLib.getMovieClip("npc_di");
         this._diNpc.x = 660.9;
         this._diNpc.y = 417.95;
         _map.content.addChild(this._diNpc);
         this._diNpc.buttonMode = true;
      }
      
      private function createShaNpc() : void
      {
         this._shaNpc = _processor.resLib.getMovieClip("npc_sha");
         this._shaNpc.x = 553.9;
         this._shaNpc.y = 446.6;
         _map.content.addChild(this._shaNpc);
         this._shaNpc.buttonMode = true;
      }
      
      private function createXianZhiNpc() : void
      {
         this._xianZhiNpc = _processor.resLib.getMovieClip("npc_xianZhi");
         this._xianZhiNpc.x = 566.75;
         this._xianZhiNpc.y = 369.9;
         _map.content.addChild(this._xianZhiNpc);
         this._xianZhiNpc.buttonMode = true;
      }
      
      private function createAXiuNpc() : void
      {
         this._aXiuNpc = _processor.resLib.getMovieClip("npc_aXiu");
         this._aXiuNpc.x = 436.3;
         this._aXiuNpc.y = 473.6;
         _map.content.addChild(this._aXiuNpc);
         this._aXiuNpc.buttonMode = true;
      }
      
      private function createTinaNpc() : void
      {
         this._tinaNpc = _processor.resLib.getMovieClip("npc_tina");
         this._tinaNpc.x = 697.8;
         this._tinaNpc.y = 383.95;
         _map.content.addChild(this._tinaNpc);
         this._tinaNpc.buttonMode = true;
      }
      
      private function createSNpc() : void
      {
         this._sNpc = _processor.resLib.getMovieClip("npc_s");
         this._sNpc.x = 571.8;
         this._sNpc.y = 375.9;
         _map.content.addChild(this._sNpc);
         this._sNpc.buttonMode = true;
      }
      
      private function addSurpriseMark(param1:MovieClip) : void
      {
         if(this._surpriseMark == null)
         {
            this._surpriseMark = _processor.resLib.getMovieClip("surprise");
         }
         this._surpriseMark.x = 0;
         this._surpriseMark.y = -param1.height;
         param1.addChild(this._surpriseMark);
      }
      
      private function addAskMark(param1:MovieClip) : void
      {
         if(this._askMark == null)
         {
            this._askMark = _processor.resLib.getMovieClip("ask");
         }
         this._askMark.x = 0;
         this._askMark.y = -param1.height;
         param1.addChild(this._askMark);
      }
      
      private function clearDiNpc() : void
      {
         if(this._diNpc)
         {
            this._diNpc.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
            this._diNpc.removeEventListener(MouseEvent.CLICK,this.onNpcClick_0_1);
            this._diNpc.removeEventListener(MouseEvent.CLICK,this.onShowDialog_2_1);
            this._diNpc.removeEventListener(MouseEvent.CLICK,this.onShowDialog_2_3);
            DisplayObjectUtil.removeFromParent(this._diNpc);
            this._diNpc = null;
         }
      }
      
      private function clearShaNpc() : void
      {
         if(this._shaNpc)
         {
            this._shaNpc.removeEventListener(MouseEvent.CLICK,this.onShowFailDialog_2_0);
            this._shaNpc.removeEventListener(MouseEvent.CLICK,this.onShowDialog_2_0);
            DisplayObjectUtil.removeFromParent(this._shaNpc);
            this._shaNpc = null;
         }
      }
      
      private function clearXianZhiNpc() : void
      {
         if(this._xianZhiNpc)
         {
            DisplayObjectUtil.removeFromParent(this._xianZhiNpc);
            this._xianZhiNpc = null;
         }
      }
      
      private function clearSNpc() : void
      {
         if(this._sNpc)
         {
            DisplayObjectUtil.removeFromParent(this._sNpc);
            this._sNpc = null;
         }
      }
      
      private function clearTinaNpc() : void
      {
         if(this._tinaNpc)
         {
            this._tinaNpc.removeEventListener(MouseEvent.CLICK,this.onShowDialog_2_2);
            DisplayObjectUtil.removeFromParent(this._tinaNpc);
            this._tinaNpc = null;
         }
      }
      
      private function clearAXiuNpc() : void
      {
         if(this._aXiuNpc)
         {
            DisplayObjectUtil.removeFromParent(this._aXiuNpc);
            this._aXiuNpc = null;
         }
      }
      
      private function clearSurpriseMark() : void
      {
         if(this._surpriseMark)
         {
            DisplayObjectUtil.removeFromParent(this._surpriseMark);
            this._surpriseMark = null;
         }
      }
      
      private function clearAskMark() : void
      {
         if(this._askMark)
         {
            DisplayObjectUtil.removeFromParent(this._askMark);
            this._askMark = null;
         }
      }
      
      private function clearTinaIn() : void
      {
         if(this._tinaIn)
         {
            DisplayObjectUtil.removeFromParent(this._tinaIn);
            this._tinaIn = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.clearTinaIn();
         this.clearSurpriseMark();
         this.clearAskMark();
         this.clearDiNpc();
         this.clearXianZhiNpc();
         this.clearShaNpc();
         this.clearAXiuNpc();
         this.clearSNpc();
         this.clearTinaNpc();
         FightManager.removeEventListener(FightStartEvent.START_ERROR,this.onStartFightError_2_1);
         FightManager.removeEventListener(FightStartEvent.START_SUCCESS,this.onStartFight_2_1);
         FightManager.removeEventListener(FightStartEvent.START_ERROR,this.onStartFightError_2_0);
         FightManager.removeEventListener(FightStartEvent.START_SUCCESS,this.onStartFight_2_0);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         super.processMapDispose();
      }
   }
}
