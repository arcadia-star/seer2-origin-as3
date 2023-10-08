package com.taomee.seer2.app.processor.quest.handler.activity.quest30006
{
   import com.taomee.seer2.app.activity.onlineReward.MakeWishAnimationManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30006_123 extends QuestMapHandler
   {
       
      
      private var battleMcName:String = "30006_1";
      
      private var shureMc:MovieClip;
      
      private var threeEets:String = "30006_2";
      
      private var chongShow:MovieClip;
      
      public function QuestMapHandler_30006_123(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,4) && !QuestManager.isStepComplete(_quest.id,5))
         {
            this.initQuestStep5();
         }
      }
      
      private function initQuestStep5() : void
      {
         var _loc1_:Mobile = MobileManager.getMobile(20,MobileType.NPC);
         _loc1_.visible = false;
         this.shureMc = _processor.resLib.getMovieClip("ShureMc");
         this.shureMc.buttonMode = true;
         _map.content.addChild(this.shureMc);
         this.shureMc.addEventListener(MouseEvent.CLICK,this.showShureDia);
      }
      
      private function showShureDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         var npc:Mobile = MobileManager.getMobile(20,MobileType.NPC);
         npc.visible = true;
         _map.content.removeChild(this.shureMc);
         this.shureMc.removeEventListener(MouseEvent.CLICK,this.showShureDia);
         NpcDialog.show(20,"舒尔",[[3,"太恐怖了……美味蓝菇全军覆没了！那哪里是精灵，简直就是轰炸机！"]],["发生什么事情了？"],[function():void
         {
            NpcDialog.show(20,"舒尔",[[3,"那可是灾难啊！我精心种植的宝贵食材！虽然浣浣也一直来偷吃，但不至于那么可怕！！"]],["难道就是虫伊特？"],[function():void
            {
               chongShow = _processor.resLib.getMovieClip("ChongShow");
               chongShow.gotoAndStop(1);
               _map.front.addChild(chongShow);
               MovieClipUtil.playMc(chongShow,1,chongShow.totalFrames,function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"嘿！捣蛋鬼！！今天有我在，你就别想胡乱糟蹋粮食了！"]],["别想碰蓝菇，除非我倒下！"],[playBattle]);
               },true);
            }]);
         }]);
      }
      
      private function playBattle() : void
      {
         _map.front.removeChild(this.chongShow);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation(this.battleMcName),function():void
         {
            var skill:MovieClip = null;
            skill = _processor.resLib.getMovieClip("ChongSkill");
            skill.gotoAndStop(1);
            _map.front.addChild(skill);
            NpcDialog.show(473,"虫伊特",[[2,"疼……疼死了！！我以后再来！"]],[" 哦呵呵——怎么样！！"],[function():void
            {
               MovieClipUtil.playMc(skill,1,skill.totalFrames,function():void
               {
                  var mc:* = undefined;
                  _map.front.removeChild(skill);
                  mc = _processor.resLib.getMovieClip("ThreeEets");
                  _map.front.addChild(mc);
                  MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
                  {
                     _map.front.removeChild(mc);
                     completeQuest();
                  },true);
               },true);
            }]);
         });
      }
      
      private function completeQuest() : void
      {
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         QuestManager.completeStep(_quest.id,5);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 30006)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
            MakeWishAnimationManager.showYiTe();
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this.shureMc)
         {
            this.shureMc.removeEventListener(MouseEvent.CLICK,this.showShureDia);
         }
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
      }
   }
}
