package com.taomee.seer2.app.processor.quest.handler.story.quest53
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.guide.info.GudieDirectionType;
   import com.taomee.seer2.app.guide.manager.GuideManager;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class QuestMapHandler_53_20 extends QuestMapHandler
   {
       
      
      private var _npc2:Mobile;
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_53_20(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
      }
      
      private function init() : void
      {
         ActorManager.showRemoteActor = false;
         this._npc2 = MobileManager.getMobile(2,MobileType.NPC);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
         DialogPanel.addEventListener(DialogPanelEvent.QUEST_UNIT_CLICK,this.onUnitClick);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onCustomReplyClick);
         ModuleManager.addEventListener("BusinessPanel",ModuleEvent.OPEN,this.hideGudie);
         ModuleManager.addEventListener("BusinessPanel",ModuleEvent.SET_UP,this.onShowBusiness);
         ModuleManager.addEventListener("BusinessPanel",ModuleEvent.DISPOSE,this.onDisposeBusiness);
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      private function hideGudie(param1:ModuleEvent) : void
      {
         if(QuestManager.isAccepted(_quest.id))
         {
            GuideManager.instance.pause();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         var e:QuestEvent = param1;
         GuideManager.instance.close();
         if(e.questId == 53)
         {
            NpcDialog.show(2,"伊娃博士",[[0,"真是好样的！道具买了，新精灵也获得了，接下来会由<font color=\'#ff0000\'>" + "NONO" + "</font>来指引你旅程哦！"]],["OK。"],[function():void
            {
               ActorManager.showRemoteActor = true;
               ModuleManager.addEventListener("FightResultPanel",ModuleEvent.HIDE,onFightHide);
            }]);
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_80);
         }
      }
      
      private function onFightHide(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("FightResultPanel",ModuleEvent.HIDE,this.onFightHide);
         ModuleManager.toggleModule(URLUtil.getAppModule("YueSeExperiencePanel"),"正在打开...");
      }
      
      private function onShowBusiness(param1:ModuleEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(QuestManager.isAccepted(53) && QuestManager.isStepComplete(53,1) == true && QuestManager.isStepComplete(53,2) == true && QuestManager.isStepComplete(53,3) == false)
         {
            _loc2_ = new Rectangle(0,0,65,65);
            GuideManager.instance.addTarget(_loc2_,12);
            GuideManager.instance.addGuide2Target(_loc2_,0,12,new Point(467,195),false,false,GudieDirectionType.CONTENT);
            GuideManager.instance.startGuide(12);
         }
      }
      
      private function onDisposeBusiness(param1:ModuleEvent) : void
      {
         var e:ModuleEvent = param1;
         GuideManager.instance.pause();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == true && QuestManager.isStepComplete(_quest.id,2) == true && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            NpcDialog.show(2,"伊娃博士",[[0,"购买道具是要消耗<font color=\'#ff0000\'>" + "赛尔豆" + "</font>哟，看你的赛尔豆不是很多，我就送你一些<font color=\'#ff0000\'>" + "体力药剂" + "</font>给你吧。"]],["哈哈哈，伊娃真大方。"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,StepHandler);
               QuestManager.completeStep(_quest.id,3);
            }]);
         }
      }
      
      private function onDialogShow(param1:DialogPanelEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(param1.content == 2 && QuestManager.isAccepted(_quest.id))
         {
            _loc2_ = new Rectangle(0,0,140,30);
            GuideManager.instance.addTarget(_loc2_,9);
            GuideManager.instance.addGuide2Target(_loc2_,0,9,new Point(284,480),false,false,GudieDirectionType.CONTENT);
            GuideManager.instance.startGuide(9);
         }
      }
      
      private function onUnitClick(param1:DialogPanelEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(param1.content.questId == 53 && param1.content.stepId == 3)
         {
            _loc2_ = new Rectangle(0,0,160,30);
            GuideManager.instance.addTarget(_loc2_,10);
            GuideManager.instance.addGuide2Target(_loc2_,0,10,new Point(628,519),false,false,GudieDirectionType.CONTENT);
            GuideManager.instance.pause();
         }
      }
      
      private function onCustomReplyClick(param1:DialogPanelEvent) : void
      {
         var _loc2_:Rectangle = null;
         if((param1.content as DialogPanelEventData).params == "53_2")
         {
            _loc2_ = new Rectangle(0,0,113,68);
            GuideManager.instance.addTarget(_loc2_,11);
            GuideManager.instance.addGuide2Target(_loc2_,0,11,new Point(302,95),false,false,GudieDirectionType.CONTENT);
            GuideManager.instance.startGuide(11);
         }
      }
      
      private function StepHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.StepHandler);
         if(param1.questId == _quest.id && param1.stepId == 2)
         {
            this.buyItems();
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_77);
         }
         else if(param1.questId == _quest.id && param1.stepId == 3)
         {
            this.fightPetGudie();
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_78);
         }
         else if(param1.questId == _quest.id && param1.stepId == 4)
         {
            this.recoverPetGudie();
         }
      }
      
      private function fightPetGudie() : void
      {
         NpcDialog.show(2,"伊娃博士",[[0,"你前面购买的<font color=\'#ff0000\'>" + "精灵胶囊" + "</font>是专门用来捕捉精灵的，接下来会有一种名叫<font color=\'#ff0000\'>" + "啾啾" + "</font>的精灵，如果你能成功<font color=\'#ff0000\'>" + "捕捉" + "</font>它，就会成为你的新伙伴哦！"]],["真的吗？我一定会成功的！"],[function():void
         {
            createPet();
         }]);
      }
      
      private function recoverPetGudie() : void
      {
         NpcDialog.show(2,"伊娃博士",[[0,"真厉害！不过刚刚的战斗消耗了精灵大量的<font color=\'#ff0000\'>" + "体力" + "</font>，当<font color=\'#ff0000\'>" + "体力为0" + "</font>时就不能继续战斗咯，赶紧使用精灵</font>，当<font color=\'#ff0000\'>" + "恢复按钮" + "</font>帮助精灵恢复体力吧。"]],["我知道了，这就去补充。"],[function():void
         {
            var _loc1_:* = new Rectangle(0,0,24,23);
            GuideManager.instance.addTarget(_loc1_,1);
            GuideManager.instance.addGuide2Target(_loc1_,0,1,new Point(184,87),false,false,GudieDirectionType.CONTENT);
            GuideManager.instance.startGuide(1);
         }]);
      }
      
      private function createPet() : void
      {
         var scene:LobbyScene = null;
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.content.addChild(this._mc_0);
         this._npc2.visible = false;
         scene = SceneManager.active as LobbyScene;
         scene.hideToolbar();
         LayerManager.focusOnTopLayer();
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            LayerManager.resetOperation();
            scene.showToolbar();
            _mc_0.gotoAndStop(_mc_0.totalFrames);
            _mc_0.addEventListener(Event.FRAME_CONSTRUCTED,onFrameConstructed);
            addGudie();
         });
      }
      
      private function onFrameConstructed(param1:Event) : void
      {
         this._mc_0.removeEventListener(Event.FRAME_CONSTRUCTED,this.onFrameConstructed);
         (this._mc_0["pet"] as MovieClip).buttonMode = true;
         (this._mc_0["pet"] as MovieClip).mouseEnabled = true;
         (this._mc_0["pet"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onNPC);
      }
      
      private function addGudie() : void
      {
         var _loc1_:Rectangle = new Rectangle(0,0,30,30);
         GuideManager.instance.addTarget(_loc1_,17);
         GuideManager.instance.addGuide2Target(_loc1_,0,17,new Point(420,241),false,false,GudieDirectionType.CONTENT);
         GuideManager.instance.startGuide(17);
      }
      
      private function onNPC(param1:MouseEvent) : void
      {
         this._npc2.visible = true;
         this._mc_0.removeEventListener(MouseEvent.CLICK,this.onNPC);
         DisplayObjectUtil.removeFromParent(this._mc_0);
         this._mc_0 = null;
         GuideManager.instance.close();
         if(PetInfoManager.getFirstPetInfo().level >= 20)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.StepHandler);
            QuestManager.completeStep(_quest.id,4);
         }
         else
         {
            FightManager.startFightWithGudiePet(0);
         }
      }
      
      private function buyItems() : void
      {
         GuideManager.instance.addTarget(this._npc2,8);
         GuideManager.instance.addGuide2Target(this._npc2,0,8,new Point(209,106),false,false,GudieDirectionType.CONTENT);
         GuideManager.instance.startGuide(8);
      }
      
      override public function processMapDispose() : void
      {
         this._npc2 = null;
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
         DialogPanel.removeEventListener(DialogPanelEvent.QUEST_UNIT_CLICK,this.onUnitClick);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onCustomReplyClick);
         ModuleManager.removeEventListener("BusinessPanel",ModuleEvent.OPEN,this.hideGudie);
         ModuleManager.removeEventListener("BusinessPanel",ModuleEvent.SET_UP,this.onShowBusiness);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
   }
}
