package com.taomee.seer2.app.processor.quest.handler.story.quest67
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_67_1240 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      public function QuestMapHandler_67_1240(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            this.addNpc();
         }
         if(QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isStepComplete(_quest.id,3))
         {
            this.addNpcAgain();
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var e:DialogPanelEvent = param1;
         if((e.content as DialogPanelEventData).params == "67_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("67_0"),function():void
            {
               QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
               QuestManager.accept(_quest.id);
            },true,false,2);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         this.addNpc();
      }
      
      private function addNpc() : void
      {
         this._npc = _processor.resLib.getMovieClip("npc");
         _map.content.addChild(this._npc);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcTalkHandler);
      }
      
      private function onNpcTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(106,"斯坦因",[[1,"我来告诉你们这一切到底是怎么回事。哈哈哈哈"]],["斯坦因博士！！"],[function():void
         {
            NpcDialog.show(106,"斯坦因",[[1,"没错，就是我，你们感受一下，皇后的这一场阴谋！"]],["阴谋？！"],[function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"皇后的阴谋？这从何说起？我们凭什么相信你"]],["真相是……"],[function():void
               {
                  NpcDialog.show(106,"斯坦因",[[1,"最好的办法就是让你们亲眼见识这个恶心皇后的阴谋。"]],["你们愿意尝试吗？"],[function():void
                  {
                     NpcDialog.show(106,"斯坦因",[[1,"你们看巴蒂，知道他们是怎么变得如此粗狂吗？你们还记得那一个不知名的黑箭射伤了巴蒂吗？"]],["黑箭？就是变成虫子飞走的黑箭？"],[function():void
                     {
                        NpcDialog.show(106,"斯坦因",[[1,"是的，就是那把箭，带有黑桃皇后的毒药，毒药入侵，巴蒂被蛊惑了，才做出如此失控的事情。"]],["不是说。这……"],[function():void
                        {
                           NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"这……这个黑箭是，邪恶的公主所为吗？这到底是怎么回事？"]],["我越来越糊涂了"],[function():void
                           {
                              NpcDialog.show(106,"斯坦因",[[1,"对啊，口说无凭，你们只有亲眼见到皇后才能真相大白，我将你们变成小虫，潜入皇后的宫殿，看看她的所作所为你们就清楚了。"]],["呼~变~"],[function():void
                              {
                                 MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("67_1"),function():void
                                 {
                                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepOneComplete);
                                    QuestManager.completeStep(_quest.id,1);
                                 },true,false,2);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStepOneComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneComplete);
         SceneManager.changeScene(SceneType.LOBBY,1210);
      }
      
      private function addNpcAgain() : void
      {
         this._npc = _processor.resLib.getMovieClip("npc");
         _map.front.addChild(this._npc);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcTalkAgainHandler);
      }
      
      private function onNpcTalkAgainHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(106,"斯坦因",[[1,"真相就是这样的，好了，皇后的阴谋被你们揭穿了，可以继续寻找奎尔斯的下落了。"]],["嘿嘿嘿嘿~"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"对啊，我要赶快去寻找奎尔斯的下落。"]],["走吧。"],[function():void
            {
               NpcDialog.show(106,"斯坦因",[[1,"祝你们成功，我先走一步。"]],["哈哈哈哈。"],[function():void
               {
                  if(_npc)
                  {
                     DisplayUtil.removeForParent(_npc);
                  }
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestCompleteHandler);
                  QuestManager.completeStep(_quest.id,3);
               }]);
            }]);
         }]);
      }
      
      private function onQuestCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestCompleteHandler);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         if(this._npc)
         {
            DisplayUtil.removeForParent(this._npc);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneComplete);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestCompleteHandler);
         super.processMapDispose();
      }
   }
}
