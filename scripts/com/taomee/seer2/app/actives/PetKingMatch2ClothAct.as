package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.npc.NpcEvent;
   import com.taomee.seer2.app.npc.NpcManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class PetKingMatch2ClothAct
   {
      
      private static var _instance:com.taomee.seer2.app.actives.PetKingMatch2ClothAct;
       
      
      private const ARMY_ID:uint = 202997;
      
      private const MAP_IDS:Array = [450,60,1300];
      
      private const CHECK_IDS:Array = [100911,100916,100921];
      
      private const MOBILE_IDS:Array = [3,190,195];
      
      private const GET_DES:Array = ["领取水队队服","领取火队队服","领取草队队服"];
      
      private const NPC_NAME:Array = ["上尉门罗","金","上尉雷文"];
      
      private const NPC_DIA:Array = ["追求极致 勇者为王！你好！我的水队队员，我们将一起经历一场严酷的赛事！加油！","火赐予我们胜利的力量！你好！我的火队队员，我们将一起经历一场严酷的赛事！加油！","草原之力 助我问鼎！你好！我的草队队员，我们将一起经历一场严酷的赛事！加油"];
      
      private var army:uint;
      
      private var setIndex:int;
      
      private var currentNpcId:uint;
      
      private var npcdef:NpcDefinition;
      
      private var hasListener:Boolean = false;
      
      private var hasGet:Boolean;
      
      private var currMobile:Mobile;
      
      public function PetKingMatch2ClothAct()
      {
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.actives.PetKingMatch2ClothAct
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.actives.PetKingMatch2ClothAct();
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE,this.onActorArriveShow);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUnit);
         ModuleManager.removeEventListener("PetKingMatch2ClothPanel",ModuleEvent.DISPOSE,this.diposeModlue);
         this.hasListener = false;
         if(this.currMobile)
         {
            this.currMobile.removeOverHeadMark();
         }
      }
      
      public function setup() : void
      {
         if(this.army == 0)
         {
            ActiveCountManager.requestActiveCount(this.ARMY_ID,this.getArmy);
         }
         else
         {
            ItemManager.requestEquipList(this.getEquip);
         }
      }
      
      private function checkIsGetMap() : void
      {
         if(this.MAP_IDS[this.setIndex] != SceneManager.active.mapID)
         {
            return;
         }
         this.currMobile = MobileManager.getMobile(this.MOBILE_IDS[this.setIndex],MobileType.NPC);
         this.currMobile.removeOverHeadMark();
         this.currMobile.addOverHeadMark(new AcceptableMark());
         NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE,this.onActorArriveShow);
      }
      
      private function onActorArriveShow(param1:NpcEvent) : void
      {
         var _loc2_:XML = null;
         this.npcdef = param1.npcDefinition;
         if(this.hasGet)
         {
            this.npcdef.removeFunctionalityUnit(this.GET_DES[this.setIndex]);
            return;
         }
         if(this.npcdef.id == this.MOBILE_IDS[this.setIndex])
         {
            this.npcdef.resetFunctionalityData();
            _loc2_ = new XML("<node type=\"quest\" name=\"" + this.GET_DES[this.setIndex] + "\" params=\"getCloth\"/>");
            this.npcdef.addFunctionalityUnitAt(_loc2_,2);
            if(!this.hasListener)
            {
               DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUnit);
            }
         }
      }
      
      private function onUnit(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if(event.content.params == "getCloth")
         {
            this.currMobile.removeOverHeadMark();
            NpcDialog.show(this.MOBILE_IDS[this.setIndex],this.NPC_NAME[this.setIndex],[[0,this.NPC_DIA[this.setIndex]]],["领取队服","一会儿再来"],[function():void
            {
               ModuleManager.addEventListener("PetKingMatch2ClothPanel",ModuleEvent.DISPOSE,diposeModlue);
               ModuleManager.toggleModule(URLUtil.getAppModule("PetKingMatch2ClothPanel"),"",army);
            }]);
         }
      }
      
      private function diposeModlue(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("PetKingMatch2ClothPanel",ModuleEvent.DISPOSE,this.diposeModlue);
         ItemManager.requestEquipList(this.getEquip);
      }
      
      private function getArmy(param1:uint, param2:uint) : void
      {
         this.army = param2;
         if(this.army == 0)
         {
            return;
         }
         this.setIndex = this.army - 1;
         ItemManager.requestEquipList(this.getEquip);
      }
      
      private function getEquip() : void
      {
         this.hasGet = Boolean(ItemManager.getEquipItem(this.CHECK_IDS[this.setIndex]));
         if(this.hasGet)
         {
            return;
         }
         this.checkIsGetMap();
      }
   }
}
