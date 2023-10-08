package com.taomee.seer2.app.processor.quest.handler.branch.quest10145
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10145_10108 extends QuestMapHandler
   {
       
      
      private var _npcOldMan:MovieClip;
      
      private var _npcLv:MovieClip;
      
      private var _npcCounter:MovieClip;
      
      private var _npcBadi:MovieClip;
      
      private var _npcDuoluo:MovieClip;
      
      private var _npcBear:MovieClip;
      
      private const POS:Array = [[227,205],[300,225],[100,100],[264,342],[335,342]];
      
      private const POS1:Array = [[227,205],[264,342],[335,342],[522,181]];
      
      public function QuestMapHandler_10145_10108(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isComplete(10144))
         {
            if(QuestManager.isCanAccepted(_quest.id))
            {
               this.addNpcRes1();
            }
            else if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
            {
               this.addNpcRes2();
            }
            else if(QuestManager.isStepComplete(_quest.id,4) && !QuestManager.isStepComplete(_quest.id,5))
            {
               this.addNpcRes3();
            }
            else if(QuestManager.isStepComplete(_quest.id,5) && !QuestManager.isComplete(_quest.id))
            {
               this.addNpcRes4();
            }
         }
      }
      
      private function addNpcRes1() : void
      {
         this._npcOldMan = _processor.resLib.getMovieClip("npc_1");
         this._npcLv = _processor.resLib.getMovieClip("npc_2");
         this._npcOldMan.x = this.POS[0][0];
         this._npcOldMan.y = this.POS[0][1];
         this._npcLv.x = this.POS[1][0];
         this._npcLv.y = this.POS[1][1];
         _map.content.addChild(this._npcLv);
         _map.content.addChild(this._npcOldMan);
         this._npcLv["mark"].visible = false;
         this._npcOldMan["mark"].visible = true;
         this._npcOldMan.buttonMode = true;
         this._npcOldMan.addEventListener(MouseEvent.CLICK,this.onOldManClick);
      }
      
      private function addNpcRes2() : void
      {
         this._npcBadi = _processor.resLib.getMovieClip("npc_4");
         this._npcBadi.x = this.POS[3][0];
         this._npcBadi.y = this.POS[3][1];
         this._npcBadi["mark"].visible = true;
         this._npcDuoluo = _processor.resLib.getMovieClip("npc_5");
         this._npcDuoluo.x = this.POS[4][0];
         this._npcDuoluo.y = this.POS[4][1];
         this._npcDuoluo["mark"].visible = false;
         _map.content.addChild(this._npcBadi);
         _map.content.addChild(this._npcDuoluo);
         this._npcBadi.buttonMode = true;
         this._npcBadi.addEventListener(MouseEvent.CLICK,this.onBadiClick);
      }
      
      private function addNpcRes3() : void
      {
         this.desolveRes();
         this._npcOldMan = _processor.resLib.getMovieClip("npc_1");
         this._npcBadi = _processor.resLib.getMovieClip("npc_4");
         this._npcDuoluo = _processor.resLib.getMovieClip("npc_5");
         this._npcBear = _processor.resLib.getMovieClip("npc_6");
         this._npcOldMan.x = this.POS1[0][0];
         this._npcOldMan.y = this.POS1[0][1];
         this._npcBadi.x = this.POS1[1][0];
         this._npcBadi.y = this.POS1[1][1];
         this._npcDuoluo.x = this.POS1[2][0];
         this._npcDuoluo.y = this.POS1[2][1];
         this._npcBear.x = this.POS1[3][0];
         this._npcBear.y = this.POS1[3][1];
         _map.content.addChild(this._npcOldMan);
         _map.content.addChild(this._npcBadi);
         _map.content.addChild(this._npcDuoluo);
         _map.content.addChild(this._npcBear);
         this._npcBadi["mark"].visible = this._npcDuoluo["mark"].visible = this._npcBear["mark"].visible = false;
         this._npcOldMan["mark"].visible = true;
         this._npcOldMan.buttonMode = true;
         this._npcOldMan.addEventListener(MouseEvent.CLICK,this.onOldManClick1);
      }
      
      private function onOldManClick1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npcOldMan.removeEventListener(MouseEvent.CLICK,this.onOldManClick1);
         NpcDialog.show(180,"圣诞老人",[[1,"巴蒂早就把东西收集到了，快把你们的东西给我吧！"]],["好！"],[function():void
         {
            NpcDialog.show(180,"圣诞老人",[[1,"我要用这些东西制作一个装着繁星的水晶球！"]],["哦？！"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10145_3"),function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepFiveComplete);
                  QuestManager.completeStep(_quest.id,5);
               },true,false,2);
            }]);
         }]);
      }
      
      private function onStepFiveComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepFiveComplete);
         this.addNpcRes4();
      }
      
      private function addNpcRes4() : void
      {
         this.desolveRes();
         this._npcOldMan = _processor.resLib.getMovieClip("npc_1");
         this._npcBadi = _processor.resLib.getMovieClip("npc_4");
         this._npcDuoluo = _processor.resLib.getMovieClip("npc_5");
         this._npcCounter = _processor.resLib.getMovieClip("npc_3");
         this._npcOldMan.x = this.POS1[0][0];
         this._npcOldMan.y = this.POS1[0][1];
         this._npcBadi.x = this.POS1[1][0];
         this._npcBadi.y = this.POS1[1][1];
         this._npcDuoluo.x = this.POS1[2][0];
         this._npcDuoluo.y = this.POS1[2][1];
         this._npcCounter.x = this.POS1[3][0];
         this._npcCounter.y = this.POS1[3][1];
         _map.content.addChild(this._npcOldMan);
         _map.content.addChild(this._npcBadi);
         _map.content.addChild(this._npcDuoluo);
         _map.content.addChild(this._npcCounter);
         this._npcBadi["mark"].visible = this._npcDuoluo["mark"].visible = this._npcCounter["mark"].visible = false;
         this._npcOldMan["mark"].visible = true;
         this._npcOldMan.buttonMode = true;
         this._npcOldMan.addEventListener(MouseEvent.CLICK,this.onOldManClick2);
      }
      
      private function onOldManClick2(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npcOldMan.removeEventListener(MouseEvent.CLICK,this.onOldManClick2);
         NpcDialog.show(180,"圣诞老人",[[1,"其实大白熊康特偶尔会变得如此恐怖是因为它有着不堪回首的过去。"]],["哦？！"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10145_2"),4,[[1,0]],function():void
            {
               _npcOldMan.addEventListener(MouseEvent.CLICK,onOldManClick3);
            });
         }]);
      }
      
      private function onOldManClick3(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npcOldMan.removeEventListener(MouseEvent.CLICK,this.onOldManClick3);
         NpcDialog.show(180,"圣诞老人",[[1,"因为雪人村少有没有星星的夜晚，只有在圣诞节这段时间雪才会下很长时间，这时，就要给康特做一个这样的装满繁星的水晶球。"]],["原来是这样呀！"],[function():void
         {
            NpcDialog.show(180,"圣诞老人",[[1,"这次多亏有你们在，要不然我这个老头子去找这些材料要费些功夫了，大白熊没准就又惹出什么麻烦了。"]],["哈哈，我们是星际使者嘛！"],[function():void
            {
               NpcDialog.show(180,"圣诞老人",[[1,"嗯！圣诞节期间，雪人村有好多好玩的项目，你们就在这里尽情的玩吧。还有好多的礼物等你你哦！"]],["好的！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                  QuestManager.completeStep(_quest.id,6);
               }]);
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         this.processMapDispose();
         SceneManager.changeScene(SceneType.LOBBY,10109);
      }
      
      private function desolveRes() : void
      {
         if(Boolean(this._npcOldMan) && Boolean(this._npcOldMan.parent))
         {
            DisplayUtil.removeForParent(this._npcOldMan);
            this._npcOldMan.removeEventListener(MouseEvent.CLICK,this.onOldManClick);
            this._npcOldMan.removeEventListener(MouseEvent.CLICK,this.onOldManClick1);
            this._npcOldMan.removeEventListener(MouseEvent.CLICK,this.onOldManClick2);
            this._npcOldMan = null;
         }
         if(Boolean(this._npcLv) && Boolean(this._npcLv.parent))
         {
            DisplayUtil.removeForParent(this._npcLv);
            this._npcLv = null;
         }
         if(Boolean(this._npcCounter) && Boolean(this._npcCounter.parent))
         {
            DisplayUtil.removeForParent(this._npcCounter);
            this._npcCounter = null;
         }
         if(Boolean(this._npcBadi) && Boolean(this._npcBadi.parent))
         {
            DisplayUtil.removeForParent(this._npcBadi);
            this._npcBadi.removeEventListener(MouseEvent.CLICK,this.onBadiClick);
            this._npcBadi = null;
         }
         if(Boolean(this._npcDuoluo) && Boolean(this._npcDuoluo.parent))
         {
            DisplayUtil.removeForParent(this._npcDuoluo);
            this._npcDuoluo.removeEventListener(MouseEvent.CLICK,this.onDuoluoClick);
            this._npcDuoluo = null;
         }
         if(Boolean(this._npcBear) && Boolean(this._npcBear.parent))
         {
            DisplayUtil.removeForParent(this._npcBear);
            this._npcBear = null;
         }
      }
      
      private function onBadiClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npcBadi.removeEventListener(MouseEvent.CLICK,this.onBadiClick);
         NpcDialog.show(10,"巴蒂",[[0,"哇！好漂亮的雪人村呀！多罗你看！这里哪里像是有怪物的地方！哼！胆小鬼！"]],["怪物？多罗这是怎么回事？"],[function():void
         {
            _npcBadi["mark"].visible = false;
            _npcDuoluo["mark"].visible = true;
            _npcDuoluo.buttonMode = true;
            _npcDuoluo.addEventListener(MouseEvent.CLICK,onDuoluoClick);
         }]);
      }
      
      private function onDuoluoClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npcDuoluo.removeEventListener(MouseEvent.CLICK,this.onDuoluoClick);
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10145_1"),3,[[1,0]],function():void
         {
            NpcDialog.show(11,"多罗",[[0,"这里有这么可怕的怪物，我们还是不要来打搅他了吧。"]],["巨熊？我没见过这里有黑色的巨熊呀"],[function():void
            {
               NpcDialog.show(11,"多罗",[[0,"巨熊会在飘雪的夜晚出现的，据说这里平时都是晴空万里，只有下雪的时候天上才没有星星，而这时……巨熊就会出现！"]],["真的吗？看样子一会就要下雪了"],[function():void
               {
                  NpcDialog.show(11,"多罗",[[0,"队长！队长！我们快跑吧！"]],["哎…小孩子们的故事你也相信呀"],[function():void
                  {
                     NpcDialog.show(11,"多罗",[[0,"这是真的。快走吧！再不走就来不及了！！！"]],["你该学学人家巴蒂的勇敢了"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10145_1"),function():void
                        {
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepOneComplete);
                           QuestManager.completeStep(_quest.id,1);
                        });
                     }]);
                  }]);
               }]);
            }]);
         });
      }
      
      private function onOldManClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npcOldMan.removeEventListener(MouseEvent.CLICK,this.onOldManClick);
         NpcDialog.show(180,"圣诞老人",[[1,"赛尔，再次感谢你的帮忙，雪人村恢复平静了，我和小绿先去准备圣诞节啦。"]],["嗯，我想多罗和巴蒂应该也很想来"],[function():void
         {
            NpcDialog.show(180,"圣诞老人",[[1,"嗯！你可以叫你的朋友来雪人村玩哦。"]],["好吧我现在就呼叫他们"],[function():void
            {
               var sceneMc:* = undefined;
               ActorManager.showRemoteActor = false;
               MonsterManager.hideAllMonster();
               DisplayUtil.removeForParent(_npcLv);
               DisplayUtil.removeForParent(_npcOldMan);
               DisplayUtil.removeForParent(_npcCounter);
               sceneMc = _processor.resLib.getMovieClip("scene_1");
               sceneMc.x = -50;
               sceneMc.y = -90;
               _map.front.addChild(sceneMc);
               MovieClipUtil.playMc(sceneMc,2,sceneMc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(sceneMc);
                  QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptComplete);
                  QuestManager.accept(_quest.id);
               },true);
            }]);
         }]);
      }
      
      private function onAcceptComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptComplete);
         this.addNpcRes2();
      }
      
      private function onStepOneComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneComplete);
         SceneManager.changeScene(SceneType.LOBBY,10110);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         this.desolveRes();
         ActorManager.showRemoteActor = true;
         MonsterManager.showAllMonster();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneComplete);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepFiveComplete);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
   }
}
