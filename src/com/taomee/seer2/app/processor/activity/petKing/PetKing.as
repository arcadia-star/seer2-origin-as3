package com.taomee.seer2.app.processor.activity.petKing
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.BaseUnit;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PetKing
   {
      
      private static const questList:Array = [[10094,10095],[10096,10097],[10098,10099]];
      
      private static var _currQuestList:Array;
       
      
      private var _voting:uint;
      
      private var _npc:Mobile;
      
      private var _unit:BaseUnit;
      
      private var _npcID:uint = 0;
      
      public function PetKing(param1:uint = 0)
      {
         super();
         this._npcID = param1;
         this.init();
      }
      
      private static function getItemQuest() : uint
      {
         if(ItemManager.getSpecialItem(500508) != null)
         {
            return 1;
         }
         if(ItemManager.getSpecialItem(500509) != null)
         {
            return 2;
         }
         if(ItemManager.getSpecialItem(500510) != null)
         {
            return 3;
         }
         return 0;
      }
      
      public static function acceptQuest() : void
      {
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,onstatisCount);
         ItemManager.requestSpecialItemList();
      }
      
      private static function onstatisCount(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,onstatisCount);
         if(getItemQuest() == 0)
         {
            return;
         }
         _currQuestList = questList[getItemQuest() - 1];
         if(QuestManager.isCanAccepted(_currQuestList[0]))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
            QuestManager.accept(_currQuestList[0]);
         }
         else if(QuestManager.isCanAccepted(_currQuestList[1]))
         {
            QuestManager.accept(_currQuestList[1]);
         }
      }
      
      private static function onAccept(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,onAccept);
         if(QuestManager.isCanAccepted(_currQuestList[1]))
         {
            QuestManager.accept(_currQuestList[1]);
         }
      }
      
      private function init() : void
      {
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onCount);
         ItemManager.requestSpecialItemList();
      }
      
      private function onCount(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onCount);
         if(this._npcID == 0)
         {
            return;
         }
         this._npc = MobileManager.getMobile(this._npcID,MobileType.NPC);
         if(this.getItem() == 0)
         {
            this._npc.addEventListener(MouseEvent.CLICK,this.onClick,false,1);
         }
         else
         {
            DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
            this._npc.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onDialogShow(param1:DialogPanelEvent) : void
      {
         if(param1.content == this._npcID)
         {
            _currQuestList = questList[getItemQuest() - 1];
            if(QuestManager.isComplete(_currQuestList[0]) && QuestManager.isComplete(_currQuestList[1]))
            {
               this._unit = DialogPanel.functionalityBox.getUnit("制作战袍");
               if(Boolean(this._unit) && Boolean(this._unit.parent))
               {
                  DialogPanel.functionalityBox.removeUnit(this._unit);
               }
               else if(DialogPanel.functionalityBox.hasEventListener(Event.ENTER_FRAME) == false)
               {
                  DialogPanel.functionalityBox.addEventListener(Event.ENTER_FRAME,this.onFrame);
               }
            }
         }
      }
      
      private function onFrame(param1:Event) : void
      {
         this._unit = DialogPanel.functionalityBox.getUnit("制作战袍");
         if(Boolean(this._unit) && Boolean(this._unit.parent))
         {
            DialogPanel.functionalityBox.removeUnit(this._unit);
            DialogPanel.functionalityBox.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:Object = new Object();
         _loc2_.cookbook = this.init;
         ModuleManager.toggleModule(URLUtil.getAppModule("PetKingMatchPanel"),"正在打开面板...",_loc2_);
      }
      
      public function dispose() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onClick);
            this._npc = null;
         }
         DialogPanel.functionalityBox.removeEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function getItem() : uint
      {
         if(ItemManager.getSpecialItem(500508) != null)
         {
            return 1;
         }
         if(ItemManager.getSpecialItem(500509) != null)
         {
            return 2;
         }
         if(ItemManager.getSpecialItem(500510) != null)
         {
            return 3;
         }
         return 0;
      }
   }
}
