package com.taomee.seer2.app.processor.quest.handler.branch.quest10193
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10193_3301 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_10193_3301(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._npc = MobileManager.getMobile(43,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick,false,1);
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(QuestManager.isAccepted(10193))
         {
            e.stopImmediatePropagation();
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            NpcDialog.show(400,"我",[[0,"哦，我亲爱的汪总管，有件事得打扰您一下。"]],["关于氏族纷争的故事"],[function():void
            {
               NpcDialog.show(43,"汪总管",[[0,"什么氏族纷争？我没有参与纷争，我只是一个卖米共饲料的。"]],["你需要米共饲料吗？"],[function():void
               {
                  NpcDialog.show(400,"我",[[0,"对不起，我不要，我是想说，关于沙爪氏族和地月氏族纷争的事你知道吗？"]],["我只是想了解一下情况"],[function():void
                  {
                     NpcDialog.show(43,"汪总管",[[0,"这里没有纷争，这里只有米共饲料，你要米共饲料吗？"]],["你需要米共饲料吗？"],[function():void
                     {
                        NpcDialog.show(400,"我",[[0,"算了，我还是去问问别人吧（这里的人都好奇怪，为什么都不知道）"]],["为什么？为什么？为什么？"],[function():void
                        {
                           NpcDialog.show(400,"我",[[0,"这到底是为了什么，忧愁它围绕着我。算了，我还是打开约瑟传说看看有没有什么线索吧。"]],["打开约瑟传说"],[function():void
                           {
                              QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
                              QuestManager.completeStep(10193,1);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }
      }
      
      public function onStep(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         ModuleManager.toggleModule(URLUtil.getAppModule("ZhuaBeastPanel"),"","1");
      }
      
      override public function processMapDispose() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         super.processMapDispose();
      }
   }
}
