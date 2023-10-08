package com.taomee.seer2.core.inventory
{
   public class StackableItem extends Item
   {
       
      
      private var _maxStackNum:int = 1;
      
      public function StackableItem()
      {
         super();
      }
      
      override public function set referenceId(param1:int) : void
      {
         super.referenceId = param1;
         super.uniqueId = param1;
      }
      
      override public function set uniqueId(param1:int) : void
      {
         super.referenceId = param1;
         super.uniqueId = param1;
      }
      
      override public function set quantityLimit(param1:int) : void
      {
         super.quantityLimit = param1;
         this._maxStackNum = param1;
      }
      
      private function set maxStackNum(param1:int) : void
      {
         if(param1 <= this.quantityLimit)
         {
            this._maxStackNum = param1;
            return;
         }
         throw new Error("MaxStackNum must be less than QuanlityLimit!");
      }
      
      private function get maxStackNum() : int
      {
         return this._maxStackNum;
      }
      
      override public function getOccupiedSpace() : int
      {
         return Math.ceil(this.quantity / this.maxStackNum);
      }
   }
}
