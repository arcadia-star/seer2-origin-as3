package com.taomee.seer2.app.processor.quest.handler.story.quest19
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_19;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_19_540 extends QuestMapHandler
   {
       
      
      private var _mc:MovieClip;
      
      public function QuestMapHandler_19_540(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var _loc1_:int = 0;
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this._mc = _processor.resLib.getMovieClip("mc_3");
            this._mc.gotoAndStop(1);
            _map.content.addChild(this._mc);
            if(QuestManager.isStepComplete(_quest.id,1) == false)
            {
               this.stepOne();
            }
            else
            {
               _loc1_ = (_processor as QuestProcessor_19).fightIndex;
               if(_loc1_ == 0)
               {
                  this.stepTwo();
               }
            }
         }
      }
      
      private function stepOne() : void
      {
         MovieClipUtil.playMc(this._mc,1,87,function():void
         {
            _mc.buttonMode = true;
            _mc.addEventListener(MouseEvent.CLICK,onClick);
         },true);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._mc.buttonMode = false;
         this._mc.removeEventListener(MouseEvent.CLICK,this.onClick);
         NpcDialog.show(445,"冰川豚",[[1,"孩子，你没事吧！"]],["终于家人团聚啦！"],[function():void
         {
            NpcDialog.show(442,"冰湖豚",[[1,"爸爸！妈妈！恩人真的把你们救出来了！！我好想你们……呜呜哇哇……！"]],["（泪……）"],[function():void
            {
               NpcDialog.show(442,"冰湖豚",[[1,"恩人说，让我们在这里和它汇合……所以，它在哪呀？"]],["的确，没有看到目之魂呢！"],[function():void
               {
                  NpcDialog.show(445,"冰川豚",[[1,"目之魂阁下说，它要去救更多的生命，已经往冰之监狱去了…… "],[1,"阁下还说，让我们先去安全的地方避难。接下来会发生很危险的事情，要依靠强大的小赛尔！"]],[" 咳！就让强大的我带你们离开这里吧！"],[function():void
                  {
                     QuestManager.completeStep(_quest.id,1);
                     stepTwo();
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function stepTwo() : void
      {
         MovieClipUtil.playMc(this._mc,88,159,function():void
         {
            NpcDialog.show(446,"尼娅",[[0,"带回去……给妈妈吃……"]],["这是虾米？？！！"],[function():void
            {
               NpcDialog.show(445,"冰川豚",[[0,"尼……尼娅！传说中已经被封印的精灵！它们口中的“妈妈”应该就是指卡尼娅了……"]],["卡尼娅？"],[function():void
               {
                  NpcDialog.show(445,"冰川豚",[[0,"卡尼娅……诞生于暴风雪的灾难使者……它的孩子尼娅会趁着暴风雪依附在生物的身上，吸收它们的能力供卡尼娅食用……"],[0,"但是在数百年前，就应该被封印了才对……！"]],["那不就是吸血鬼吗？"],[function():void
                  {
                     NpcDialog.show(446,"尼娅",[[0,"好饿……给我……吃掉吧……"]],["哇！它攻过来了！"],[function():void
                     {
                        FightManager.startFightWithNPC(3);
                        (_processor as QuestProcessor_19).fightIndex = 3;
                        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
            (_processor as QuestProcessor_19).fightIndex = 0;
            NpcDialog.show(445,"冰川豚",[[0,"不行了……它吸收了我过多的能力……我……"]],["你没事吧？！"],[function():void
            {
               MovieClipUtil.playMc(_mc,160,205,function():void
               {
                  NpcDialog.show(444,"目之魂",[[0,"冰川豚……你们快走……"]],["目之魂！你看起来很累啊……"],[function():void
                  {
                     NpcDialog.show(444,"目之魂",[[0,"我没事……已经找到冰沁氏族的族人了……就在冰之监狱……"]],["（去冰之监狱！）"],[function():void
                     {
                        MovieClipUtil.playMc(_mc,205,_mc.totalFrames,function():void
                        {
                           QuestManager.completeStep(_quest.id,2);
                           _processor.showMouseHintAt(611,278);
                        },true);
                     }]);
                  }]);
               },true);
            }]);
         }
      }
      
      private function disposeMC() : void
      {
         if(this._mc != null)
         {
            this._mc.removeEventListener(MouseEvent.CLICK,this.onClick);
            DisplayObjectUtil.removeFromParent(this._mc);
            this._mc = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.disposeMC();
         _processor.hideMouseClickHint();
         super.processMapDispose();
      }
   }
}
