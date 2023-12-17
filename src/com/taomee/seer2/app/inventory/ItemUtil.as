package com.taomee.seer2.app.inventory
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.gameRule.door.atletico.Atletico50V50DoorSupport;
   import com.taomee.seer2.app.gameRule.door.atletico.AtleticoDoorSupport;
   import com.taomee.seer2.app.gameRule.door.binary.BinaryDoorSupport;
   import com.taomee.seer2.app.gameRule.door.hero.Hero50V50DoorSupport;
   import com.taomee.seer2.app.gameRule.door.hero.HeroDoorSupport;
   import com.taomee.seer2.app.gameRule.door.trails.Trail50V50DoorSupport;
   import com.taomee.seer2.app.gameRule.door.trails.TrailDoorSupport;
   import com.taomee.seer2.app.gameRule.door.warrior.Warrior50V50DoorSuport;
   import com.taomee.seer2.app.gameRule.door.warrior.WarriorDoorSuport;
   import com.taomee.seer2.app.inventory.constant.ItemCategory;
   import com.taomee.seer2.app.inventory.utils.ItemCategoryUtil;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertInitInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.popup.alert.AlertType;
   import com.taomee.seer2.core.scene.SceneManager;
   
   public class ItemUtil
   {
      
      private static var showServerGiven:Boolean = true;
      
      private static const COPY_TIP:Vector.<int> = Vector.<int>([500549,500554,500555,500561,500564,500570,500571]);
      
      private static const ITEM_ID_LIST:Vector.<uint> = Vector.<uint>([400188,400403,400411,400415]);
      
      private static const ITEM_NUM_DAY:Vector.<int> = Vector.<int>([422,957,972]);
      
      public static const SPECIAL_ITEM_ID_0:int = 200246;
      
      public static const SPECIAL_ITEM_ID_1:int = 200247;
       
      
      public function ItemUtil()
      {
         super();
      }
      
      private static function filterPetDoorRule(param1:ItemDescription, param2:int) : void
      {
         if(param2 == 400)
         {
            TrailDoorSupport.getInstance().getPetSimpleInfo(param1.time,param1.referenceId);
         }
         else if(param2 == 404)
         {
            WarriorDoorSuport.getInstance().getPetSimpleInfo(param1.time,param1.referenceId);
         }
         else if(param2 == 408)
         {
            AtleticoDoorSupport.getInstance().getPetSimpleInfo(param1.time,param1.referenceId);
         }
         else if(param2 == 416)
         {
            HeroDoorSupport.getInstance().getPetSimpleInfo(param1.time,param1.referenceId);
         }
         else if(param2 == 420 || param2 == 421)
         {
            BinaryDoorSupport.getInstance().getPetSimpleInfo(param1.time,param1.referenceId);
         }
         else
         {
            PetInfoManager.requestAddToBagFromStorage(param1.time,param1.referenceId);
         }
      }
      
      private static function filterItemDoorRule(param1:ItemDescription, param2:int) : void
      {
         var _loc3_:int = ItemCategoryUtil.findItemCategoryByReferenceId(param1.referenceId);
         if(param2 == 400)
         {
            TrailDoorSupport.getInstance().rewardId = param1.referenceId;
         }
         else if(param2 == 401)
         {
            if(_loc3_ == ItemCategory.EQUIP)
            {
               Trail50V50DoorSupport.getInstance().getEquipSimpleInfo(param1.referenceId);
            }
            else
            {
               Trail50V50DoorSupport.getInstance().rewardId = param1.referenceId;
            }
         }
         else if(param2 == 404)
         {
            WarriorDoorSuport.getInstance().rewardId = param1.referenceId;
         }
         else if(param2 == 405)
         {
            if(_loc3_ == ItemCategory.EQUIP)
            {
               Warrior50V50DoorSuport.getInstance().getEquipSimpleInfo(param1.referenceId);
            }
            else
            {
               Warrior50V50DoorSuport.getInstance().rewardId = param1.referenceId;
            }
         }
         else if(param2 == 408)
         {
            AtleticoDoorSupport.getInstance().rewardId = param1.referenceId;
         }
         else if(param2 == 409)
         {
            if(_loc3_ == ItemCategory.EQUIP)
            {
               Atletico50V50DoorSupport.getInstance().getEquipSimpleInfo(param1.referenceId);
            }
            else
            {
               Atletico50V50DoorSupport.getInstance().rewardId = param1.referenceId;
            }
         }
         else if(param2 == 416)
         {
            HeroDoorSupport.getInstance().rewardId = param1.referenceId;
            showServerGiven = false;
         }
         else if(param2 == 417)
         {
            if(_loc3_ == ItemCategory.EQUIP)
            {
               Hero50V50DoorSupport.getInstance().getEquipSimpleInfo(param1.referenceId);
            }
            else
            {
               Hero50V50DoorSupport.getInstance().rewardId = param1.referenceId;
               showServerGiven = false;
            }
         }
         else if(param2 == 420 || param2 == 421)
         {
            if(param1.referenceId != 12)
            {
               BinaryDoorSupport.getInstance().rewardId = param1.referenceId;
            }
            else
            {
               ServerMessager.addMessage("你获得了" + param1.quantity + "点训练师积分");
            }
            showServerGiven = false;
         }
         else if(COPY_TIP.indexOf(param1.referenceId) != -1)
         {
            showServerGiven = false;
         }
      }
      
      public static function upateServerGiven(param1:Vector.<ItemDescription>) : void
      {
         var itemDes:ItemDescription = null;
         var showItemDesVec:Vector.<ItemDescription> = null;
         var showItemDes:ItemDescription = null;
         var itemDesVec:Vector.<ItemDescription> = param1;
         var mapResourceID:int = int(SceneManager.active.mapResourceID);
         for each(itemDes in itemDesVec)
         {
            if(itemDes.isPet)
            {
               filterPetDoorRule(itemDes,mapResourceID);
            }
            else
            {
               filterItemDoorRule(itemDes,mapResourceID);
               updateItemDesLocal(itemDes);
            }
         }
         if(showServerGiven)
         {
            showItemDesVec = new Vector.<ItemDescription>();
            for each(showItemDes in itemDesVec)
            {
               if(showItemDes.isPet)
               {
                  continue;
               }
               if(showItemDes.referenceId > 603000 && showItemDes.referenceId <= 610000 || showItemDes.referenceId >= 400266 && showItemDes.referenceId <= 400268 || showItemDes.referenceId == 401067)
               {
                  if(showItemDes.isAdd)
                  {
                     ServerMessager.addMessage("恭喜你获得了" + showItemDes.quantity + "个[" + ItemConfig.getItemName(showItemDes.referenceId) + "]");
                  }
                  continue;
               }
               switch(showItemDes.referenceId)
               {
                  case 12:
                     ServerMessager.addMessage("你获得了" + showItemDes.quantity + "点训练师积分");
                     break;
                  case 15:
                     ServerMessager.addMessage("你获得了" + showItemDes.quantity + "荣誉点数");
                     break;
                  case 19:
                     ServerMessager.addMessage("你获得了NONO.3!");
                     break;
                  case 17:
                  case 500501:
                  case 500502:
                  case 500575:
                  case 500503:
                  case 500513:
                  case 601582:
                  case 601583:
                     break;
                  case SPECIAL_ITEM_ID_0:
                     ServerMessager.addMessage("恭喜！试炼通过！获得1份上忍经卷！继续挑战吧！");
                     break;
                  case SPECIAL_ITEM_ID_1:
                     ServerMessager.addMessage("很遗憾！试炼失败！送你1份鼓励经卷！再接再厉！");
                     break;
                  case 603001:
                     ServerMessager.addMessage("获得普通能源精华");
                     break;
                  case 603002:
                     ServerMessager.addMessage("获得水脉能源精华");
                     break;
                  case 603003:
                     ServerMessager.addMessage("获得火幻能源精华");
                     break;
                  case 603004:
                     ServerMessager.addMessage("获得草目能源精华");
                     break;
                  case 603005:
                     ServerMessager.addMessage("获得地月能源精华");
                     break;
                  case 603006:
                     ServerMessager.addMessage("获得沙爪能源精华");
                     break;
                  case 603007:
                     ServerMessager.addMessage("获得冰沁能源精华");
                     break;
                  case 500546:
                     ServerMessager.addMessage("次数增加1");
                     break;
                  case 500547:
                     ServerMessager.addMessage("次数增加1");
                     break;
                  case 500548:
                     ServerMessager.addMessage("次数增加1");
                     break;
                  case ITEM_ID_LIST[0]:
                     DayLimitManager.getDoCount(ITEM_NUM_DAY[0],function(param1:int):void
                     {
                        if(param1 >= 2000)
                        {
                           ServerMessager.addMessage("你获得了" + showItemDes.quantity + "块奖牌" + ",你今天已经获得了很多约瑟奖章，请明天再来吧。");
                        }
                        else
                        {
                           ServerMessager.addMessage("你获得了" + showItemDes.quantity + "块奖牌");
                        }
                     });
                     break;
                  case ITEM_ID_LIST[1]:
                     showItemDesVec.push(showItemDes);
                     DayLimitManager.getDoCount(ITEM_NUM_DAY[1],function(param1:int):void
                     {
                        if(param1 >= 10)
                        {
                           ServerMessager.addMessage("你今天已经获得了全部进化石，明天再继续吧。");
                        }
                     });
                     break;
                  case ITEM_ID_LIST[2]:
                     showItemDesVec.push(showItemDes);
                     DayLimitManager.getDoCount(ITEM_NUM_DAY[1],function(param1:int):void
                     {
                        if(param1 >= 10)
                        {
                           ServerMessager.addMessage("你今天已经获得了全部进化石，明天再继续吧。");
                        }
                     });
                     break;
                  case ITEM_ID_LIST[3]:
                     showItemDesVec.push(showItemDes);
                     DayLimitManager.getDoCount(ITEM_NUM_DAY[1],function(param1:int):void
                     {
                        if(param1 >= 10)
                        {
                           ServerMessager.addMessage("你今天已经获得了全部进化石，明天再继续吧。");
                        }
                     });
                     break;
                  default:
                     showItemDesVec.push(showItemDes);
                     break;
               }
            }
            showItemVec(showItemDesVec);
         }
         showServerGiven = true;
      }
      
      public static function updateLocal(param1:Vector.<ItemDescription>) : void
      {
         var _loc2_:ItemDescription = null;
         for each(_loc2_ in param1)
         {
            updateItemDesLocal(_loc2_);
         }
      }
      
      private static function updateItemDesLocal(param1:ItemDescription) : void
      {
         if(param1.isPet)
         {
            PetInfoManager.requestAddToBagFromStorage(param1.time,param1.referenceId);
         }
         else if(param1.isAdd)
         {
            switch(param1.referenceId)
            {
               case 1:
                  ActorManager.actorInfo.coins += param1.quantity;
                  break;
               case 12:
                  ActorManager.actorInfo.setTrainerScore(ActorManager.actorInfo.trainerScore + param1.quantity);
                  break;
               case 15:
                  ActorManager.actorInfo.honorNum += param1.quantity;
                  break;
               default:
                  ItemManager.addItem(param1.referenceId,param1.quantity,param1.time);
            }
         }
         else
         {
            switch(param1.referenceId)
            {
               case 1:
                  ActorManager.actorInfo.coins -= param1.quantity;
                  break;
               case 12:
                  ActorManager.actorInfo.setTrainerScore(ActorManager.actorInfo.trainerScore - param1.quantity);
                  break;
               case 15:
                  ActorManager.actorInfo.honorNum -= param1.quantity;
                  break;
               default:
                  ItemManager.reduceItemQuantity(param1.referenceId,param1.quantity);
            }
         }
      }
      
      public static function showItemVec(param1:Vector.<ItemDescription>) : void
      {
         var _loc2_:ItemDescription = null;
         for each(_loc2_ in param1)
         {
            if(!_loc2_.isPet && _loc2_.isAdd)
            {
               if(ItemCategoryUtil.isMedal(_loc2_.referenceId))
               {
                  AlertManager.showMedalGainedAlert(_loc2_.referenceId);
                  if(ItemConfig.getMedalDefinition(_loc2_.referenceId).title != "")
                  {
                     ServerMessager.addMessage("恭喜你获得了[" + ItemConfig.getMedalDefinition(_loc2_.referenceId).title + "称号]");
                  }
               }
               else if(ItemCategoryUtil.isEmblem(_loc2_.referenceId))
               {
                  ServerMessager.addMessage("恭喜你获得了[" + ItemConfig.getItemName(_loc2_.referenceId) + "]");
               }
               else if(ItemConfig.getItemCategory(_loc2_.referenceId) == ItemCategory.PET_SPIRT_TRAIN)
               {
                  AlertManager.showGetPetSpiritAlert(_loc2_.referenceId,_loc2_.quantity);
               }
               else
               {
                  AlertManager.showItemGainedAlert(_loc2_.referenceId,_loc2_.quantity);
               }
            }
            else if(_loc2_.isPet)
            {
               if(PetInfoManager.isBagFull() == true)
               {
                  AlertManager.showGetPetInStorageAlert(_loc2_.referenceId,_loc2_.quantity);
               }
               else
               {
                  AlertManager.showGetPetInBagAlert(_loc2_.referenceId,_loc2_.quantity);
               }
            }
         }
      }
      
      public static function showRandomReward(param1:String, param2:ItemGroup) : void
      {
         var _loc3_:AlertInitInfo = new AlertInitInfo("");
         _loc3_.category = param1;
         _loc3_.group = param2;
         AlertManager.showPopUp(AlertType.ITEMGROUPVIEW,_loc3_);
      }
   }
}
