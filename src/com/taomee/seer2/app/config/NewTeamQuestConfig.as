package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.team.NewTeamInfo;
   import org.taomee.ds.HashMap;
   
   public class NewTeamQuestConfig
   {
      
      private static var _xmlClass:Class = NewTeamQuestConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _map:HashMap = new HashMap();
      
      {
         setup();
      }
      
      public function NewTeamQuestConfig()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc1_:NewTeamInfo = null;
         var _loc3_:XML = null;
         _xml = XML(new _xmlClass());
         var _loc2_:XMLList = _xml.descendants("quest");
         for each(_loc3_ in _loc2_)
         {
            _loc1_ = new NewTeamInfo();
            _loc1_.type = uint(_loc3_.attribute("type"));
            _loc1_.questId = uint(_loc3_.attribute("questId"));
            _loc1_.titleType = String(_loc3_.attribute("titleType"));
            _loc1_.titleContent = String(_loc3_.attribute("titleContent"));
            _loc1_.target = String(_loc3_.attribute("target"));
            _loc1_.exp = uint(_loc3_.attribute("exp"));
            _loc1_.point = uint(_loc3_.attribute("point"));
            _loc1_.activity = uint(_loc3_.attribute("activity"));
            _loc1_.money = uint(_loc3_.attribute("money"));
            _map.add(_loc1_.questId,_loc1_);
         }
      }
      
      public static function getTeamQuestInfo(param1:uint) : NewTeamInfo
      {
         return _map.getValue(param1);
      }
   }
}
