package com.taomee.seer2.app.popup
{
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.inventory.ItemDescription;
   import com.taomee.seer2.app.inventory.constant.ItemCategory;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.popup.alert.*;
   import com.taomee.seer2.app.popup.alert.team.TeamApplyAlert;
   import com.taomee.seer2.app.popup.alert.team.TeamCommonAlert;
   import com.taomee.seer2.app.popup.alert.team.TeamCreComAlert;
   import com.taomee.seer2.app.popup.alert.team.TeamEntryAlert;
   import com.taomee.seer2.app.team.data.TeamMainInfo;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import seer2.next.fight.auto.AutoFightPanel;
   
   public class AlertManager
   {
      
      private static var _popList:Vector.<AlertInfo> = new Vector.<AlertInfo>();
      
      private static var _popFlag:Boolean = true;
      
      private static var _currAlert:IAlert;
       
      
      public function AlertManager()
      {
         super();
      }
      
      public static function blockPop() : void
      {
         _popFlag = false;
      }
      
      public static function releasePop() : void
      {
         _popFlag = true;
         nextShow();
      }
      
      public static function showPopUp(param1:uint, param2:AlertInitInfo = null, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc5_:AlertInfo;
         (_loc5_ = new AlertInfo()).alertType = param1;
         _loc5_.initInfo = param2;
         _loc5_.centralize = param3;
         _loc5_.isFocus = param4;
         _popList.push(_loc5_);
         if(_popFlag)
         {
            nextShow();
         }
      }
      
      public static function addPopUp(param1:AlertInfo, param2:IAlert) : void
      {
         if(param1.centralize == true)
         {
            proxy(param2);
         }
         LayerManager.topLayer.addChild(param2 as DisplayObject);
         if(param1.isFocus == true)
         {
            LayerManager.focusOnTopLayer();
         }
      }
      
      private static function proxy(param1:IAlert) : void
      {
         var _loc2_:* = LayerManager.root.stage.stageWidth - param1.width >> 1;
         var _loc3_:* = LayerManager.root.stage.stageHeight - param1.height >> 1;
         param1.x = _loc2_;
         param1.y = _loc3_;
      }
      
      public static function closeAllPopUp() : void
      {
         if(_currAlert != null)
         {
            _currAlert.removeEventListener(Event.CLOSE,onAlertClose);
            _currAlert.dispose();
            _currAlert = null;
            _popList.length = 0;
         }
      }
      
      public static function removePopUp(param1:DisplayObject, param2:Boolean = true) : void
      {
         DisplayObjectUtil.removeFromParent(param1 as DisplayObject);
         if(param2 == true)
         {
            LayerManager.resetOperation();
         }
      }
      
      private static function nextShow() : void
      {
         if(_popList.length == 0)
         {
            return;
         }
         var _loc1_:AlertInfo = _popList.shift() as AlertInfo;
         switch(_loc1_.alertType)
         {
            case AlertType.ALERT:
               _currAlert = new Alert();
               break;
            case AlertType.CONFIRM:
               _currAlert = new Confirm();
               break;
            case AlertType.AUTOCLOSE_ALERT:
               _currAlert = new AutoCloseAlert();
               break;
            case AlertType.ITEMGAINEDALERT:
               _currAlert = new ItemGainedAlert();
               _loc1_.isFocus = false;
               break;
            case AlertType.SPEICALITEMALERT:
               _currAlert = new ItemSpeialGainedAlert();
               _loc1_.isFocus = false;
               break;
            case AlertType.HONORALERT:
               _currAlert = new HonorAlert();
               _loc1_.isFocus = false;
               break;
            case AlertType.TEAM_COMMON_ALERT:
               _currAlert = new TeamCommonAlert();
               _loc1_.isFocus = false;
               break;
            case AlertType.TEAM_APPLY_ALERT:
               _currAlert = new TeamApplyAlert();
               _loc1_.isFocus = false;
               break;
            case AlertType.FAKEDOGZ:
               _currAlert = new FakeDogzAlert();
               break;
            case AlertType.COINSGAINEDALERT:
               _currAlert = new CoinsGainedAlert();
               _loc1_.isFocus = false;
               break;
            case AlertType.MEDALGAINEDALERT:
               _currAlert = new MedalGainedAlert();
               _loc1_.isFocus = false;
               break;
            case AlertType.PIGGYBANKALERT:
               _currAlert = new PiggyBankAlert();
               break;
            case AlertType.ITEMGROUPVIEW:
               _currAlert = new ItemGroupView();
               break;
            case AlertType.FISHINGALERT:
               _currAlert = new FishingAlert();
               break;
            case AlertType.STARTFISHINGALERT:
               _currAlert = new FishingStartAlert();
               break;
            case AlertType.DOOR_REWARD_ALERT:
               _currAlert = new DoorRewardAlert();
               break;
            case AlertType.DOORRESULTALERT:
               _currAlert = new DoorResultAlert();
               _loc1_.isFocus = false;
               break;
            case AlertType.INVITE_FIGHT_ALERT:
               _currAlert = new InviteFightAlert();
               break;
            case AlertType.INVITED_FIGHT_ALERT:
               _currAlert = new InvitedFightAlert();
               break;
            case AlertType.ITEM_MAX_ALERT:
               _currAlert = new ItemMaxAlert();
               _loc1_.isFocus = false;
               break;
            case AlertType.INDULGE:
               _currAlert = new IndulgeAlert();
               break;
            case AlertType.MONEY:
               _currAlert = new MoneyAlert();
               break;
            case AlertType.SELECT_PET:
               _currAlert = new SelectPetAlert();
               break;
            case AlertType.SELECT_ALL_PET:
               _currAlert = new SelectAllPetAlert();
               break;
            case AlertType.PET_BAG_SELECT_PET:
               _currAlert = new PetBagSelectPetAlert();
               break;
            case AlertType.GET_PET_IN_BAG:
               _currAlert = new GetPetInBagAlert();
               break;
            case AlertType.GET_PET_IN_STORAGE:
               _currAlert = new GetPetInStorageAlert();
               break;
            case AlertType.GET_PET_SPIRIT:
               _currAlert = new GetPetSpiritAlert();
               break;
            case AlertType.ENTRY_TEAM:
               _currAlert = new TeamEntryAlert();
               break;
            case AlertType.CRE_TEAM_COMPLETE:
               _currAlert = new TeamCreComAlert();
               break;
            case AlertType.DREAM_SYSTEM_ALERT:
               _currAlert = new DreamAlert();
               break;
            default:
               return;
         }
         _currAlert.addEventListener(Event.CLOSE,onAlertClose);
         _currAlert.show(_loc1_);
      }
      
      private static function onAlertClose(param1:Event) : void
      {
         if(_currAlert)
         {
            _currAlert.removeEventListener(Event.CLOSE,onAlertClose);
            _currAlert = null;
         }
         if(_popFlag)
         {
            nextShow();
         }
      }
      
      public static function get currAlert() : IAlert
      {
         return _currAlert;
      }
      
      public static function showInvitedFightAlert(param1:uint, param2:uint) : void
      {
         var _loc3_:AlertInitInfo = new AlertInitInfo("");
         _loc3_.userId = param1;
         _loc3_.mode = param2;
         showPopUp(AlertType.INVITED_FIGHT_ALERT,_loc3_);
      }
      
      public static function showInviteFightAlert(param1:uint) : void
      {
         var _loc2_:AlertInitInfo = new AlertInitInfo("");
         _loc2_.userId = param1;
         showPopUp(AlertType.INVITE_FIGHT_ALERT,_loc2_);
      }
      
      public static function showAlert(param1:String, param2:Function = null) : void
      {
         showPopUp(AlertType.ALERT,new AlertInitInfo(param1,param2));
      }
      
      public static function showIndulgeAlert(param1:String) : void
      {
         closeAllPopUp();
         if(AutoFightPanel.isRunning)
         {
            return;
         }
         showPopUp(AlertType.INDULGE,new AlertInitInfo(param1,null),true,false);
      }
      
      public static function showAutoCloseAlert(param1:String, param2:uint = 3, param3:Function = null) : void
      {
         showPopUp(AlertType.AUTOCLOSE_ALERT,new AlertInitInfo(param1,param3,null,null,param2));
      }
      
      public static function showConfirm(param1:String, param2:Function = null, param3:Function = null) : void
      {
         showPopUp(AlertType.CONFIRM,new AlertInitInfo(param1,null,param2,param3));
      }
      
      public static function showFishingStartAlert(param1:Function = null, param2:Function = null) : void
      {
         showPopUp(AlertType.STARTFISHINGALERT,new AlertInitInfo("",null,param1,param2));
      }
      
      public static function showFishingAlert(param1:uint, param2:Function = null, param3:Function = null) : void
      {
         var _loc4_:AlertInitInfo;
         (_loc4_ = new AlertInitInfo("",null,param2,param3)).referenceId = param1;
         showPopUp(AlertType.FISHINGALERT,_loc4_);
      }
      
      public static function showItemGainedAlert(param1:uint, param2:uint = 1, param3:Function = null, param4:String = "") : void
      {
         if(AutoFightPanel.isRunning)
         {
            return;
         }
         var _loc5_:AlertInitInfo;
         (_loc5_ = new AlertInitInfo(param4,param3)).referenceId = param1;
         _loc5_.quantity = param2;
         showPopUp(AlertType.ITEMGAINEDALERT,_loc5_);
      }
      
      public static function showGetPetInBagAlert(param1:uint, param2:uint = 1, param3:Function = null, param4:String = "") : void
      {
         var _loc5_:AlertInitInfo;
         (_loc5_ = new AlertInitInfo(param4,param3)).referenceId = param1;
         _loc5_.quantity = param2;
         showPopUp(AlertType.GET_PET_IN_BAG,_loc5_);
      }
      
      public static function showGetPetInStorageAlert(param1:uint, param2:uint = 1, param3:Function = null, param4:String = "") : void
      {
         var _loc5_:AlertInitInfo;
         (_loc5_ = new AlertInitInfo(param4,param3)).referenceId = param1;
         _loc5_.quantity = param2;
         showPopUp(AlertType.GET_PET_IN_STORAGE,_loc5_);
      }
      
      public static function showGetPetSpiritAlert(param1:uint, param2:uint = 1, param3:Function = null, param4:String = "") : void
      {
         var _loc5_:AlertInitInfo;
         (_loc5_ = new AlertInitInfo(param4,param3)).referenceId = param1;
         _loc5_.quantity = param2;
         showPopUp(AlertType.GET_PET_SPIRIT,_loc5_);
      }
      
      public static function showSpiecalItemGainedAlert(param1:uint, param2:uint = 1, param3:Function = null, param4:String = "") : void
      {
         var _loc5_:AlertInitInfo;
         (_loc5_ = new AlertInitInfo(param4,param3)).referenceId = param1;
         _loc5_.quantity = param2;
         showPopUp(AlertType.SPEICALITEMALERT,_loc5_);
      }
      
      public static function showItemMaxAlert(param1:uint, param2:uint = 1, param3:Function = null, param4:String = "") : void
      {
         var _loc5_:AlertInitInfo;
         (_loc5_ = new AlertInitInfo(param4,param3)).referenceId = param1;
         _loc5_.quantity = param2;
         showPopUp(AlertType.ITEM_MAX_ALERT,_loc5_);
      }
      
      public static function showHonorAlert(param1:uint, param2:uint, param3:Function = null) : void
      {
         var _loc4_:AlertInitInfo;
         (_loc4_ = new AlertInitInfo("",param3)).referenceId = param1;
         _loc4_.quantity = param2;
         showPopUp(AlertType.HONORALERT,_loc4_);
      }
      
      public static function showMedalGainedAlert(param1:uint, param2:Function = null) : void
      {
         var _loc3_:AlertInitInfo = new AlertInitInfo("",param2);
         _loc3_.referenceId = param1;
         showPopUp(AlertType.MEDALGAINEDALERT,_loc3_);
      }
      
      public static function showCoinsGainedAlert(param1:uint, param2:Function = null) : void
      {
         var _loc3_:AlertInitInfo = new AlertInitInfo("",param2);
         _loc3_.quantity = param1;
         showPopUp(AlertType.COINSGAINEDALERT,_loc3_);
      }
      
      public static function showPiggyBankAlert(param1:int, param2:Function = null) : void
      {
         var _loc3_:AlertInitInfo = new AlertInitInfo("",param2);
         _loc3_.quantity = param1;
         showPopUp(AlertType.PIGGYBANKALERT,_loc3_);
      }
      
      public static function showTeamCommonAlert(param1:String, param2:TeamMainInfo, param3:Function = null, param4:Function = null) : void
      {
         var _loc5_:AlertInitInfo;
         (_loc5_ = new AlertInitInfo(param1,null,param3,param4)).teamInfo = param2;
         showPopUp(AlertType.TEAM_COMMON_ALERT,_loc5_);
      }
      
      public static function showTeamApplyAlert(param1:String, param2:TeamMainInfo, param3:Function = null, param4:Function = null) : void
      {
         var _loc5_:AlertInitInfo;
         (_loc5_ = new AlertInitInfo(param1,null,param3,param4)).teamInfo = param2;
         showPopUp(AlertType.TEAM_APPLY_ALERT,_loc5_);
      }
      
      public static function showEntryTeamAlert(param1:Function = null, param2:Function = null) : void
      {
         var _loc3_:AlertInitInfo = new AlertInitInfo("",null,param1,param2);
         showPopUp(AlertType.ENTRY_TEAM,_loc3_);
      }
      
      public static function showTeamCreComAlert(param1:String, param2:Function = null) : void
      {
         showPopUp(AlertType.CRE_TEAM_COMPLETE,new AlertInitInfo(param1,null,param2));
      }
      
      public static function showDoorResult(param1:Boolean, param2:uint, param3:uint, param4:PetInfo = null, param5:uint = 0, param6:Function = null) : void
      {
         var _loc7_:AlertInitInfo;
         (_loc7_ = new AlertInitInfo("",param6)).result = param1;
         _loc7_.doorType = param2;
         _loc7_.doorRule = param3;
         _loc7_.petInfo = param4;
         _loc7_.equipId = param5;
         showPopUp(AlertType.DOORRESULTALERT,_loc7_);
      }
      
      public static function showDoorReward(param1:Boolean, param2:uint, param3:uint, param4:uint, param5:Vector.<ServerReward>, param6:Function = null) : void
      {
         var _loc7_:AlertInitInfo;
         (_loc7_ = new AlertInitInfo("",param6)).result = param1;
         _loc7_.doorType = param2;
         _loc7_.doorRule = param3;
         _loc7_.rewardId = param4;
         _loc7_.rewardList = param5;
         showPopUp(AlertType.DOOR_REWARD_ALERT,_loc7_);
      }
      
      public static function showFakeDogzAlert(param1:Function = null) : void
      {
         showPopUp(AlertType.FAKEDOGZ,new AlertInitInfo("",param1));
      }
      
      public static function showItemListGaindeAlert(param1:Vector.<ItemDescription>, param2:Function = null) : void
      {
         var _loc4_:ItemDescription = null;
         var _loc5_:AlertInitInfo = null;
         var _loc3_:Vector.<ItemDescription> = param1.slice();
         while(_loc3_.length > 0)
         {
            _loc4_ = _loc3_.shift();
            (_loc5_ = new AlertInitInfo("")).referenceId = _loc4_.referenceId;
            _loc5_.quantity = _loc4_.quantity;
            if(_loc3_.length == 0)
            {
               _loc5_.closeHandler = param2;
            }
            if(_loc5_.referenceId > 603000 && _loc5_.referenceId <= 605055 || _loc5_.referenceId >= 400266 && _loc5_.referenceId <= 400268 || _loc5_.referenceId == 401067)
            {
               ServerMessager.addMessage("恭喜你获得了" + _loc5_.quantity + "个[" + ItemConfig.getItemName(_loc5_.referenceId) + "]");
            }
            else if(ItemConfig.getItemCategory(_loc5_.referenceId) == ItemCategory.PET_SPIRT_TRAIN)
            {
               AlertManager.showGetPetSpiritAlert(_loc5_.referenceId,_loc5_.quantity);
            }
            else
            {
               showPopUp(AlertType.ITEMGAINEDALERT,_loc5_);
            }
         }
      }
      
      public static function showMoney(param1:Function = null, param2:Function = null) : void
      {
         showPopUp(AlertType.MONEY,new AlertInitInfo("",null,param1,param2));
      }
      
      public static function showMoneyOnly(param1:Function = null, param2:Function = null) : void
      {
         showPopUp(AlertType.MONEY,new AlertInitInfo("",null,param1,param2));
      }
      
      public static function showSelectAlert(param1:String, param2:Function, param3:Function = null) : void
      {
         showPopUp(AlertType.SELECT_PET,new AlertInitInfo(param1,null,param2,param3));
      }
      
      public static function showSelectAllAlert(param1:String, param2:Function, param3:Function = null) : void
      {
         showPopUp(AlertType.SELECT_ALL_PET,new AlertInitInfo(param1,null,param2,param3));
      }
      
      public static function showPetBagSelectAlert(param1:String, param2:Function, param3:Function = null) : void
      {
         showPopUp(AlertType.PET_BAG_SELECT_PET,new AlertInitInfo(param1,null,param2,param3));
      }
      
      public static function showDreamMiniAlert(param1:uint, param2:Function, param3:Function = null) : void
      {
         showPopUp(AlertType.DREAM_SYSTEM_ALERT,new AlertInitInfo(param1.toString(),null,param2,param3));
      }
   }
}
