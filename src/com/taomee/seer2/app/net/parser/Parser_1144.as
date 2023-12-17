package com.taomee.seer2.app.net.parser
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.inventory.ItemDescription;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.net.parser.baseData.ItemCookingInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import flash.utils.IDataInput;
   
   public class Parser_1144
   {
       
      
      public var addItemVec:Vector.<ItemCookingInfo>;
      
      public function Parser_1144(param1:IDataInput)
      {
         super();
         this.addItemVec = new Vector.<ItemCookingInfo>();
         this.addItemVec.push(new ItemCookingInfo(param1));
         this.addItem();
      }
      
      public function addItem(param1:Boolean = true, param2:Function = null) : void
      {
         var _loc3_:uint = this.addItemVec.length;
         var _loc4_:Vector.<ItemDescription> = new Vector.<ItemDescription>();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            if(this.addItemVec[_loc5_].id == 1)
            {
               ActorManager.actorInfo.coins += this.addItemVec[_loc5_].count;
               if(param1)
               {
                  _loc4_.push(new ItemDescription(this.addItemVec[_loc5_].id,this.addItemVec[_loc5_].count));
               }
            }
            else
            {
               _loc4_.push(new ItemDescription(this.addItemVec[_loc5_].id,this.addItemVec[_loc5_].count));
            }
            _loc5_++;
         }
         ItemManager.addItemList(_loc4_);
         AlertManager.showItemListGaindeAlert(_loc4_,param2);
      }
   }
}
