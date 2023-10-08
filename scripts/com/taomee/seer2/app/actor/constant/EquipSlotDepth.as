package com.taomee.seer2.app.actor.constant
{
   import com.taomee.seer2.core.entity.constant.MobileDirectionMask;
   
   public class EquipSlotDepth
   {
      
      private static var _upDirDefinition:Vector.<uint> = Vector.<uint>([EquipSlot.DOGZ_RIGHT,EquipSlot.DOGZ_LEFT,EquipSlot.EYE,EquipSlot.HAND_RIGHT,EquipSlot.FOOT_RIGHT,EquipSlot.FOOT_LEFT,EquipSlot.BODY,EquipSlot.BELT,EquipSlot.HAND_LEFT,EquipSlot.HEAD,EquipSlot.WING]);
      
      private static var _downDirDefinition:Vector.<uint> = Vector.<uint>([EquipSlot.WING,EquipSlot.HAND_RIGHT,EquipSlot.FOOT_RIGHT,EquipSlot.FOOT_LEFT,EquipSlot.BODY,EquipSlot.BELT,EquipSlot.EYE,EquipSlot.HEAD,EquipSlot.HAND_LEFT,EquipSlot.DOGZ_RIGHT,EquipSlot.DOGZ_LEFT]);
       
      
      public function EquipSlotDepth()
      {
         super();
      }
      
      public static function getDepthByDirection(param1:uint, param2:uint) : int
      {
         if(param2 & MobileDirectionMask.DIR_VERTICAL_MASK)
         {
            return findDepthIndex(_upDirDefinition,param1);
         }
         return findDepthIndex(_downDirDefinition,param1);
      }
      
      private static function findDepthIndex(param1:Vector.<uint>, param2:uint) : int
      {
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2 == param1[_loc4_])
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
   }
}
