package com.taomee.seer2.app.processor.quest.handler.branch.quest10141
{
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
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10141_10107 extends QuestMapHandler
   {
       
      
      private var _game:com.taomee.seer2.app.processor.quest.handler.branch.quest10141.Game10141;
      
      private var _npc_mc:MovieClip;
      
      public function QuestMapHandler_10141_10107(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.addNpc();
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.addNpcAgain();
         }
      }
      
      private function addNpc() : void
      {
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._npc_mc);
         var _loc1_:MovieClip = this._npc_mc["lv"];
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onLvTalkHandler);
      }
      
      private function onLvTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(177,"小绿",[[0,"你们是谁啦？呦？这不是白天跳舞输给我的小孩儿嘛？怎么啦？你们又有礼物要跟我比赛啦？"]],["哼！你竟然欺负小孩儿！"],[function():void
         {
            NpcDialog.show(177,"小绿",[[0,"谁欺负人啦！你这个机器人不服气吗？有本事就跟我比赛跳舞呀！"]],["比赛跳舞？"],[function():void
            {
               NpcDialog.show(177,"小绿",[[0,"嗯…是的！输了就要把礼物全部交给我才行！"]],["那我要是赢了呢？"],[function():void
               {
                  NpcDialog.show(177,"小绿",[[0,"赢了就…哎呀…你哪那么多废话，到底比还是不比！（切~机器人怎么可能赢得过我）"]],["哼！来吧（让你领教一下我的机械舞步）！"],[function():void
                  {
                     _game = new com.taomee.seer2.app.processor.quest.handler.branch.quest10141.Game10141(_processor.resLib.getMovieClip("page1"),_processor.resLib.getMovieClip("page2"),gameComplete);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function gameComplete() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         QuestManager.completeStep(_quest.id,2);
      }
      
      private function onStep2Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         this.addNpcAgain();
      }
      
      private function addNpcAgain() : void
      {
         var _loc1_:MovieClip = null;
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._npc_mc);
         _loc1_ = this._npc_mc["lv"];
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onLvTalkAgainHandler);
      }
      
      private function onLvTalkAgainHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(177,"小绿",[[0,"这轮…这轮不算！我们再比试一次！"]],["愿赌服输嘛！"],[function():void
         {
            NpcDialog.show(177,"小绿",[[0,"谁跟你赌了，是你要主动要跟我比试的，我才不要把礼物还给你呢！"]],["哼！输了还耍赖！你是要我动粗了！"],[function():void
            {
               NpcDialog.show(177,"小绿",[[0,"动粗…好怕呀…好怕呀…嘿嘿！康特！上！"]],["康特？！"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10141_1"),function():void
                  {
                     NpcDialog.show(177,"小绿",[[0,"又…睡着了，哼！反正我是不会给你的！"]],["没有了帮手还不乖点！把礼物还给小孩子们！"],[function():void
                     {
                        NpcDialog.show(177,"小绿",[[0,"我不！我也是小孩子！呜呜呜…奇怪的机器人要欺负小孩子了！有没有人管呀！啊呜呜呜…"]],["别哭啊！我…我没说要欺负你呀！"],[function():void
                        {
                           NpcDialog.show(177,"小绿",[[0,"你就是要欺负我！抢我的礼物！呜呜呜…机器人什么的都是大坏蛋…"]],["啊啊……真头疼啊…"],[function():void
                           {
                              MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10141_2"),function():void
                              {
                                 addNpcThird();
                              },true,false,2);
                           }]);
                        }]);
                     }]);
                  },true,false,2);
               }]);
            }]);
         }]);
      }
      
      private function addNpcThird() : void
      {
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._npc_mc);
         var _loc1_:MovieClip = this._npc_mc["lv"];
         var _loc2_:MovieClip = this._npc_mc["conter"];
         _loc2_.visible = false;
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onLvTalkAgainHandler);
         this.lvTalk();
      }
      
      private function lvTalk() : void
      {
         NpcDialog.show(177,"小绿",[[0,"康特呢？康特康特康特呢？我的康特呢？！！！"]],["诶…几个小时前还在这里呀！"],[function():void
         {
            NpcDialog.show(177,"小绿",[[0,"呜啊！！完了！完了完了完了…我会被爸爸骂死的！这是爸爸最重要的宝贝精灵！呜啊！"]],["先别着急呀！找找看吧！"],[function():void
            {
               NpcDialog.show(177,"小绿",[[0,"一定要帮帮我呀，要不我就死定了，我爸爸是一个非常厉害的人，一个手掌能拍出一个五指山来！啊啊！好可怕…"]],["这么厉害！"],[function():void
               {
                  NpcDialog.show(177,"小绿",[[0,"机器人最好了一定要帮帮我呀！"]],["现在开始说好话了！好吧…唉…"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.COMPLETE,onStep3Complete);
                     QuestManager.completeStep(_quest.id,3);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStep3Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep3Complete);
         SceneManager.changeScene(SceneType.LOBBY,123);
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep3Complete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
      }
   }
}
