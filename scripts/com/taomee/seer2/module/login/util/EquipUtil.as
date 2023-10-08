package com.taomee.seer2.module.login.util
{
   import com.taomee.seer2.module.login.config.ItemConfig;
   import com.taomee.seer2.module.login.config.definition.EquipDefinition;
   import flash.utils.Dictionary;
   
   public class EquipUtil
   {
      
      public static const TOTAL_SLOT_NUM:int = 10;
      
      public static const HEAD:uint = 1;
      
      public static const HAND_RIGHT:uint = 2;
      
      public static const CLOTH:uint = 3;
      
      public static const BODY:uint = 4;
      
      public static const BELT:uint = 5;
      
      public static const FOOT_RIGHT:uint = 6;
      
      public static const WING:uint = 7;
      
      public static const EYE:uint = 8;
      
      public static const FOOT_LEFT:uint = 9;
      
      public static const HAND_LEFT:uint = 10;
      
      private static const COLOR_BLUE:uint = 0;
      
      private static const COLOR_GREEN:uint = 1;
      
      private static const COLOR_PURPLE:uint = 2;
      
      private static const COLOR_YELLOW:uint = 3;
      
      private static const COLOR_VIOLOET:uint = 4;
      
      private static const COLOR_ORANGE:uint = 5;
      
      private static const COLOR_RED:uint = 6;
      
      private static const COLOR_PINK:uint = 7;
      
      private static const COLOR_WHITE:uint = 8;
      
      private static const COLOR_BLACK:uint = 9;
      
      private static const COLOR_DEEPBLUE:uint = 10;
      
      private static const COLOR_BROWN:uint = 11;
      
      private static var _downDirDefinition:Vector.<uint> = Vector.<uint>([WING,HAND_RIGHT,FOOT_RIGHT,FOOT_LEFT,BODY,CLOTH,BELT,EYE,HEAD,HAND_LEFT]);
      
      private static var _equipMap:Dictionary;
      
      {
         initialize();
      }
      
      public function EquipUtil()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _equipMap = new Dictionary();
         _equipMap[COLOR_BLUE] = [100001,100003,100004,100005,100006];
         _equipMap[COLOR_GREEN] = [100001,100003,100007,100008,100009];
         _equipMap[COLOR_PURPLE] = [100001,100003,100010,100011,100012];
         _equipMap[COLOR_YELLOW] = [100001,100003,100013,100014,100015];
         _equipMap[COLOR_VIOLOET] = [100001,100003,100016,100017,100018];
         _equipMap[COLOR_ORANGE] = [100001,100003,100019,100020,100021];
         _equipMap[COLOR_RED] = [100001,100003,100022,100023,100024];
         _equipMap[COLOR_PINK] = [100001,100003,100025,100026,100027];
         _equipMap[COLOR_WHITE] = [100001,100003,100028,100029,100030];
         _equipMap[COLOR_BLACK] = [100001,100003,100031,100032,100033];
         _equipMap[COLOR_DEEPBLUE] = [100001,100003,100143,100144,100145];
         _equipMap[COLOR_BROWN] = [100001,100003,100146,100147,100148];
      }
      
      public static function mergeDefaultEquip(param1:uint, param2:Vector.<int>) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:EquipDefinition = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:Array = _equipMap[param1];
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:int = int(param2.length);
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc6_ = uint(_loc3_[_loc8_]);
            _loc9_ = 0;
            while(true)
            {
               if(_loc9_ >= _loc5_)
               {
                  param2.push(_loc6_);
                  break;
               }
               if((Boolean(_loc7_ = ItemConfig.getEquipDefinition(param2[_loc9_]))) && _loc7_.slotIndex == ItemConfig.getEquipDefinition(_loc6_).slotIndex)
               {
                  break;
               }
               _loc9_++;
            }
            _loc8_++;
         }
      }
      
      public static function getSlotDefaultEquipReferenceId(param1:uint, param2:uint) : uint
      {
         var _loc3_:Array = _equipMap[param1];
         switch(param2)
         {
            case HEAD:
               return _loc3_[0];
            case EYE:
               return _loc3_[1];
            case HAND_RIGHT:
               return _loc3_[2];
            case BODY:
               return _loc3_[3];
            case FOOT_RIGHT:
               return _loc3_[4];
            default:
               return uint.MAX_VALUE;
         }
      }
      
      public static function findDepthIndex(param1:uint) : int
      {
         var _loc2_:int = int(_downDirDefinition.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 == _downDirDefinition[_loc3_])
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public static function pad(param1:String, param2:String, param3:int, param4:Boolean = true) : String
      {
         var _loc5_:String = param1;
         while(_loc5_.length < param3)
         {
            if(param4)
            {
               _loc5_ += param2;
            }
            else
            {
               _loc5_ = param2 + _loc5_;
            }
         }
         return _loc5_;
      }
      
      public static function isAccessory(param1:uint) : Boolean
      {
         return param1 == HAND_LEFT || param1 == FOOT_LEFT;
      }
      
      public static function hasAccessory(param1:uint) : Boolean
      {
         return param1 == HAND_RIGHT || param1 == FOOT_RIGHT;
      }
      
      public static function getAccessorySlotIndex(param1:uint) : int
      {
         switch(param1)
         {
            case HAND_RIGHT:
               return HAND_LEFT;
            case FOOT_RIGHT:
               return FOOT_LEFT;
            default:
               return 0;
         }
      }
   }
}
