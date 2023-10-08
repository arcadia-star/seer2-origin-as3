package com.taomee.seer2.app.arena.ui.toolbar
{
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.controller.ArenaUIIsNew;
   import com.taomee.seer2.app.arena.data.ArenaDataInfo;
   import com.taomee.seer2.app.arena.data.FighterInfo;
   import com.taomee.seer2.app.arena.data.FighterTeam;
   import com.taomee.seer2.app.arena.events.OperateEvent;
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.arena.util.ControlPanelUtil;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.app.config.FitConfig;
   import com.taomee.seer2.app.gameRule.door.DoorArenaRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.inventory.constant.PetItemType;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class FightControlPanel extends Sprite
   {
       
      
      private var _arenaData:ArenaDataInfo;
      
      private var _controlledTeam:FighterTeam;
      
      private var _oppositeTeam:FighterTeam;
      
      private var _controlledFighter:Fighter;
      
      private var _back:Sprite;
      
      private var _hubButtonPanel:com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel;
      
      private var _skillPanel:SkillPanel;
      
      private var _itemPanel:ItemPanel;
      
      private var _capsulePanel:ItemPanel;
      
      private var _fighterPanel:com.taomee.seer2.app.arena.ui.toolbar.FighterPanel;
      
      private var _changFightUIBtn:SimpleButton;
      
      public function FightControlPanel()
      {
         super();
         this._back = FightUIManager.getSprite("UI_FightBarBack");
         addChild(this._back);
         this._skillPanel = new SkillPanel();
         this._skillPanel.y = 41;
         this._fighterPanel = new com.taomee.seer2.app.arena.ui.toolbar.FighterPanel();
         this._itemPanel = new ItemPanel(PetItemType.PHYSICAL_MEDICINE);
         this._capsulePanel = new ItemPanel(PetItemType.CAPSULE);
         this._hubButtonPanel = new com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel();
         addChild(this._hubButtonPanel);
         this._changFightUIBtn = this._back["changFightUIBtn"];
         this._hubButtonPanel.addEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_FIGHT,this.onFightClick);
         this._hubButtonPanel.addEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_ITEM,this.onItemClick);
         this._hubButtonPanel.addEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_PET,this.onPetClick);
         this._hubButtonPanel.addEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_ESCAPE,this.onEscapeClick);
         this._hubButtonPanel.addEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_CATCH,this.onCatchClick);
         this._skillPanel.addEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         this._fighterPanel.addEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         this._fighterPanel.addEventListener(OperateEvent.FIGHT_SELECT_SKILL,this.onFightSelectSkill);
         this._itemPanel.addEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         this._itemPanel.addEventListener(OperateEvent.ERROR,this.onItemPanelTurnError);
         this._itemPanel.addEventListener(OperateEvent.FIGHT_SELECT_ITEM,this.onFightSelectItem);
         this._capsulePanel.addEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         this._changFightUIBtn.addEventListener(MouseEvent.CLICK,this.onChangFight);
      }
      
      private function onChangFight(param1:MouseEvent) : void
      {
         ArenaUIIsNew.isNewUI = !ArenaUIIsNew.isNewUI;
         var _loc2_:String = ArenaUIIsNew.isNewUI ? "新" : "旧";
         ServerMessager.addMessage("下场战斗切换至" + _loc2_ + "UI");
      }
      
      public function active() : void
      {
         this._skillPanel.active();
         this._hubButtonPanel.active();
         this._itemPanel.active();
         this._capsulePanel.active();
         this._fighterPanel.active();
         this.updateHubButtonPanel();
         this.update();
      }
      
      public function deactive() : void
      {
         this._hubButtonPanel.deactive();
         this._skillPanel.deactive();
         this._itemPanel.deactive();
         this._capsulePanel.deactive();
         this._fighterPanel.deactive();
      }
      
      public function initPanelInfo(param1:ArenaDataInfo) : void
      {
         this._arenaData = param1;
         this._controlledTeam = param1.leftTeam;
         this._oppositeTeam = param1.rightTeam;
         this.updateOppositeFighter();
         var _loc2_:ButtonPanelData = ControlPanelUtil.getSettingData(this._arenaData.fightMode);
         this._arenaData.btnPanelData.merge(_loc2_);
      }
      
      public function updateControlledFighter(param1:Fighter) : void
      {
         this._controlledFighter = param1;
         this._itemPanel.setControlledFighter(this._controlledFighter);
         this._capsulePanel.setControlledFighter(this._controlledFighter);
         this._skillPanel.setFighter(this._controlledFighter);
         this.updateOppositeFighter();
      }
      
      public function updateOppositeFighter() : void
      {
         this._itemPanel.setOppositeFighter(this._oppositeTeam.mainFighter);
         this._capsulePanel.setOppositeFighter(this._oppositeTeam.mainFighter);
      }
      
      public function update() : void
      {
         this._skillPanel.updateSkillBtn();
         this._fighterPanel.update();
         this.showSkillBtnLightRingByQuest1();
      }
      
      public function showSkillPanel() : void
      {
         this.hideAll();
         addChild(this._skillPanel);
         this._skillPanel.setFighter(this._controlledFighter);
         this._hubButtonPanel.highlightFightBtn();
      }
      
      public function showFighterPanel(param1:uint = 0) : void
      {
         this.hideAll();
         this._fighterPanel.setFighterTeam(this._controlledTeam,param1);
         addChild(this._fighterPanel);
         this._hubButtonPanel.highlightPetBtn();
         if(!this._arenaData.isDoubleMode)
         {
            this._fighterPanel.updatePetPress(this._oppositeTeam.mainFighter.fighterInfo.typeId);
         }
      }
      
      private function onFightSelectSkill(param1:OperateEvent) : void
      {
         this.showSkillPanel();
      }
      
      public function automate() : void
      {
         var _loc1_:OperateEvent = null;
         var _loc2_:int = 0;
         var _loc3_:Vector.<SkillInfo> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:SkillInfo = null;
         var _loc7_:FighterInfo = null;
         if(this._controlledFighter.fighterInfo.hp > 0)
         {
            this.showSkillPanel();
            _loc2_ = -1;
            _loc3_ = this._controlledFighter.fighterInfo.skillInfoVec;
            _loc4_ = int(_loc3_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = _loc3_[_loc5_];
               if(this._controlledFighter.fighterInfo.checkSkillAnger(_loc6_))
               {
                  _loc2_ = int(_loc6_.id);
                  break;
               }
               _loc5_++;
            }
            if(_loc2_ == -1)
            {
               _loc2_ = int(_loc3_[0].id);
            }
            _loc1_ = new OperateEvent(OperateEvent.OPERATE_SKILL,_loc2_,OperateEvent.OPERATE_END);
         }
         else
         {
            this.showFighterPanel();
            if((_loc7_ = this._controlledTeam.getRandomAliveFighterInfo()) != null)
            {
               _loc1_ = new OperateEvent(OperateEvent.OPERATE_FIGHTER,_loc7_.catchTime,OperateEvent.OPERATE_END);
            }
         }
         this.endInput(_loc1_);
      }
      
      private function hideAll() : void
      {
         DisplayObjectUtil.removeFromParent(this._capsulePanel);
         DisplayObjectUtil.removeFromParent(this._fighterPanel);
         DisplayObjectUtil.removeFromParent(this._itemPanel);
         DisplayObjectUtil.removeFromParent(this._skillPanel);
      }
      
      private function updateHubButtonPanel() : void
      {
         this._hubButtonPanel.unhighlightAll();
         this._hubButtonPanel.catchBtnLightRingEnabled = false;
         var _loc1_:ButtonPanelData = new ButtonPanelData();
         if(this._controlledFighter.fighterInfo.hp == 0)
         {
            _loc1_.setDeadFightConfig();
         }
         else
         {
            _loc1_.merge(this._arenaData.btnPanelData);
         }
         if(this._arenaData.isDoubleMode)
         {
            _loc1_.catchEnabled = false;
         }
         else if(this._oppositeTeam.mainFighter.fighterInfo.isCatchable == false)
         {
            _loc1_.catchEnabled = false;
         }
         _loc1_.catchEnabled = _loc1_.catchEnabled && this._arenaData.canCatch;
         if(this._arenaData.canCatchAfterSptDeadNow)
         {
            _loc1_.catchEnabled = true;
         }
         var _loc2_:int = int(this._arenaData.fightMode);
         if(_loc2_ == FightMode.FIGHT_PVP_DOOR_NORMAL || _loc2_ == FightMode.FIGHT_PVP_DOOR_50V50)
         {
            if(DoorArenaRule.current_arena_rule == DoorRule.ATLETICO_DOOR)
            {
               _loc1_.petEnabled = false;
            }
         }
         this._hubButtonPanel.fightEnabled = _loc1_.fightEnabled;
         this._hubButtonPanel.catchEnabled = _loc1_.catchEnabled;
         this._hubButtonPanel.itemEnabled = _loc1_.itemEnabled;
         this._hubButtonPanel.petEnabled = _loc1_.petEnabled;
         this._hubButtonPanel.escapeEnabled = _loc1_.escapeEnabled;
         this.disableEscapeButtonByQuest1();
         this.showCatchLightRingByQuest3();
      }
      
      private function onOperateEnd(param1:OperateEvent) : void
      {
         this.endInput(param1);
      }
      
      private function onItemPanelTurnError(param1:OperateEvent) : void
      {
         this.showSkillPanel();
      }
      
      private function onFightClick(param1:Event) : void
      {
         this.showSkillPanel();
      }
      
      public function itemPanelUpdate() : void
      {
         this._itemPanel.resetData();
      }
      
      private function onItemClick(param1:Event) : void
      {
         this.hideAll();
         this._itemPanel.reset();
         addChild(this._itemPanel);
      }
      
      private function onFightSelectItem(param1:OperateEvent) : void
      {
         this.showFighterPanel(param1.id);
      }
      
      private function onPetClick(param1:Event) : void
      {
         if(FitConfig.isPetFit(this._controlledFighter.fighterInfo.bunchId))
         {
            AlertManager.showAlert("合体中不可更换精灵！");
            return;
         }
         this.showFighterPanel();
      }
      
      private function onEscapeClick(param1:Event) : void
      {
         if(this._arenaData.isFightEnd == false)
         {
            this.endInput(new OperateEvent(OperateEvent.OPERATE_ESCAPE,0,OperateEvent.OPERATE_END));
         }
      }
      
      private function onCatchClick(param1:Event) : void
      {
         this.hideAll();
         this._capsulePanel.reset();
         addChild(this._capsulePanel);
      }
      
      private function endInput(param1:OperateEvent) : void
      {
         this.deactive();
         dispatchEvent(param1);
      }
      
      public function getHubButtonPanel() : com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel
      {
         return this._hubButtonPanel;
      }
      
      public function dispose() : void
      {
         DisplayObjectUtil.removeAllChildren(this);
         this._hubButtonPanel.removeEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_FIGHT,this.onFightClick);
         this._hubButtonPanel.removeEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_ITEM,this.onItemClick);
         this._hubButtonPanel.removeEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_PET,this.onPetClick);
         this._hubButtonPanel.removeEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_ESCAPE,this.onEscapeClick);
         this._hubButtonPanel.removeEventListener(com.taomee.seer2.app.arena.ui.toolbar.HubButtonPanel.EVT_CATCH,this.onCatchClick);
         this._skillPanel.removeEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         this._fighterPanel.removeEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         this._itemPanel.removeEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         this._itemPanel.removeEventListener(OperateEvent.ERROR,this.onItemPanelTurnError);
         this._capsulePanel.removeEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         this._back = null;
         this._skillPanel.dispose();
         this._skillPanel = null;
         this._itemPanel.dispose();
         this._itemPanel = null;
         this._capsulePanel.dispose();
         this._capsulePanel = null;
         this._fighterPanel.dispose();
         this._fighterPanel = null;
         this._controlledTeam = null;
         this._controlledFighter = null;
         this._oppositeTeam = null;
         this._hubButtonPanel.dispose();
         this._hubButtonPanel = null;
      }
      
      private function disableEscapeButtonByQuest1() : void
      {
         if(QuestManager.isComplete(1) == false)
         {
            this._hubButtonPanel.escapeEnabled = false;
         }
      }
      
      private function showCatchLightRingByQuest3() : void
      {
         var _loc1_:Fighter = this._oppositeTeam.mainFighter;
         if(QuestManager.isStepComplete(3,2) && QuestManager.isStepComplete(3,3) == false && _loc1_.fighterInfo.resourceId == 10)
         {
            this._hubButtonPanel.catchBtnLightRingEnabled = true;
         }
      }
      
      private function showSkillBtnLightRingByQuest1() : void
      {
         if(QuestManager.isStepComplete(1,3) && QuestManager.isStepComplete(1,4) == false)
         {
            this._skillPanel.skillBtnLightRingEnabled = true;
         }
      }
   }
}
