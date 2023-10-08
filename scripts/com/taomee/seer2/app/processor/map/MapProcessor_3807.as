package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.MouseEvent;
   
   public class MapProcessor_3807 extends MapProcessor
   {
       
      
      private const fightIdList:Vector.<uint> = Vector.<uint>([625,626,627,628,629,629,629,629,629,629,629]);
      
      private var _boss:Mobile;
      
      private var _currCount:uint;
      
      public function MapProcessor_3807(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         var maxSion:int = 0;
         super.init();
         maxSion = VipManager.vipInfo.isVip() ? 15 : 10;
         ActiveCountManager.requestActiveCount(203301,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var limitCount:uint = param2;
            DayLimitManager.getDoCount(834,function(param1:uint):void
            {
               var count:uint = param1;
               var ccount:uint = count > maxSion ? uint(maxSion) : count;
               maxSion += limitCount;
               var currSion:int = maxSion - ccount;
               if(currSion < 3)
               {
                  AlertManager.showAlert("神力不足3点，返回基地",function():void
                  {
                     SceneManager.changeScene(SceneType.LOBBY,70);
                  });
               }
               else
               {
                  ActiveCountManager.requestActiveCount(203309,function(param1:uint, param2:uint):void
                  {
                     var type:uint = param1;
                     var count:uint = param2;
                     _currCount = count;
                     if(count >= 10)
                     {
                        AlertManager.showAlert("已经连续战胜狼神10次，返回基地",function():void
                        {
                           SceneManager.changeScene(SceneType.LOBBY,70);
                        });
                     }
                     else
                     {
                        _boss = MobileManager.getMobile(636,MobileType.NPC);
                        _boss.addEventListener(MouseEvent.CLICK,onBoss);
                     }
                  });
               }
            });
         });
      }
      
      private function onBoss(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(636,"狼神",[[0,"我——莱曼萨尔！狼中之神！我无法接受失败，不过你已经连续打赢我了" + this._currCount + "次"]],["放狼过来！","妈妈我怕"],[function():void
         {
            if(isBagHave())
            {
               AlertManager.showConfirm("挑战我需要消耗3点神力，确认挑战吗?",function():void
               {
                  FightManager.startFightWithWild(fightIdList[_currCount]);
               });
            }
            else
            {
               AlertManager.showAlert("背包中必须携带一只狼妖才可挑战");
            }
         }]);
      }
      
      private function isBagHave() : Boolean
      {
         var _loc2_:PetInfo = null;
         var _loc1_:Boolean = false;
         for each(_loc2_ in PetInfoManager.getAllBagPetInfo())
         {
            if(_loc2_.resourceId == 269 || _loc2_.resourceId == 270 || _loc2_.resourceId == 271)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
   }
}
