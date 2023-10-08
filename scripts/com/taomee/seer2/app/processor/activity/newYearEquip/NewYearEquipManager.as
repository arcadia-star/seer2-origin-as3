package com.taomee.seer2.app.processor.activity.newYearEquip
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   
   public class NewYearEquipManager
   {
      
      private static const mapIdList:Vector.<uint> = Vector.<uint>([10,110,160,192,470,320,1210,302]);
      
      private static const npcIdList:Vector.<uint> = Vector.<uint>([1,16,23,31,45,56,315,107]);
      
      private static const npcNameList:Vector.<String> = Vector.<String>(["船长辛迪","神目酋长","神谕祭司","巴尔卡","吉吉导游","神爪财团老板","黑桃皇后","总督大人"]);
      
      private static var _index:int;
       
      
      public function NewYearEquipManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
      }
      
      private static function onComplete(param1:SceneEvent) : void
      {
         var _dayGetList:Array = null;
         var event:SceneEvent = param1;
         _index = mapIdList.indexOf(SceneManager.active.mapID);
         if(_index != -1 && QuestManager.isComplete(1) && QuestManager.isComplete(31))
         {
            _dayGetList = [];
            DayLimitManager.getDoCount(991,function(param1:uint):void
            {
               _dayGetList[0] = (param1 & 1) == 1;
               _dayGetList[1] = (param1 & 2) == 2;
               _dayGetList[2] = (param1 & 4) == 4;
               _dayGetList[3] = (param1 & 8) == 8;
               _dayGetList[4] = (param1 & 16) == 16;
               _dayGetList[5] = (param1 & 32) == 32;
               _dayGetList[6] = (param1 & 64) == 64;
               _dayGetList[7] = (param1 & 128) == 128;
               if(_dayGetList[_index] != true)
               {
                  DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,onDiaLogShow);
                  DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,onDiaLogShow);
               }
            });
         }
      }
      
      private static function onDiaLogShow(param1:DialogPanelEvent) : void
      {
         var _loc2_:CustomUnit = null;
         if(_index != -1 && param1.content == npcIdList[_index])
         {
            _loc2_ = new CustomUnit(FunctionalityType.ACTIVE,"（新年）恭喜发财~红包拿来~","gift");
            DialogPanel.functionalityBox.addUnit(_loc2_);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,onCustomUnitClick);
         }
      }
      
      private static function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var str:String;
         var event:DialogPanelEvent = param1;
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,onCustomUnitClick);
         str = DialogPanelEventData(event.content).params;
         if(str == "gift")
         {
            NpcDialog.show(npcIdList[_index],npcNameList[_index],[[0,"祝小赛尔们新年快乐！来~给红包~"]],["Happy new year!"],[function():void
            {
               SwapManager.swapItem(2411,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,onDiaLogShow);
                  if(Boolean(DialogPanel.functionalityBox) && Boolean(DialogPanel.functionalityBox.getUnit("恭喜发财~红包拿来")))
                  {
                     DialogPanel.functionalityBox.removeUnit(DialogPanel.functionalityBox.getUnit("恭喜发财~红包拿来"));
                  }
                  ModuleManager.toggleModule(URLUtil.getAppModule("NewYearEquipSwapPanel"),"正在打开...");
               },null,new SpecialInfo(1,_index));
            }]);
         }
      }
   }
}
