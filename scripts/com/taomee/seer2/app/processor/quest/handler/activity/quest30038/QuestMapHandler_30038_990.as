package com.taomee.seer2.app.processor.quest.handler.activity.quest30038
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30038_990 extends QuestMapHandler
   {
       
      
      private var caoNiMa:MovieClip;
      
      private var scholarNpc:Mobile;
      
      public function QuestMapHandler_30038_990(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.completeQuest);
         if(this.caoNiMa)
         {
            this.caoNiMa.removeEventListener(MouseEvent.CLICK,this.showMaDia);
         }
         if(this.scholarNpc)
         {
            this.scholarNpc.removeEventListener(MouseEvent.CLICK,this.showScholarDia);
         }
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isNeedToAccept())
         {
            this.initAcceptProcess();
         }
         if(isNeedCompleteStep(3))
         {
            this.initStep3();
         }
      }
      
      private function initStep3() : void
      {
         this.caoNiMa = _processor.resLib.getMovieClip("CaoNiMa");
         this.caoNiMa.x = 710;
         this.caoNiMa.y = 230;
         _map.content.addChild(this.caoNiMa);
         var _loc1_:XML = <npc id="160" resId="160" name="多茨莫博士" dir="1" width="115" height="125" pos="660,288" actorPos="821,288" path=""/>;
         var _loc2_:NpcDefinition = new NpcDefinition(_loc1_);
         this.scholarNpc = MobileManager.createNpc(_loc2_);
         this.scholarNpc.addOverHeadMark(new AcceptableMark());
         this.scholarNpc.buttonMode = true;
         this.scholarNpc.addEventListener(MouseEvent.CLICK,this.showScholarDia);
      }
      
      private function showScholarDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(160,"多茨莫博士",[[0,"真是怀念，这座守林人木屋——我曾经的研究所……"]],["现在都已经破破烂烂了呢。"],[function():void
         {
            NpcDialog.show(160,"多茨莫博士",[[0,"我们需要一周的时间来整顿这里：重建木屋，开垦土地……小赛尔，收集种子的任务就交给你了！"]],["没问题！话说，怎么收集呢？"],[function():void
            {
               NpcDialog.show(160,"多茨莫博士",[[0,"在水脉氏族可以收集到笑笑花子和藤蔓花籽，我们可以先引进这些初级作物。这一周的时间，尽可能多的收集吧！"]],["交给我吧！看来，种植系统指日可待了！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,completeQuest);
                  QuestManager.completeStep(questID,3);
               }]);
            }]);
         }]);
      }
      
      private function completeQuest(param1:QuestEvent) : void
      {
         if(param1.questId == 30038)
         {
            DisplayObjectUtil.removeFromParent(this.caoNiMa);
            MobileManager.removeMobile(this.scholarNpc,MobileType.NPC);
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.completeQuest);
         }
      }
      
      private function initAcceptProcess() : void
      {
         this.caoNiMa = _processor.resLib.getMovieClip("CaoNiMa");
         _map.content.addChild(this.caoNiMa);
         this.caoNiMa.y = 380;
         this.caoNiMa.x = 220;
         this.caoNiMa.buttonMode = true;
         var _loc1_:AcceptableMark = new AcceptableMark();
         _loc1_.x = 248;
         _loc1_.y = 380;
         _map.content.addChild(_loc1_);
         this.caoNiMa.addEventListener(MouseEvent.CLICK,this.showMaDia);
      }
      
      private function showMaDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(516,"草泥马宝宝",[[2,"话说回来……虽然我们已经决定要拯救普兰特山麓……但是没有博士的帮助是不行的！"]],["博士？啥博士？"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30038_0"),3,[[1,0]],function():void
            {
               NpcDialog.show(516,"草泥马宝宝",[[2,"我追着博士的踪迹，在冥冥之中一直有一股力量将我带上那艘铁皮船……之后我就遇见了你……嘤嘤嘤……"]],["信息量好大 ！难道博士和赛尔号II的飞船有关？"],[function():void
               {
                  NpcDialog.show(516,"草泥马宝宝",[[2,"一定是的！要不，就去我上一次华丽躺倒的地方看看吧！！"]],["总比盲目寻找好，去实验室看看！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                     QuestManager.accept(questID);
                  }]);
               }]);
            });
         }]);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY,20);
         }
      }
   }
}
