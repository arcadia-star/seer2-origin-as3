package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.PathMobile;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_3803 extends MapProcessor
   {
       
      
      private const petIdList:Vector.<uint> = Vector.<uint>([523,534,524]);
      
      private const fightIdList:Vector.<uint> = Vector.<uint>([622,624,623]);
      
      private var _pathMobile:PathMobile;
      
      private var _currRan:uint;
      
      public function MapProcessor_3803(param1:MapModel)
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
               if(currSion < 1)
               {
                  AlertManager.showAlert("神力不足1点，返回基地",function():void
                  {
                     SceneManager.changeScene(SceneType.LOBBY,70);
                  });
               }
               else
               {
                  ActiveCountManager.requestActiveCount(203306,function(param1:uint, param2:uint):void
                  {
                     var type:uint = param1;
                     var count:uint = param2;
                     if(count >= 3)
                     {
                        AlertManager.showAlert("已经累计挑战胜利3次魔奇拉，返回基地",function():void
                        {
                           SceneManager.changeScene(SceneType.LOBBY,70);
                        });
                     }
                     else
                     {
                        _pathMobile = new PathMobile();
                        _currRan = getRan();
                        _pathMobile.resourceUrl = URLUtil.getPetSwf(petIdList[_currRan]);
                        MobileManager.addMobile(_pathMobile,MobileType.PET);
                        _pathMobile.setPostion(new Point(500,400));
                        _pathMobile.setPath(Vector.<Point>([new Point(500,400),new Point(445,469),new Point(527,318)]));
                        _pathMobile.buttonMode = true;
                        _pathMobile.addEventListener(MouseEvent.CLICK,onRole);
                     }
                  });
               }
            });
         });
      }
      
      private function onRole(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this.isBagHave())
         {
            AlertManager.showConfirm("挑战魔神需要消耗1点神力，确认挑战吗?",function():void
            {
               FightManager.startFightWithWild(fightIdList[_currRan]);
            });
         }
         else
         {
            AlertManager.showAlert("背包中必须携带一只狼妖才可挑战");
         }
      }
      
      private function getRan() : int
      {
         var _loc1_:Number = Math.random() * 100;
         if(_loc1_ < 50)
         {
            return 0;
         }
         if(_loc1_ < 90)
         {
            return 1;
         }
         return 2;
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
      
      override public function dispose() : void
      {
         if(this._pathMobile)
         {
            MobileManager.removeMobile(this._pathMobile,MobileType.PET);
         }
         super.dispose();
      }
   }
}
