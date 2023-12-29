package com.taomee.seer2.app.inventory
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.config.EquipElementConfig;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.inventory.constant.ItemCategory;
   import com.taomee.seer2.app.inventory.constant.ItemIdRange;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.inventory.item.CollectionItem;
   import com.taomee.seer2.app.inventory.item.EmblemItem;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.app.inventory.item.MedalItem;
   import com.taomee.seer2.app.inventory.item.PetItem;
   import com.taomee.seer2.app.inventory.item.PetSpirtTrainItem;
   import com.taomee.seer2.app.inventory.item.SpecialItem;
   import com.taomee.seer2.app.inventory.utils.ItemCategoryUtil;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1051;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
   import com.taomee.seer2.core.inventory.Item;
   import com.taomee.seer2.core.log.Logger;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.IDataInput;
   import org.taomee.bean.BaseBean;
   import org.taomee.ds.HashMap;
   
   public class ItemManager extends BaseBean
   {
      
      private static var _logger:Logger;
      
      private static var _hasGetEquip:Boolean;
      
      private static var _hasGetItem:Boolean;
      
      private static var _hasGetSpecialItem:Boolean;
      
      private static var _requestItemCallBack:Function;
      
      private static var _requestEquipCallBack:Function;
      
      private static var _isLoadingData:Boolean;
      
      private static var _evtRemoter:EventDispatcher;
      
      private static var _inventory:SeerIIInventory;
      
      private static var _specialItemMap:HashMap;
      
      private static const HOLD_CMD_FOR_ITEM_GIVEN_ARR:Array = [1123,1162,1055,1140];
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      private static var _success:Function;
       
      
      public function ItemManager()
      {
         super();
      }
      
      public static function setup() : void
      {
      }
      
      public static function canAddItem(param1:Item) : Boolean
      {
         return _inventory.canAddItem(param1);
      }
      
      public static function removeItemByReferenceId(param1:int) : void
      {
         _inventory.removeItemByReferenceId(param1);
      }
      
      public static function reduceItemQuantity(param1:int, param2:int) : void
      {
         if(ItemCategoryUtil.findItemCategoryByReferenceId(param1) == ItemCategory.SPECIAL_ITEM)
         {
            reduceSpecialItem(param1,param2);
         }
         else
         {
            _inventory.reduceItemQuantity(param1,param2);
         }
      }
      
      public static function contains(param1:Item) : Boolean
      {
         return _inventory.contains(param1);
      }
      
      public static function containsReferenceId(param1:int) : Boolean
      {
         return _inventory.containsUniqueId(param1);
      }
      
      public static function getItemByReferenceId(param1:int) : Item
      {
         return _inventory.getItemByUniqueId(param1);
      }
      
      public static function getItemQuantityByReferenceId(param1:int) : int
      {
         return _inventory.getItemQuantityByUniqueId(param1);
      }
      
      public static function getContent() : Vector.<Item>
      {
         return _inventory.getContent();
      }
      
      public static function getItemArr() : Array
      {
         return _inventory.getItemArr();
      }
      
      public static function addEquipItem(param1:EquipItem) : void
      {
         _inventory.addEquipItem(param1);
      }
      
      public static function removeEquipItem(param1:EquipItem) : void
      {
         _inventory.removeEquip(param1);
      }
      
      public static function getEquipVec() : Vector.<EquipItem>
      {
         return _inventory.getEquipVec();
      }
      
      public static function getEquipItem(param1:int) : EquipItem
      {
         return _inventory.getEquipItem(param1);
      }
      
      public static function addPetItem(param1:PetItem) : void
      {
         _inventory.addPetItem(param1);
      }
      
      public static function removePetItem(param1:PetItem) : void
      {
         _inventory.removePetItem(param1);
      }
      
      public static function getPetRelateVec() : Vector.<PetItem>
      {
         return _inventory.getPetRelateVec();
      }
      
      public static function getPetRelateitem(param1:int) : PetItem
      {
         return _inventory.getPetRelateItem(param1);
      }
      
      public static function addEmblemItem(param1:EmblemItem) : void
      {
         _inventory.addEmblemItem(param1);
      }
      
      public static function removeEmblemItem(param1:EmblemItem) : void
      {
         _inventory.removeEmblemItem(param1);
      }
      
      public static function getEmblemVec() : Vector.<EmblemItem>
      {
         return _inventory.getEmblemVec();
      }
      
      public static function addCollectionItem(param1:CollectionItem) : void
      {
         _inventory.addCollectionItem(param1);
      }
      
      public static function removeCollectionItem(param1:CollectionItem) : void
      {
         _inventory.removeCollectionItem(param1);
      }
      
      public static function addPetSpirtTrainItem(param1:PetSpirtTrainItem) : void
      {
         _inventory.addPetSpirtTrainItem(param1);
      }
      
      public static function removePetSpirtTrainItem(param1:PetSpirtTrainItem) : void
      {
         _inventory.removePetSpirtTrainItem(param1);
      }
      
      public static function getCollectionVec() : Vector.<CollectionItem>
      {
         return _inventory.getCollectionVec();
      }
      
      public static function getCollection(param1:uint) : CollectionItem
      {
         return _inventory.getCollection(param1);
      }
      
      public static function getPetSpirtTrainVec() : Vector.<PetSpirtTrainItem>
      {
         return _inventory.getPetSpirtTrainVec();
      }
      
      public static function getPetSpirtTrain(param1:uint) : PetSpirtTrainItem
      {
         return _inventory.getPetSpirtTrain(param1);
      }
      
      public static function addMedalItem(param1:MedalItem) : void
      {
         _inventory.addMedalItem(param1);
      }
      
      public static function removeMedalItem(param1:MedalItem) : void
      {
         _inventory.removeMedalItem(param1);
      }
      
      public static function getMedalVec() : Vector.<MedalItem>
      {
         return _inventory.getMedalVec();
      }
      
      public static function addSpecialItem(param1:SpecialItem) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:SpecialItem = null;
         if(getSpecialItem(param1.referenceId) == null)
         {
            _specialItemMap.add(param1.referenceId,param1);
         }
         else
         {
            _loc2_ = getSpecialItem(param1.referenceId).quantity;
            _loc3_ = _loc2_ + param1.quantity;
            _loc4_ = param1;
            _specialItemMap.remove(param1.referenceId);
            _loc4_.quantity = _loc3_;
            _specialItemMap.add(_loc4_.referenceId,_loc4_);
         }
      }
      
      public static function reduceSpecialItem(param1:uint, param2:uint) : void
      {
         if(Boolean(_specialItemMap.containsKey(param1)) && _specialItemMap.getValue(param1).quantity > param2)
         {
            _specialItemMap.getValue(param1).quantity = _specialItemMap.getValue(param1).quantity - param2;
         }
         else if(_specialItemMap.containsKey(param1))
         {
            _specialItemMap.remove(param1);
         }
      }
      
      public static function removeSpecialItem(param1:uint) : void
      {
         _specialItemMap.remove(param1);
      }
      
      public static function getSpecialItem(param1:uint) : SpecialItem
      {
         return _specialItemMap.getValue(param1);
      }
      
      public static function getSpecialItemVec() : Vector.<SpecialItem>
      {
         return Vector.<SpecialItem>(_specialItemMap.getValues());
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _evtRemoter.addEventListener(param1,param2);
         _inventory.addEventListener(param1,onInventoryEvent);
      }
      
      private static function onInventoryEvent(param1:Event) : void
      {
         if(_isLoadingData == false)
         {
            _evtRemoter.dispatchEvent(param1.clone());
         }
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         _evtRemoter.removeEventListener(param1,param2);
         _inventory.removeEventListener(param1,onInventoryEvent);
      }
      
      public static function requestSpecialItemList(param1:Boolean = false) : void
      {
         if(!param1)
         {
            if(_hasGetSpecialItem == true)
            {
               ItemManager.dispatchEvent(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,null);
            }
            else
            {
               _isLoadingData = true;
               Connection.addCommandListener(CommandSet.ITEM_GET_LIST_1005,onGetSpecialItemList);
               Connection.send(CommandSet.ITEM_GET_LIST_1005,ItemIdRange.SPECIAL_ITEM[0],ItemIdRange.SPECIAL_ITEM[1]);
            }
         }
         else
         {
            _isLoadingData = true;
            Connection.addCommandListener(CommandSet.ITEM_GET_LIST_1005,onGetSpecialItemList);
            Connection.send(CommandSet.ITEM_GET_LIST_1005,ItemIdRange.SPECIAL_ITEM[0],ItemIdRange.SPECIAL_ITEM[1]);
         }
      }
      
      private static function onGetSpecialItemList(param1:MessageEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         Connection.removeCommandListener(CommandSet.ITEM_GET_LIST_1005,onGetSpecialItemList);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = int(_loc2_.readUnsignedInt());
            _loc6_ = int(_loc2_.readUnsignedShort());
            _loc7_ = uint(_loc2_.readUnsignedInt());
            addSpecial(new SpecialItem(_loc5_,_loc6_,_loc7_));
            _loc4_++;
         }
         _isLoadingData = false;
         _hasGetSpecialItem = true;
         ItemManager.dispatchEvent(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,null);
      }
      
      private static function addSpecial(param1:SpecialItem) : void
      {
         if(getSpecialItem(param1.referenceId) == null)
         {
            _specialItemMap.add(param1.referenceId,param1);
         }
         else
         {
            _specialItemMap.remove(param1.referenceId);
            _specialItemMap.add(param1.referenceId,param1);
         }
      }
      
      public static function requestItemList(param1:Function, param2:Boolean = false) : void
      {
         _requestItemCallBack = param1;
         if(_hasGetItem == true && !param2)
         {
            if(_requestItemCallBack != null)
            {
               _requestItemCallBack();
               _requestItemCallBack = null;
            }
            ItemManager.dispatchEvent(ItemEvent.REQUEST_ITEM_SUCCESS,null);
         }
         else
         {
            _isLoadingData = true;
            Connection.addCommandListener(CommandSet.ITEM_GET_LIST_1005,onGetItemList);
            Connection.send(CommandSet.ITEM_GET_LIST_1005,ItemIdRange.PET_RELATE[0],ItemIdRange.MEDAL[1]);
         }
      }
      
      private static function onGetItemList(param1:MessageEvent) : void
      {
         var data:IDataInput;
         var count:int;
         var i:int;
         var referenceId:int = 0;
         var quantity:int = 0;
         var expiryTime:uint = 0;
         var event:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.ITEM_GET_LIST_1005,onGetItemList);
         _inventory.clearItem();
         data = event.message.getRawData();
         count = int(data.readUnsignedInt());
         i = 0;
         while(i < count)
         {
            referenceId = int(data.readUnsignedInt());
            quantity = int(data.readUnsignedShort());
            expiryTime = uint(data.readUnsignedInt());
            addItem(referenceId,quantity,expiryTime);
            i++;
         }
         Connection.addCommandListener(CommandSet.ITEM_GET_LIST_1005,function getPetSpirtTrain(param1:MessageEvent):void
         {
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc7_:uint = 0;
            Connection.removeCommandListener(CommandSet.ITEM_GET_LIST_1005,getPetSpirtTrain);
            var _loc2_:IDataInput = param1.message.getRawData();
            var _loc3_:int = int(_loc2_.readUnsignedInt());
            var _loc4_:int = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc6_ = int(_loc2_.readUnsignedShort());
               _loc7_ = uint(_loc2_.readUnsignedInt());
               addItem(_loc5_,_loc6_,_loc7_);
               _loc4_++;
            }
            _isLoadingData = false;
            _hasGetItem = true;
            if(_requestItemCallBack != null)
            {
               _requestItemCallBack();
               _requestItemCallBack = null;
            }
            ItemManager.dispatchEvent(ItemEvent.REQUEST_ITEM_SUCCESS,null);
         });
         Connection.send(CommandSet.ITEM_GET_LIST_1005,ItemIdRange.PET_SPIRT_TRAIN[0],ItemIdRange.PET_SPIRT_TRAIN[1]);
      }
      
      public static function requestAddItem(param1:int, param2:int) : void
      {
         Connection.addCommandListener(CommandSet.ITEM_ADD_1006,onRequestAddItemSuccess);
         Connection.addErrorHandler(CommandSet.ITEM_ADD_1006,onRequestAddItemFail);
         Connection.send(CommandSet.ITEM_ADD_1006,param1,LittleEndianByteArray.writeIntergerAsUnsignedShort(param2));
         MapPanelProtocolPanel.instance().buyID = param1;
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.MIBUY_ID,"购买协议： " + CommandSet.ITEM_ADD_1006.toString() + " buyID=" + param1);
      }
      
      private static function onRequestAddItemFail(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ITEM_ADD_1006,onRequestAddItemSuccess);
         Connection.removeErrorHandler(CommandSet.ITEM_ADD_1006,onRequestAddItemFail);
         switch(param1.message.statusCode)
         {
            case 66:
               AlertManager.showAlert("达到每天的上限");
               break;
            default:
               AlertManager.showAlert("购买失败");
         }
         dispatchEvent(ItemEvent.REQUEST_ADD_ITEM_FAIL,null);
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.MIBUY_ID,"购买协议： buyID=" + MapPanelProtocolPanel.instance().buyID + " 购买失败");
      }
      
      private static function onRequestAddItemSuccess(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ITEM_ADD_1006,onRequestAddItemSuccess);
         Connection.removeErrorHandler(CommandSet.ITEM_ADD_1006,onRequestAddItemFail);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = int(_loc2_.readUnsignedShort());
         var _loc5_:uint = uint(_loc2_.readUnsignedInt());
         AlertManager.showItemGainedAlert(_loc3_,_loc4_);
         addItem(_loc3_,_loc4_,_loc5_);
         var _loc6_:uint = uint(_loc2_.readUnsignedInt());
         var _loc7_:UserInfo;
         (_loc7_ = ActorManager.actorInfo).coins = _loc6_;
         dispatchEvent(ItemEvent.REQUEST_ADD_ITEM_SUCCESS,_loc3_);
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.MIBUY_ID,"购买协议： buyID=" + MapPanelProtocolPanel.instance().buyID + " 购买成功");
      }
      
      public static function addItemList(param1:Vector.<ItemDescription>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            addItem(param1[_loc2_].referenceId,param1[_loc2_].quantity,param1[_loc2_].time);
            _loc2_++;
         }
      }
      
      public static function addItem(param1:uint, param2:int, param3:uint, param4:uint = 0) : void
      {
         var _loc5_:int = ItemCategoryUtil.findItemCategoryByReferenceId(param1);
         switch(_loc5_)
         {
            case ItemCategory.EQUIP:
               addEquipItem(new EquipItem(param1,false,param3,param4));
               break;
            case ItemCategory.PET_RELATE:
               addPetItem(new PetItem(param1,param2,param3,param4));
               break;
            case ItemCategory.EMBLEM:
               addEmblemItem(new EmblemItem(param1,param2,param3,param4));
               break;
            case ItemCategory.COLLECTION:
               addCollectionItem(new CollectionItem(param1,param2,param3,param4));
               break;
            case ItemCategory.MEDAL:
               addMedalItem(new MedalItem(param1,param2,param3,param4));
               break;
            case ItemCategory.SPECIAL_ITEM:
               addSpecialItem(new SpecialItem(param1,param2,param3,param4));
               break;
            case ItemCategory.PET_SPIRT_TRAIN:
               addPetSpirtTrainItem(new PetSpirtTrainItem(param1,param2,param3,param4));
         }
      }
      
      public static function requestReduceItemQuantity(param1:int, param2:int) : void
      {
         Connection.addCommandListener(CommandSet.ITEM_REMOVE_1009,onReduceItemQuantity);
         Connection.send(CommandSet.ITEM_REMOVE_1009,param1,LittleEndianByteArray.writeIntergerAsUnsignedShort(param2));
      }
      
      private static function onReduceItemQuantity(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ITEM_REMOVE_1009,onReduceItemQuantity);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = int(_loc2_.readUnsignedShort());
         reduceItemQuantity(_loc3_,_loc4_);
         var _loc5_:uint = uint(_loc2_.readUnsignedInt());
         var _loc6_:UserInfo;
         (_loc6_ = ActorManager.actorInfo).coins = _loc5_;
         dispatchEvent(ItemEvent.ITEM_SELLOUT,_loc3_);
      }
      
      public static function requestEquipList(param1:Function, param2:Boolean = false) : void
      {
         _requestEquipCallBack = param1;
         if(_hasGetEquip && param2 == false)
         {
            handlerEquipCallBack();
         }
         else
         {
            _isLoadingData = true;
            Connection.addCommandListener(CommandSet.EQUIP_GET_LIST_1007,onGetEquipList);
            Connection.send(CommandSet.EQUIP_GET_LIST_1007,ItemIdRange.EQUIP[0],ItemIdRange.EQUIP[1]);
         }
      }
      
      private static function onGetEquipList(param1:MessageEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = false;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:EquipItem = null;
         Connection.removeCommandListener(CommandSet.EQUIP_GET_LIST_1007,onGetEquipList);
         _inventory.clearEquip();
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = int(_loc2_.readUnsignedInt());
            _loc6_ = _loc2_.readUnsignedByte() == 1;
            _loc7_ = uint(_loc2_.readUnsignedInt());
            _loc8_ = uint(_loc2_.readUnsignedInt());
            (_loc9_ = new EquipItem(_loc5_,_loc6_,_loc7_)).strengLevel = _loc8_;
            _loc9_.elementInfo = EquipElementConfig.getInfo(_loc5_);
            addEquipItem(_loc9_);
            _loc4_++;
         }
         _isLoadingData = false;
         _hasGetEquip = true;
         handlerEquipCallBack();
      }
      
      private static function handlerEquipCallBack() : void
      {
         if(_requestEquipCallBack != null)
         {
            _requestEquipCallBack();
            _requestEquipCallBack = null;
         }
         ItemManager.dispatchEvent(ItemEvent.REQUEST_EQUIP_SUCCESS,null);
      }
      
      public static function get hasGetItem() : Boolean
      {
         return _hasGetItem;
      }
      
      public static function get hasGetEquip() : Boolean
      {
         return _hasGetEquip;
      }
      
      private static function onGetConis(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         ServerMessager.addMessage("获得了" + _loc3_ + "赛尔豆");
         ActorManager.actorInfo.coins += _loc3_;
      }
      
      private static function onItemServerGiven(param1:MessageEvent) : void
      {
         var _loc3_:Vector.<ItemDescription> = null;
         var _loc4_:ItemDescription = null;
         var _loc2_:Parser_1051 = new Parser_1051(param1.message.getRawDataCopy());
         if(HOLD_CMD_FOR_ITEM_GIVEN_ARR.indexOf(_loc2_.cmdId) != -1)
         {
            ItemUtil.updateLocal(_loc2_.itemDes);
            dispatchEvent(ItemEvent.SERVER_ITEM_GIVEN,_loc2_);
            _loc3_ = _loc2_.itemDes;
            for each(_loc4_ in _loc3_)
            {
               if(!_loc4_.isPet && _loc4_.isAdd)
               {
                  if(ItemCategoryUtil.isMedal(_loc4_.referenceId))
                  {
                     AlertManager.showMedalGainedAlert(_loc4_.referenceId);
                     if(ItemConfig.getMedalDefinition(_loc4_.referenceId).title != "")
                     {
                        ServerMessager.addMessage("恭喜你获得了[" + ItemConfig.getMedalDefinition(_loc4_.referenceId).title + "称号]");
                     }
                  }
                  else if(ItemCategoryUtil.isEmblem(_loc4_.referenceId))
                  {
                     ServerMessager.addMessage("恭喜你获得了[" + ItemConfig.getItemName(_loc4_.referenceId) + "]");
                  }
                  else if(_loc4_.referenceId >= 500546 && _loc4_.referenceId <= 500548)
                  {
                     ServerMessager.addMessage("次数增加1");
                  }
                  else if(_loc4_.referenceId > 603000 && _loc4_.referenceId <= 610000 || _loc4_.referenceId >= 400266 && _loc4_.referenceId <= 400268 || _loc4_.referenceId == 401067)
                  {
                     ServerMessager.addMessage("恭喜你获得了" + _loc4_.quantity + "个[" + ItemConfig.getItemName(_loc4_.referenceId) + "]");
                  }
                  else if(_loc4_.referenceId == 400188)
                  {
                     ServerMessager.addMessage("恭喜你获得了" + _loc4_.quantity + "个争霸赛奖牌");
                  }
                  else if(_loc4_.referenceId == 400111)
                  {
                     AlertManager.showSpiecalItemGainedAlert(_loc4_.referenceId,_loc4_.quantity);
                  }
                  else
                  {
                     AlertManager.showItemGainedAlert(_loc4_.referenceId,_loc4_.quantity);
                  }
               }
               else if(_loc4_.isPet)
               {
                  ServerMessager.addMessage("获得了" + PetConfig.getPetDefinition(_loc4_.referenceId).name);
               }
            }
         }
         else
         {
            ItemUtil.upateServerGiven(_loc2_.itemDes);
         }
         if(_success != null)
         {
            _success();
         }
      }
      
      private static function onItemServerGiverError(param1:MessageEvent) : void
      {
         if(param1.message.statusCode == 27)
         {
            AlertManager.showAlert("精灵仓库已满");
         }
      }
      
      public static function addListener1051(param1:Function) : void
      {
         _success = param1;
      }
      
      public static function removeListener1051() : void
      {
         _success = null;
      }
      
      public static function changeEquipValidity() : void
      {
         ItemManager.requestEquipList(function():void
         {
            var _loc2_:EquipItem = null;
            var _loc1_:Vector.<EquipItem> = ItemManager.getEquipVec();
            for each(_loc2_ in _loc1_)
            {
               _loc2_.expiryTime = 0;
            }
         });
      }
      
      public static function addEventListener1(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener1(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function dispatchEvent(param1:String, param2:*) : void
      {
         if(_dispatcher.hasEventListener(param1))
         {
            _dispatcher.dispatchEvent(new ItemEvent(param1,param2));
         }
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      override public function start() : void
      {
         _logger = Logger.getLogger("ItemManager");
         _specialItemMap = new HashMap();
         _inventory = new SeerIIInventory();
         _inventory.capacity = int.MAX_VALUE;
         _isLoadingData = false;
         _evtRemoter = new EventDispatcher();
         Connection.addCommandListener(CommandSet.GET_CONIS_1547,onGetConis);
         Connection.addErrorHandler(CommandSet.ITEM_SERVER_GIVE_1051,onItemServerGiverError);
         Connection.addCommandListener(CommandSet.ITEM_SERVER_GIVE_1051,onItemServerGiven);
         finish();
      }
   }
}
