package com.taomee.seer2.app.arena.controller
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
   import com.taomee.seer2.app.arena.cmd.UseCapuleCMD;
   import com.taomee.seer2.app.arena.cmd.UseChangeCMD;
   import com.taomee.seer2.app.arena.cmd.UseEscapeCMD;
   import com.taomee.seer2.app.arena.cmd.UseItemCMD;
   import com.taomee.seer2.app.arena.cmd.UseSkillCMD;
   import com.taomee.seer2.app.arena.data.FighterTeam;
   import com.taomee.seer2.app.arena.decoration.DecorationControl;
   import com.taomee.seer2.app.arena.events.OperateEvent;
   import com.taomee.seer2.app.arena.newUI.toolbar.FightPointPanel;
   import com.taomee.seer2.app.arena.newUI.toolbar.NewFightControlPanel;
   import com.taomee.seer2.app.arena.ui.status.StatusPanelFactory;
   import com.taomee.seer2.app.arena.ui.status.panel.*;
   import com.taomee.seer2.app.arena.ui.toolbar.FightControlPanel;
   import com.taomee.seer2.app.config.FitConfig;
   import com.taomee.seer2.app.config.pet.PetFitDefinition;
   import com.taomee.seer2.app.gameRule.spt.support.SptBossInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ArenaUIController implements IArenaUIController
   {
       
      
      private var _scene:ArenaScene;
      
      private var _controlPanel:*;
      
      private var _statusPanel:FightStatusPanel;
      
      private var _fightPointPanel:FightPointPanel;
      
      private var _contentValue:Sprite;
      
      private var _petContentValue:Sprite;
      
      private var _operateFighters:Vector.<Fighter>;
      
      public function ArenaUIController(param1:ArenaScene)
      {
         super();
         this._scene = param1;
         this.createControlPanel();
         this.createStatusPanel();
         this.createPointPanel();
      }
      
      public function dispose() : void
      {
         DisplayObjectUtil.removeFromParent(this._controlPanel);
         this._controlPanel.dispose();
         this._controlPanel = null;
         DisplayObjectUtil.removeFromParent(this._statusPanel);
         this._statusPanel.dispose();
         this._statusPanel = null;
         DisplayObjectUtil.removeFromParent(this._fightPointPanel);
         this._fightPointPanel.dispose();
         this._fightPointPanel = null;
         DisplayObjectUtil.removeFromParent(this._contentValue);
         this._contentValue = null;
         DisplayObjectUtil.removeFromParent(this._petContentValue);
         this._petContentValue = null;
      }
      
      public function getContent() : Sprite
      {
         return this._contentValue;
      }
      
      private function onResize(param1:Event) : void
      {
         this.layOut();
      }
      
      public function layOut() : void
      {
         this._contentValue.scaleX = LayerManager.stage.stageWidth / 1200;
         this._contentValue.scaleY = LayerManager.stage.stageHeight / 660;
      }
      
      private function createPointPanel() : void
      {
         this._fightPointPanel = new FightPointPanel();
         this._fightPointPanel.y = 541;
         if(ArenaUIIsNew.isNewUI)
         {
            this._contentValue.addChild(this._fightPointPanel);
         }
      }
      
      public function startActiveFighter() : void
      {
         this._petContentValue = new Sprite();
         ArenaAnimationManager.addPar(this._contentValue);
         var _loc1_:Sprite = this._scene.mapModel.content;
         _loc1_.addChild(this._petContentValue);
         var _loc2_:Fighter = this.getLeftTeam().mainFighter;
         _loc2_.active();
         _loc2_.visible = false;
         this._petContentValue.addChild(_loc2_);
         var _loc3_:Fighter = this.getLeftTeam().subFighter;
         if(_loc3_ != null)
         {
            _loc3_.active();
            _loc3_.visible = false;
            this._petContentValue.addChild(_loc3_);
         }
         var _loc4_:Fighter;
         (_loc4_ = this.getRightTeam().mainFighter).active();
         this._petContentValue.addChild(_loc4_);
         var _loc5_:Fighter;
         if((_loc5_ = this.getRightTeam().subFighter) != null)
         {
            _loc5_.active();
            this._petContentValue.addChild(_loc5_);
         }
         this._scene.sortAllFighters();
      }
      
      private function createControlPanel() : void
      {
         this._contentValue = new Sprite();
         this._scene.mapModel.front.addChild(this._contentValue);
         DecorationControl._trunCount = 0;
         if(DecorationControl._isShowDecoration)
         {
            DecorationControl.start(this._contentValue);
         }
         this._controlPanel = this.creControl();
         if(ArenaUIIsNew.isNewUI == false)
         {
            this._controlPanel.x = 0;
            this._controlPanel.y = 513;
         }
         else
         {
            this._controlPanel.x = 246;
            this._controlPanel.y = 570;
         }
         this._contentValue.addChild(this._controlPanel);
         this._controlPanel.initPanelInfo(this._scene.arenaData);
         this._controlPanel.updateControlledFighter(this.getLeftTeam().mainFighter);
         if(this._scene.arenaData.fightMode == 3)
         {
            SptBossInfoManager.getSptBossInfo(this.SptBossInfoCallBack);
         }
      }
      
      protected function creControl() : *
      {
         if(ArenaUIIsNew.isNewUI == false)
         {
            return new FightControlPanel();
         }
         return new NewFightControlPanel();
      }
      
      private function SptBossInfoCallBack(param1:LittleEndianByteArray) : void
      {
         var _loc2_:uint = this._scene.rightTeam.teamInfo.fightUserInfoVec[0].fighterInfoVec[0].resourceId;
         var _loc3_:uint = SptBossInfoManager.resolveSpt(_loc2_,param1);
         if(_loc3_ < 2)
         {
            this._scene.arenaData.canCatchAfterSptDead = true;
         }
      }
      
      public function startSelectOperate() : void
      {
         ArenaUIIsNew.enableClick = true;
         this._operateFighters = new Vector.<Fighter>();
         this._operateFighters.push(this.getLeftTeam().mainFighter);
         if(this.getLeftTeam().subFighter != null)
         {
            this._operateFighters.push(this.getLeftTeam().subFighter);
         }
         this.fighterStartOperate(this._operateFighters.shift());
      }
      
      public function entryValue(param1:String) : void
      {
         this._fightPointPanel.entryValue(param1);
      }
      
      public function changeTeam(param1:String, param2:uint, param3:uint) : void
      {
         this._controlPanel.changeTeam(param1,param2,param3);
      }
      
      private function fighterStartOperate(param1:Fighter) : void
      {
         var fighter:Fighter = param1;
         var onChangeComplete:Function = function():void
         {
            _scene.sortAllFighters();
            activeControlSkillPanel(fighter);
            updateStatusPanelInfo();
            if(ArenaUIIsNew.isDeposit == false)
            {
               ArenaAnimationManager.showCountDown(_scene.fightMode,_controlPanel);
            }
            else
            {
               _controlPanel.automate();
            }
         };
         this._controlPanel.addEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         if(fighter.isDead() && this._scene.arenaData.isDoubleMode)
         {
            this.onOperateEnd(null);
            return;
         }
         if(this._scene.arenaData.isDoubleMode)
         {
            ArenaAnimationManager.showIndiator(fighter);
         }
         onChangeComplete();
      }
      
      private function activeControlSkillPanel(param1:Fighter) : void
      {
         this._controlPanel.updateControlledFighter(param1);
         this._controlPanel.showSkillPanel();
         this._controlPanel.active();
      }
      
      public function activeControlPetPanel(param1:Fighter) : void
      {
         this._controlPanel.updateControlledFighter(param1);
         this._controlPanel.showFighterPanel();
         this._controlPanel.active();
      }
      
      private function onOperateEnd(param1:OperateEvent) : void
      {
         var sendMessageOver:Function = null;
         var evt:OperateEvent = param1;
         sendMessageOver = function():void
         {
            fighterStartOperate(_operateFighters.shift());
         };
         ArenaUIIsNew.enableClick = false;
         this._controlPanel.removeEventListener(OperateEvent.OPERATE_END,this.onOperateEnd);
         ArenaAnimationManager.abortCountDown();
         if(this._scene.arenaData.isDoubleMode)
         {
            ArenaAnimationManager.hideIndiator();
         }
         if(this._operateFighters.length > 0)
         {
            this.sendMessage(evt,sendMessageOver);
         }
         else
         {
            this.sendMessage(evt);
            ArenaAnimationManager.showWaiting(this._scene.fightMode);
         }
      }
      
      private function sendMessage(param1:OperateEvent, param2:Function = null) : void
      {
         if(param1 != null)
         {
            this.sendOperateMessage(param1.operateType,param1.id,param1.fighterId,param2);
         }
         else
         {
            this.sendOperateMessage(OperateEvent.OPERATE_SKILL,0,0,param2);
         }
      }
      
      private function sendOperateMessage(param1:uint, param2:uint, param3:uint = 0, param4:Function = null) : void
      {
         if(param1 == OperateEvent.OPERATE_SKILL)
         {
            this.checkPetFitSkill(param2);
            if(DecorationControl._isShowDecoration)
            {
               DecorationControl.checkMC();
            }
         }
         else if(param1 == OperateEvent.OPERATE_ESCAPE)
         {
            new UseEscapeCMD().send();
         }
         else if(param1 == OperateEvent.OPERATE_FIGHTER)
         {
            new UseChangeCMD(param2).send();
         }
         else if(param1 == OperateEvent.OPERATE_ITEM_CATCH_PET)
         {
            new UseCapuleCMD(this,param2).send();
         }
         else if(param1 == OperateEvent.OPERATE_ITEM_USE_MEDICINE)
         {
            new UseItemCMD(this,param3,param2).send();
         }
         else if(param1 == OperateEvent.OPERATE_RESURRECTION)
         {
            new UseItemCMD(this,param3,param2).send();
         }
         if(param1 != OperateEvent.OPERATE_ESCAPE && param4 != null)
         {
            param4();
         }
      }
      
      private function checkPetFitSkill(param1:uint) : void
      {
         var _loc3_:Vector.<Fighter> = null;
         var _loc4_:Vector.<Fighter> = null;
         var _loc5_:Fighter = null;
         var _loc2_:PetFitDefinition = FitConfig.formSkillIdGetPetFitDefinition(param1);
         if(Boolean(_loc2_) && FitConfig.checkPetType(_loc2_))
         {
            if(this._scene.arenaData.isDoubleMode)
            {
               AlertManager.showAlert("双精灵对战情况下无法完成合体！");
               this.startSelectOperate();
               new UseSkillCMD(this.getLeftTeam().mainFighter.fighterInfo.skillInfoVec[0].id).send();
               return;
            }
            _loc3_ = Vector.<Fighter>([]);
            _loc4_ = Vector.<Fighter>([]);
            for each(_loc5_ in this.getLeftTeam().fighterVec)
            {
               if(_loc5_.fighterInfo.bunchId == _loc2_.fatherId && _loc5_.fighterInfo.hp > 0)
               {
                  _loc3_.push(_loc5_);
               }
               if(_loc5_.fighterInfo.bunchId == _loc2_.motherId && _loc5_.fighterInfo.hp > 0)
               {
                  _loc4_.push(_loc5_);
               }
            }
            if(_loc2_.fatherId != 0 && _loc3_.length <= 0 || _loc2_.motherId != 0 && _loc4_.length <= 0)
            {
               AlertManager.showAlert("合体条件不满足！");
               this.startSelectOperate();
               return;
            }
         }
         new UseSkillCMD(param1).send();
      }
      
      public function showFighterPanel() : void
      {
         this._controlPanel.showFighterPanel();
      }
      
      public function showSkillPanel() : void
      {
         this._controlPanel.showSkillPanel();
      }
      
      public function hideSkillPanel() : void
      {
         this._controlPanel.hideSkillPanel();
      }
      
      public function updateControlledFighter(param1:Fighter) : void
      {
         this._controlPanel.updateControlledFighter(param1);
      }
      
      public function updateOppositeFighter() : void
      {
         this._controlPanel.updateOppositeFighter();
      }
      
      public function itemPanelUpdate() : void
      {
         this._controlPanel.itemPanelUpdate();
      }
      
      private function createStatusPanel() : void
      {
         this._statusPanel = StatusPanelFactory.createStatusPanel(this._scene.arenaData);
         this._contentValue.addChild(this._statusPanel);
         this.updateStatusPanelInfo();
      }
      
      public function updateStatusPanelInfo() : void
      {
         this._statusPanel.updateFighters();
         this.updateStatusPanel();
         this.updatePetPress();
      }
      
      public function updateStatusPanel() : void
      {
         this._statusPanel.update();
      }
      
      public function updateAngerBar() : void
      {
         this._statusPanel.updateAngerBar();
      }
      
      public function updatePetPress() : void
      {
         this._statusPanel.updatePetPress();
      }
      
      public function showSkillBubble(param1:Fighter, param2:String) : void
      {
         this._statusPanel.showSkillBubble(param1,param2);
      }
      
      private function getLeftTeam() : FighterTeam
      {
         return this._scene.leftTeam;
      }
      
      private function getRightTeam() : FighterTeam
      {
         return this._scene.rightTeam;
      }
   }
}
