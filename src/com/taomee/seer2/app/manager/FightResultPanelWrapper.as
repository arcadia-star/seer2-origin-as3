package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.data.FightResultInfo;
   import com.taomee.seer2.app.arena.data.RevenueInfo;
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.config.item.EmblemItemDefinition;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.UILoader;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class FightResultPanelWrapper extends EventDispatcher
   {
       
      
      private var _closeHandler:Function;
      
      private var _petInfoVec:Vector.<PetInfo>;
      
      private var _revenueInfo:RevenueInfo;
      
      private var _resultInfo:FightResultInfo;
      
      public function FightResultPanelWrapper(param1:Function = null)
      {
         super();
         this._closeHandler = param1;
      }
      
      public function show(param1:Vector.<PetInfo>, param2:RevenueInfo, param3:FightResultInfo) : void
      {
         this._petInfoVec = param1;
         this._revenueInfo = param2;
         this._resultInfo = param3;
         if(!FightUIManager.initialized)
         {
            this.initFightUI();
         }
         else
         {
            this.showResultPanel();
         }
      }
      
      private function initFightUI() : void
      {
         var onLoaded:Function = null;
         onLoaded = function(param1:ContentInfo):void
         {
            FightUIManager.setup(param1.content);
            showResultPanel();
         };
         UILoader.load(URLUtil.getUISwf("UI_Arena"),LoadType.DOMAIN,onLoaded);
      }
      
      private function showResultPanel() : void
      {
         var _loc1_:Object = new Object();
         _loc1_.petInfoVec = this._petInfoVec;
         _loc1_.revenueInfo = this._revenueInfo;
         _loc1_.resultInfo = this._resultInfo;
         _loc1_.fightMode = 0;
         _loc1_.closeHandler = this.onFightResultPanelClosed;
         _loc1_.delayTime = 0;
         ModuleManager.showModule(URLUtil.getAppModule("FightResultPanel"),"正在打开战斗结算面板...",_loc1_);
      }
      
      private function onFightResultPanelClosed() : void
      {
         this.updatePetInfo();
         if(this._closeHandler != null)
         {
            this._closeHandler();
            this._closeHandler = null;
         }
         this._petInfoVec = null;
         this._revenueInfo = null;
         this._resultInfo = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function updatePetInfo() : void
      {
         var _loc1_:uint = 0;
         var _loc6_:PetInfo = null;
         var _loc7_:int = 0;
         var _loc8_:PetInfo = null;
         var _loc2_:Vector.<PetInfo> = PetInfoManager.getTotalBagPetInfo();
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = int(this._resultInfo.changedPetInfoVec.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = this._resultInfo.changedPetInfoVec[_loc5_];
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc8_ = _loc2_[_loc7_];
               if(_loc6_.level > ActorManager.actorInfo.highestPetLevel)
               {
                  ActorManager.actorInfo.highestPetLevel = _loc6_.level;
               }
               if(_loc8_.catchTime == _loc6_.catchTime)
               {
                  PetInfo.updateBaseInfo(_loc8_,_loc6_);
                  _loc8_.learningInfo.pointUnused = _loc6_.learningInfo.pointUnused;
                  _loc8_.resourceId = _loc6_.resourceId;
                  _loc8_.skillInfo.updateSkillInfoVec(_loc6_.skillInfo.skillInfoVec);
                  _loc8_.skillInfo.addGainedSkillInfoVec(_loc6_.skillInfo.gainedSkillInfoVec);
                  PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE,_loc8_);
               }
               _loc7_++;
            }
            if(_loc6_.catchTime == this._resultInfo.gainedEmblemPetId)
            {
               _loc1_ = _loc6_.resourceId;
            }
            _loc5_++;
         }
         if(this._resultInfo.gainedEmblemPetId != 0)
         {
            this.showPetGainEmblemMessage(_loc1_,this._resultInfo.gainedEmblemPetId,this._resultInfo.gainedEmblemId);
         }
      }
      
      private function showPetGainEmblemMessage(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:PetInfo = PetInfoManager.getPetInfoFromBag(param2);
         var _loc5_:String = PetConfig.getPetDefinition(param1).name;
         if(_loc4_ != null)
         {
            _loc4_.emblemId = param3;
         }
         if(param3 == 0)
         {
            return;
         }
         var _loc6_:EmblemItemDefinition = ItemConfig.getEmblemDefinition(param3);
         var _loc7_:String = "";
         if(_loc6_ != null)
         {
            _loc7_ = _loc6_.name;
         }
         ServerMessager.addMessage(_loc5_ + "获得" + _loc7_ + "之力");
      }
   }
}
