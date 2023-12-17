package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.MonsterDayInfo;
   
   public class ProvideMonster
   {
      
      private static var _xmlClass:Class = ProvideMonster__xmlClass;
      
      private static var _xml:XML;
      
      private static var _monsterInfoList:Vector.<MonsterDayInfo>;
      
      {
         initlize();
      }
      
      public function ProvideMonster()
      {
         super();
      }
      
      private static function initlize() : void
      {
         var _loc3_:MonsterDayInfo = null;
         var _loc4_:XML = null;
         var _loc1_:XML = XML(new _xmlClass());
         var _loc2_:XMLList = _loc1_.child("Monster");
         _monsterInfoList = Vector.<MonsterDayInfo>([]);
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = new MonsterDayInfo();
            _loc3_.numbersID = uint(_loc4_.@NumbersID);
            _loc3_.id = uint(_loc4_.@Id);
            _monsterInfoList.push(_loc3_);
         }
      }
      
      public static function getList() : Vector.<MonsterDayInfo>
      {
         return _monsterInfoList;
      }
   }
}
