package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.data.FightResultInfo;
   import com.taomee.seer2.app.arena.data.RevenueInfo;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1087;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.module.ModuleProxy;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class InitPetTrainingManager
   {
      
      public static const PET_TRAINING_STEP_COMPLETE:String = "initPetTrainingStepComplete";
      
      public static const INIT_PET_DIALOG_INFO:Array = [{
         "id":420,
         "name":"迪兰特"
      },{
         "id":421,
         "name":"休罗斯"
      },{
         "id":422,
         "name":"拉奥叶"
      }];
      
      private static var _eventDispatcher:EventDispatcher;
      
      private static var _fightResultPanelWrapper:com.taomee.seer2.app.manager.FightResultPanelWrapper;
      
      public static var currentStep:uint;
      
      {
         initialize();
      }
      
      public function InitPetTrainingManager()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _eventDispatcher = new EventDispatcher();
         PetInfoManager.addEventListener(PetInfoEvent.PET_EXPERENCE_CHANGE,onExperenceChange);
      }
      
      public static function addFightEndListener() : void
      {
         FightManager.addEventListener(FightStartEvent.START_SUCCESS,onStartSuccess);
      }
      
      public static function onStartSuccess() : void
      {
         FightManager.removeEventListener(FightStartEvent.START_SUCCESS,onStartSuccess);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapComplete);
      }
      
      private static function onMapComplete(param1:SceneEvent) : void
      {
         var _loc2_:* = false;
         if(SceneManager.active.type == SceneType.LOBBY)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onMapComplete);
            _loc2_ = FightManager.fightWinnerSide == 1;
            showTrainingPanel(_loc2_);
            if(_loc2_)
            {
               setTrainingStepComplete();
            }
         }
      }
      
      private static function showTrainingPanel(param1:Boolean) : void
      {
         var _loc2_:String = "InitPetTrainingPanel";
         if((param1 == false || currentStep != 5) && ModuleManager.getModuleStatus(_loc2_) != ModuleProxy.SHOW)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule(_loc2_),"正在打开主宠训练面板...",{"currentStep":currentStep});
         }
      }
      
      public static function setTrainingStepComplete() : void
      {
         var _loc1_:PetInfo = PetInfoManager.getFirstPetInfo();
         Connection.addCommandListener(CommandSet.INITPET_TRAINING_STEP_COMPLETE_1087,onTrainingStepComplete);
         Connection.send(CommandSet.INITPET_TRAINING_STEP_COMPLETE_1087,_loc1_.catchTime,currentStep);
      }
      
      private static function onExperenceChange(param1:PetInfoEvent) : void
      {
         var _loc2_:FightResultInfo = param1.content.resultInfo;
         var _loc3_:RevenueInfo = param1.content.revenueInfo;
         var _loc4_:uint;
         if((_loc4_ = _loc2_.changedPetInfoVec[0].level) == 100)
         {
            return;
         }
         if(_loc2_.endReason == PetExperenceHelper.INIT_PET_TRAIN)
         {
            _fightResultPanelWrapper = new com.taomee.seer2.app.manager.FightResultPanelWrapper();
            _fightResultPanelWrapper.addEventListener(Event.COMPLETE,onFightResultPanelClosed);
            _fightResultPanelWrapper.show(PetInfoManager.getAllBagPetInfo(),_loc3_,_loc2_);
         }
      }
      
      private static function onTrainingStepComplete(param1:MessageEvent) : void
      {
         var _loc2_:Parser_1087 = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         Connection.removeCommandListener(CommandSet.INITPET_TRAINING_STEP_COMPLETE_1087,onTrainingStepComplete);
         if(PetInfoManager.getFirstPetInfo().level == 100)
         {
            _loc2_ = new Parser_1087(param1.message.getRawData());
            _loc3_ = _loc2_.itemVec.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_loc2_.itemVec[_loc4_].itemId == 1)
               {
                  AlertManager.showCoinsGainedAlert(_loc2_.itemVec[_loc4_].itemCount);
               }
               else if(_loc2_.itemVec[_loc4_].itemId != 14)
               {
                  ItemManager.addItem(_loc2_.itemVec[_loc4_].itemId,_loc2_.itemVec[_loc4_].itemCount,0);
                  AlertManager.showItemGainedAlert(_loc2_.itemVec[_loc4_].itemId,_loc2_.itemVec[_loc4_].itemCount);
               }
               _loc4_++;
            }
            completeStep();
         }
      }
      
      private static function onFightResultPanelClosed(param1:Event) : void
      {
         _fightResultPanelWrapper.removeEventListener(Event.COMPLETE,onFightResultPanelClosed);
         _fightResultPanelWrapper = null;
         completeStep();
      }
      
      private static function completeStep() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = null;
         if(currentStep == 5)
         {
            _loc1_ = (PetInfoManager.getFirstPetInfo().resourceId - 1) / 3;
            _loc2_ = "恭喜你，今天" + PetInfoManager.getFirstPetInfo().name + "完成了所有训练，请明天再来~";
            NpcDialog.show(INIT_PET_DIALOG_INFO[_loc1_].id,INIT_PET_DIALOG_INFO[_loc1_].name,[[0,_loc2_]],["好的，我知道了！"]);
         }
         else
         {
            dispatchInitTrainingEvent(PET_TRAINING_STEP_COMPLETE);
         }
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function dispatchInitTrainingEvent(param1:String) : void
      {
         if(_eventDispatcher.hasEventListener(param1))
         {
            _eventDispatcher.dispatchEvent(new Event(param1));
         }
      }
   }
}
