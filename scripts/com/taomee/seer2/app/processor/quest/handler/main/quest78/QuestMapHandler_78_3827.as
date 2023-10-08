package com.taomee.seer2.app.processor.quest.handler.main.quest78
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QuestMapHandler_78_3827 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_78_3827(param1:QuestProcessor)
      {
         super(param1);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(questID))
         {
            QuestManager.accept(questID);
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccepted);
         }
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.initStep1();
         }
         if(QuestManager.isStepComplete(questID,1) && !QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.initStep1();
         }
         if(QuestManager.isStepComplete(questID,1) && !QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc1 = null;
         this._mc2 = null;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _map.content.addChild(_loc2_);
         _loc2_.x = 1000;
         _loc2_.y = 280;
      }
      
      private function initStep1() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc78_0");
         _map.front.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(_mc1);
            initContinue();
         },true);
      }
      
      private function initContinue() : void
      {
         this.createNpc();
      }
      
      private function createNpc() : void
      {
         var _loc1_:AcceptableMark = null;
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(650,550));
            this._npc.resourceUrl = URLUtil.getNpcSwf(1016);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            _loc1_ = new AcceptableMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -150;
            this._npc.addEventListener(MouseEvent.CLICK,this.initStep2);
         }
      }
      
      private function initStep2(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("78_0"),function():void
         {
            NpcDialog.show(1016,"里格",[[0,"你们没事吧？小赛尔，真的很感谢你救了我的属下。"]],["  我们没事啦"],[function():void
            {
               NpcDialog.show(821,"提尔",[[1,"抱、抱歉，刚才误会你们了。要不是你们的帮助，恐怕我已经被抓住了。小赛尔，真的非常非常感谢你！"]],[" 没关系，这是我应该做的"],[function():void
               {
                  NpcDialog.show(1016,"里格",[[0,"对了，正式自我介绍一下，我是里格，是反萨联盟的队长，这是提尔，是我们队的先锋。"]],[" 反萨联盟？"],[function():void
                  {
                     NpcDialog.show(1016,"里格",[[2,"我们不甘受到萨伦帝国的奴役，不愿成为萨伦统治全球的工具，所以暗地里成立了“反萨联盟”，默默的积蓄力量，为了自由而奋战！"]],["..."],[function():void
                     {
                        NpcDialog.show(1016,"里格",[[0,"如你们所见，这里是超能氏族的一处密道，与虫群氏族相连。我们将这里作为“反萨联盟”的秘密基地。"]],["  原来是这样。"],[function():void
                        {
                           NpcDialog.show(1016,"里格",[[0,"但是现在，这里已经被萨伦的精灵发现，不再安全，我们必须马上转移。小赛尔，跟我来吧。"]],[" 好的。"],[function():void
                           {
                              initStep3();
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         });
      }
      
      private function initStep3() : void
      {
         MobileManager.removeMobile(this._npc,MobileType.NPC);
         this._npc = null;
         this._mc2 = _processor.resLib.getMovieClip("Mc78_1");
         _map.front.addChild(this._mc2);
         this._mc2.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc2,1,this._mc2.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(_mc2);
            QuestManager.completeStep(questID,1);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onComplete);
         },true);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
   }
}
