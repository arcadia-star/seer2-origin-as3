package com.taomee.seer2.app.plantSystem
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.plant.event.PlantEvent;
   import com.taomee.seer2.app.plant.event.PlantEventControl;
   import flash.utils.IDataInput;
   
   public class PlantSetInfo
   {
       
      
      public var swapCoins:uint;
      
      public var itemID:uint;
      
      public var itemCount:uint;
      
      public var addSwapIdList:Vector.<uint>;
      
      public var addSwapCountList:Vector.<uint>;
      
      public function PlantSetInfo(param1:IDataInput)
      {
         super();
         if(param1 != null)
         {
            this.deleteItem(param1);
            this.addItem(param1);
            PlantEventControl.dispatchEvent(PlantEvent.LIBRARY_CHANGE,null);
         }
      }
      
      private function deleteItem(param1:IDataInput) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc2_:uint = uint(param1.readUnsignedInt());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = uint(param1.readUnsignedInt());
            _loc5_ = uint(param1.readUnsignedShort());
            _loc6_ = uint(param1.readUnsignedInt());
            if(_loc4_ == 1)
            {
               ActorManager.actorInfo.coins -= _loc5_;
            }
            else
            {
               ItemManager.reduceItemQuantity(_loc4_,_loc5_);
            }
            _loc3_++;
         }
      }
      
      private function addItem(param1:IDataInput) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc2_:uint = uint(param1.readUnsignedInt());
         this.swapCoins = 0;
         this.addSwapIdList = Vector.<uint>([]);
         this.addSwapCountList = Vector.<uint>([]);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = uint(param1.readUnsignedInt());
            _loc5_ = uint(param1.readUnsignedShort());
            _loc6_ = uint(param1.readUnsignedInt());
            this.addSwapIdList.push(_loc4_);
            this.addSwapCountList.push(_loc5_);
            this.itemID = _loc4_;
            this.itemCount = _loc5_;
            if(ItemConfig.getItemDefinition(_loc4_) != null)
            {
               if(_loc4_ == 1)
               {
                  ActorManager.actorInfo.coins += _loc5_;
                  this.swapCoins = _loc5_;
               }
               else if(!ItemConfig.getItemDefinition(_loc4_).isHide)
               {
                  ItemManager.addItem(_loc4_,_loc5_,_loc6_);
               }
            }
            _loc3_++;
         }
      }
   }
}
