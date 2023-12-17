package com.taomee.seer2.app.processor.quest.handler.branch.quest10143
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
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
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10143_10108 extends QuestMapHandler
   {
       
      
      private var _npc_mc:MovieClip;
      
      private const POS:Point = new Point(238,240);
      
      public function QuestMapHandler_10143_10108(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.addRes();
         }
         else if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && SceneManager.prevMapID == 100010 && FightManager.currentFightRecord.initData.positionIndex == 235)
            {
               this.addRes2();
            }
            else
            {
               this.addRes1();
            }
         }
      }
      
      private function addRes() : void
      {
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._npc_mc);
         this._npc_mc.x = this.POS.x;
         this._npc_mc.y = this.POS.y;
         this._npc_mc["Lv"].buttonMode = true;
         this._npc_mc["suer"].visible = false;
         this._npc_mc["Lv"].addEventListener(MouseEvent.CLICK,this.onSuerTalkFirstHandler);
      }
      
      private function addRes1() : void
      {
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._npc_mc);
         this._npc_mc.x = this.POS.x;
         this._npc_mc.y = this.POS.y;
         var _loc1_:MovieClip = this._npc_mc["suer"];
         _loc1_.buttonMode = true;
         this._npc_mc["Lv"].buttonMode = false;
         this._npc_mc["Lv"]["mark"].visible = false;
         this._npc_mc["suer"].visible = true;
         this._npc_mc["suer"].buttonMode = true;
         this._npc_mc["suer"]["mark"].visible = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSuerTalkFiveHandler);
      }
      
      private function addRes2() : void
      {
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._npc_mc);
         this._npc_mc.x = this.POS.x;
         this._npc_mc.y = this.POS.y;
         var _loc1_:MovieClip = this._npc_mc["suer"];
         this._npc_mc["suer"]["mark"].visible = true;
         this._npc_mc["Lv"].buttonMode = false;
         this._npc_mc["Lv"]["mark"].visible = false;
         this._npc_mc["suer"].visible = true;
         this._npc_mc["suer"].buttonMode = true;
         _loc1_.buttonMode = true;
         this.taskClothState();
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSuerTalkFourHandler);
      }
      
      private function taskClothState() : void
      {
         ActiveCountManager.requestActiveCount(202113,function(param1:uint, param2:uint):void
         {
            if(param2 == 5)
            {
               _npc_mc["suer"]["mark"].visible = true;
            }
            else
            {
               _npc_mc["suer"]["mark"].visible = false;
            }
         });
      }
      
      private function onSuerTalkFirstHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npc_mc["Lv"].removeEventListener(MouseEvent.CLICK,this.onSuerTalkFirstHandler);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10143_1"),function():void
         {
            _npc_mc["Lv"].buttonMode = false;
            _npc_mc["Lv"]["mark"].visible = false;
            _npc_mc["suer"].visible = true;
            _npc_mc["suer"].buttonMode = true;
            _npc_mc["suer"]["mark"].visible = true;
            _npc_mc["suer"].addEventListener(MouseEvent.CLICK,onSuerTalkSecondHandler);
         },true,false,2);
      }
      
      private function onSuerTalkSecondHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npc_mc["suer"].removeEventListener(MouseEvent.CLICK,this.onSuerTalkSecondHandler);
         MovieClipUtil.playFullScreen(URLUtil.getQuestAnimation("sceneTalk/10143_1"),function():void
         {
            _npc_mc["suer"].addEventListener(MouseEvent.CLICK,onSuerTalkThirdHandler);
         },false,false,2,false);
      }
      
      private function onSuerTalkThirdHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npc_mc["suer"].removeEventListener(MouseEvent.CLICK,this.onSuerTalkThirdHandler);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10143_2"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Complete);
            QuestManager.completeStep(_quest.id,2);
         },true,false,2);
      }
      
      private function onStep2Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         this._npc_mc["suer"].addEventListener(MouseEvent.CLICK,this.onSuerTalkFiveHandler);
      }
      
      private function onSuerTalkFiveHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npc_mc["suer"].removeEventListener(MouseEvent.CLICK,this.onSuerTalkFiveHandler);
         NpcDialog.show(180,"圣诞老人",[[0,"还好我在康特身上挂了一个追踪器，就放在我的大衣口袋…"]],["那快拿出来吧！我们一起去找！"],[function():void
         {
            NpcDialog.show(180,"圣诞老人",[[0,"可是刚刚我晾衣服时我的大衣被身边这群小精灵抢走了，大衣就在身边的精灵身上。"]],["身边的精灵？"],[function():void
            {
               NpcDialog.show(180,"圣诞老人",[[0,"嗯，大衣一定就在这几只精灵身上，快去帮我抢回来吧…我已经伤心的不能动弹了。"]],["好吧！"],[function():void
               {
                  _npc_mc["suer"].addEventListener(MouseEvent.CLICK,onSuerTalkFourHandler);
                  ActiveCountManager.requestActiveCount(202113,function(param1:uint, param2:uint):void
                  {
                     if(param2 == 5)
                     {
                        canNextStepMark();
                     }
                     else
                     {
                        _npc_mc["suer"]["mark"].visible = false;
                        TaskMonstorManager.getInstance().startShow(canNextStepMark,5 - param2);
                     }
                  });
               }]);
            }]);
         }]);
      }
      
      private function canNextStepMark() : void
      {
         if(this._npc_mc["suer"]["mark"])
         {
            this._npc_mc["suer"]["mark"].visible = true;
         }
      }
      
      private function onSuerTalkFourHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(Boolean(this._npc_mc["suer"]["mark"]) && !this._npc_mc["suer"]["mark"].visible)
         {
            NpcDialog.show(180,"圣诞老人",[[0,"怎么还没把大衣找回来呀？没有康特圣诞节该怎么办呀！快去附近精灵身上把大衣抢回来吧。"]],["好吧！"]);
            return;
         }
         ActiveCountManager.requestActiveCount(202113,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var count:uint = param2;
            if(count == 5)
            {
               _npc_mc["suer"].removeEventListener(MouseEvent.CLICK,onSuerTalkFourHandler);
               NpcDialog.show(180,"圣诞老人",[[0,"怎么这么慢呀，老夫像是等了一个世纪了。"]],["才过了几分钟啊！"],[function():void
               {
                  NpcDialog.show(180,"圣诞老人",[[0,"快拿出大衣中的跟踪雷达，看看康特现在在什么地方！"]],["好！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10143_3"),function():void
                     {
                        _npc_mc["suer"].addEventListener(MouseEvent.CLICK,onSuerTalkSixHandler);
                     },true,false,2);
                  }]);
               }]);
            }
            else
            {
               NpcDialog.show(180,"圣诞老人",[[0,"怎么还没把大衣找回来呀？没有康特圣诞节该怎么办呀！快去附近精灵身上把大衣抢回来吧。"]],["好吧！"]);
            }
         });
      }
      
      private function onSuerTalkSixHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npc_mc["suer"].removeEventListener(MouseEvent.CLICK,this.onSuerTalkSixHandler);
         MovieClipUtil.playFullScreen(URLUtil.getQuestAnimation("sceneTalk/10143_2"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onStep3Complete);
            QuestManager.completeStep(_quest.id,3);
         },false,false,2,false);
      }
      
      private function onStep3Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         this.processMapDispose();
         TaskMonstorManager.getInstance().dispose();
         this.clearNPC();
      }
      
      private function clearNPC() : void
      {
         if(Boolean(this._npc_mc) && Boolean(this._npc_mc.parent))
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(Boolean(this._npc_mc) && Boolean(this._npc_mc.parent))
         {
            DisplayUtil.removeForParent(this._npc_mc);
            this._npc_mc = null;
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep3Complete);
      }
   }
}
