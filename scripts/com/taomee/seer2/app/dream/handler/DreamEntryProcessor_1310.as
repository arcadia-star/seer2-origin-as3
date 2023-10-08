package com.taomee.seer2.app.dream.handler
{
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   
   public class DreamEntryProcessor_1310 extends DreamEntryProcessor
   {
      
      private static const DREAM_NPC_CATEGORY:uint = 401;
      
      private static const NPC_COUNT:uint = 3;
      
      private static const NPC_ID:Array = [4011,4012,4013];
       
      
      public function DreamEntryProcessor_1310()
      {
         _category = DREAM_NPC_CATEGORY;
         super();
      }
      
      override protected function getDreamMapID() : uint
      {
         var _loc1_:int = Math.ceil(Math.random() * 100);
         if(_loc1_ < 30)
         {
            return 139;
         }
         if(_loc1_ < 65)
         {
            return 137;
         }
         return 138;
      }
      
      override protected function createNpc() : void
      {
         var _loc2_:Mobile = null;
         _dreamNpcVec = new Vector.<Mobile>();
         var _loc1_:uint = 0;
         while(_loc1_ < NPC_COUNT)
         {
            _loc2_ = MobileManager.getMobile(NPC_ID[_loc1_],MobileType.NPC);
            _dreamNpcVec.push(_loc2_);
            _loc1_++;
         }
      }
   }
}
