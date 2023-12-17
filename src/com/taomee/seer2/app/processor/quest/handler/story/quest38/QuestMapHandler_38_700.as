package com.taomee.seer2.app.processor.quest.handler.story.quest38
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
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
   
   public class QuestMapHandler_38_700 extends QuestMapHandler
   {
       
      
      private var _mc_1:MovieClip;
      
      private var _mc_2:MovieClip;
      
      public function QuestMapHandler_38_700(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initMc();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      private function initMc() : void
      {
         this._mc_2 = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._mc_2);
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "38_1")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            this.processStep1();
         }
      }
      
      private function processStep1() : void
      {
         this._mc_1 = _processor.resLib.getMovieClip("mc_1");
         _map.front.addChild(this._mc_1);
         this._mc_1.addEventListener(MouseEvent.CLICK,this.onClickMc1Handler);
      }
      
      private function onClickMc1Handler(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this._mc_1.removeEventListener(MouseEvent.CLICK,this.onClickMc1Handler);
         DisplayUtil.removeForParent(this._mc_1);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("38_2"),function():void
         {
            NpcDialog.show(87,"刚铎",[[0,"……"]],["……"],[function():void
            {
               NpcDialog.show(87,"刚铎",[[0,"纳格托——曾经有没有观测到更多的此类讯息？"]],["……"],[function():void
               {
                  NpcDialog.show(102,"观察员纳格托",[[0,"（翻看记录本）*年*月*日，鞭子女士：博士已经成功进入飞翼氏族。*年*月*日，鞭子女士：那个傻瓜财务官可以利用一下。"]],["……"],[function():void
                  {
                     NpcDialog.show(102,"观察员纳格托",[[0,"*年*月*日，鞭子女士：博士已经获取那个氏族的信任，呵呵……剥离神兽的力量？这不是博士的拿手好戏嘛？"]],["……"],[function():void
                     {
                        NpcDialog.show(87,"刚铎",[[0,"这么严重的事情为何不向上级禀报？！"]],["（鞭子女士=缇娜……）"],[function():void
                        {
                           NpcDialog.show(102,"观察员纳格托",[[0,"并没有特别关照过需要禀告关于这位女士的情况……"]],["这位女士是个邪恶女魔头啊！你居然不知道？！"],[function():void
                           {
                              NpcDialog.show(87,"刚铎",[[0,"从现在开始，好好保管你的记录本，它将成为决定性的证据。星际使者，我们速度回去将情况告诉萨伯尔！"]],["回飞翼氏族主城！"],[function():void
                              {
                                 QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepConpleteHandler);
                                 QuestManager.completeStep(_quest.id,1);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },true,false,2);
      }
      
      private function onStepConpleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepConpleteHandler);
         DisplayUtil.removeForParent(this._mc_2);
         SceneManager.changeScene(SceneType.LOBBY,660);
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc_1);
         DisplayUtil.removeForParent(this._mc_2);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepConpleteHandler);
      }
   }
}
