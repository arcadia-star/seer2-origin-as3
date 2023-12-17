package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.events.MouseEvent;
   
   public class MapProcessor_80169 extends MapProcessor
   {
       
      
      private const used_free_fight_chance:int = 203944;
      
      private const left_buyed_fight_chance:int = 203945;
      
      private const fight_chance_item_id:int = 603618;
      
      private const fight_index_1:int = 867;
      
      private const fight_index_2:int = 868;
      
      private var mobile:Mobile;
      
      private var mobile1:Mobile;
      
      private var leftNum:int;
      
      private var havePet:Boolean;
      
      private var fightIndex:int = 0;
      
      public function MapProcessor_80169(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.fightIndex = 0;
         PetInfoManager.getPetHaveState(0,[456],this.getPetState3);
         this.mobile = MobileManager.getMobile(734,MobileType.NPC);
         if(this.mobile)
         {
            this.mobile.buttonMode = true;
            this.mobile.addEventListener(MouseEvent.CLICK,this.onClick);
         }
         this.mobile1 = MobileManager.getMobile(735,MobileType.NPC);
         if(this.mobile1)
         {
            this.mobile1.buttonMode = true;
         }
      }
      
      private function getPetState3(param1:Array) : void
      {
         var _loc2_:int = 1;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_])
            {
               this.fightIndex = this.fight_index_1;
            }
            else
            {
               this.fightIndex = this.fight_index_2;
            }
            _loc2_++;
         }
      }
      
      private function checkIsInTime() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:int = _loc1_.fullYear;
         var _loc3_:int = _loc1_.month;
         var _loc4_:int = _loc1_.date;
         var _loc5_:int = _loc1_.hours;
         var _loc6_:int = _loc1_.minutes;
         var _loc7_:Boolean;
         if(_loc7_ = _loc2_ == 2014 && _loc3_ == 8 && _loc4_ == 30)
         {
            return true;
         }
         return false;
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(734,"太阳神阿波罗",[[0,"生命光轮不止，太阳神的荣耀与你同在！在战斗中燃烧光耀吧！（VIP全员战斗伤害加成+5%，年费VIP+10%，拥有太阳神之子米瑞尔进入弱化挑战）"]],["开始挑战","准备一下","加入VIP"],[function():void
         {
            ActiveCountManager.requestActiveCountList([203944,203945],function(param1:Parser_1142):void
            {
               leftNum = 3 - param1.infoVec[0] + param1.infoVec[1];
               if(leftNum > 0)
               {
                  if(checkIsInTime())
                  {
                     FightManager.startFightWithWild(fight_index_1);
                  }
                  else if(fightIndex != 0)
                  {
                     FightManager.startFightWithWild(fightIndex);
                  }
                  else
                  {
                     ServerMessager.addMessage("正在匹配请等待!");
                  }
               }
               else
               {
                  buyChance();
               }
            });
         },null,function():void
         {
            VipManager.navigateToPayPage();
         }]);
      }
      
      private function buyChance() : void
      {
         var _loc1_:BuyPropInfo = new BuyPropInfo();
         _loc1_.itemId = this.fight_chance_item_id;
         _loc1_.buyComplete = this.buyFightOver;
         ShopManager.buyVirtualItem(_loc1_);
      }
      
      private function buyFightOver(param1:*) : void
      {
         if(this.checkIsInTime())
         {
            FightManager.startFightWithWild(this.fight_index_1);
         }
         else
         {
            FightManager.startFightWithWild(this.fightIndex);
         }
      }
      
      override public function dispose() : void
      {
         if(this.mobile)
         {
            this.mobile.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         super.dispose();
      }
   }
}
