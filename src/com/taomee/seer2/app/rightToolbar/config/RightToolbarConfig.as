package com.taomee.seer2.app.rightToolbar.config
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
   
   public class RightToolbarConfig
   {
      
      private static var _xmlClass:Class = RightToolbarConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _rightToolbarInfoVec:Vector.<RightToolbarInfo>;
      
      private static var _upToolbarInfoVec:Vector.<RightToolbarInfo>;
      
      private static var _leftToolbarInfoVec:Vector.<RightToolbarInfo>;
      
      private static var _rightRollToolbarInfoVec:Vector.<String>;
      
      private static var _leftRollToolbarInfoVec:Vector.<String>;
      
      {
         setup();
      }
      
      public function RightToolbarConfig()
      {
         super();
      }
      
      public static function setup() : void
      {
         loadConfig(XML(new _xmlClass()));
      }

      public static function loadConfig(xml:XML) : void
      {
         var _loc1_:RightToolbarInfo = null;
         var _loc5_:XMLList = null;
         var _loc6_:RightToolbarInfo = null;
         var _loc7_:XML = null;
         var _loc8_:String = null;
         var _loc9_:XML = null;
         var _loc10_:uint = 0;
         _xml = xml;
         _rightToolbarInfoVec = Vector.<RightToolbarInfo>([]);
         _upToolbarInfoVec = Vector.<RightToolbarInfo>([]);
         _leftToolbarInfoVec = Vector.<RightToolbarInfo>([]);
         var _loc2_:XMLList = _xml.descendants("downIconList");
         var _loc3_:Array = String(_loc2_[0].@list).split(",");
         _loc2_ = _xml.descendants("toolbar");
         var _loc4_:XMLList = _xml.descendants("rightRollIconList");
         _rightRollToolbarInfoVec = Vector.<String>(String(_loc4_[0].@list).split(","));
         _loc4_ = _xml.descendants("leftRollIconList");
         _leftRollToolbarInfoVec = Vector.<String>(String(_loc4_[0].@list).split(","));
         for each(_loc7_ in _loc2_)
         {
            _loc1_ = new RightToolbarInfo();
            _loc8_ = String(_loc7_.attribute("type"));
            updateInfo(_loc7_,_loc1_);
            if(_loc8_ == "right" || _loc3_.indexOf(String(_loc1_.sort)) != -1)
            {
               _rightToolbarInfoVec.push(_loc1_);
            }
            else if(_loc8_ == "up" && _loc3_.indexOf(String(_loc1_.sort)) == -1)
            {
               _upToolbarInfoVec.push(_loc1_);
            }
            else if(_loc8_ == "left" && _loc3_.indexOf(String(_loc1_.sort)) == -1)
            {
               _loc10_ = new Date(2014,8,19).getTime() / 1000;
               if(_loc1_.sort == 16 || _loc1_.sort == 23 || _loc1_.sort == 24)
               {
                  if(ActorManager.actorInfo.createTime > _loc10_)
                  {
                     if(_loc1_.sort == 23)
                     {
                        if(!NewPlayerGuideTimeManager.curTimeCheck())
                        {
                           _leftToolbarInfoVec.push(_loc1_);
                        }
                     }
                     else
                     {
                        _leftToolbarInfoVec.push(_loc1_);
                     }
                  }
               }
               else if(_loc1_.sort == 38)
               {
                  if(NewPlayerGuideTimeManager.curTimeCheck())
                  {
                     _leftToolbarInfoVec.push(_loc1_);
                  }
               }
               else
               {
                  _leftToolbarInfoVec.push(_loc1_);
               }
            }
            _loc1_.type = _loc8_;
            _loc1_.toolbarInfoList = Vector.<RightToolbarInfo>([]);
            _loc5_ = _loc7_.descendants("toolbar");
            for each(_loc9_ in _loc5_)
            {
               (_loc6_ = new RightToolbarInfo()).type = _loc8_;
               updateInfo(_loc9_,_loc6_);
               _loc1_.toolbarInfoList.push(_loc6_);
            }
         }
      }
      
      private static function updateInfo(param1:XML, param2:RightToolbarInfo) : void
      {
         var _loc16_:int = 0;
         var _loc3_:uint = uint(param1.attribute("sort"));
         var _loc4_:String = String(param1.attribute("startTime"));
         var _loc5_:String = String(param1.attribute("endTime"));
         var _loc6_:String = String(param1.attribute("class"));
         var _loc7_:String = String(param1.attribute("clickType"));
         var _loc8_:String = String(param1.attribute("clickParams"));
         var _loc9_:String = String(param1.attribute("tip"));
         var _loc10_:String = String(param1.attribute("lightStartTime"));
         var _loc11_:String = String(param1.attribute("dayList"));
         var _loc12_:uint = uint(param1.attribute("weekLimit"));
         var _loc13_:uint = uint(param1.attribute("swapId"));
         var _loc14_:int = int(param1.attribute("lightIndex"));
         var _loc15_:int = int(param1.attribute("isShowPoint"));
         if(String(param1.attribute("bufIndex")) == "")
         {
            _loc16_ = -1;
         }
         else
         {
            _loc16_ = int(param1.attribute("bufIndex"));
         }
         param2.sort = _loc3_;
         param2.startTime = _loc4_;
         param2.endTime = _loc5_;
         param2.classStr = _loc6_;
         param2.clickType = _loc7_;
         param2.clickParams = _loc8_;
         param2.weekLimit = _loc12_;
         param2.swapId = _loc13_;
         param2.tip = _loc9_;
         param2.isShowPoint = _loc15_;
         param2.dayList = _loc11_;
         param2.lightStartTime = _loc10_;
         param2.bufIndex = _loc16_;
         param2.lightIndex = _loc14_;
      }
      
      public static function getInfoVec() : Vector.<RightToolbarInfo>
      {
         if(_rightToolbarInfoVec.length < 1)
         {
            return null;
         }
         return _rightToolbarInfoVec;
      }
      
      public static function getUpVec() : Vector.<RightToolbarInfo>
      {
         if(_upToolbarInfoVec.length < 1)
         {
            return null;
         }
         return _upToolbarInfoVec;
      }
      
      public static function getLeftVec() : Vector.<RightToolbarInfo>
      {
         if(_leftToolbarInfoVec.length < 1)
         {
            return null;
         }
         return _leftToolbarInfoVec;
      }
      
      public static function getRightRollList() : Vector.<String>
      {
         return _rightRollToolbarInfoVec;
      }
      
      public static function getLeftRollList() : Vector.<String>
      {
         return _leftRollToolbarInfoVec;
      }
   }
}
