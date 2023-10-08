package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.activity.onlineReward.NonoNewsInfo;
   
   public class NonoNewsConfig
   {
      
      private static var _xmlClass:Class = NonoNewsConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _nonoNewsInfoVec:Vector.<NonoNewsInfo>;
      
      {
         setup();
      }
      
      public function NonoNewsConfig()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc1_:NonoNewsInfo = null;
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         _xml = XML(new _xmlClass());
         _nonoNewsInfoVec = Vector.<NonoNewsInfo>([]);
         var _loc2_:XMLList = _xml.descendants("nono");
         for each(_loc3_ in _loc2_)
         {
            _loc1_ = new NonoNewsInfo();
            _loc4_ = String(_loc3_.attribute("content"));
            _loc5_ = String(_loc3_.attribute("type"));
            _loc6_ = String(_loc3_.attribute("transport"));
            _loc1_.content = _loc4_;
            _loc1_.type = _loc5_;
            _loc1_.transport = _loc6_;
            _nonoNewsInfoVec.push(_loc1_);
         }
      }
      
      public static function getNonoNewsInfoVec() : Vector.<NonoNewsInfo>
      {
         if(_nonoNewsInfoVec.length < 1)
         {
            return null;
         }
         return _nonoNewsInfoVec;
      }
   }
}
