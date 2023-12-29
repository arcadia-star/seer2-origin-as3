package com.taomee.seer2.app.arena.data
{
   import com.taomee.seer2.app.config.SkillSideEffectConfig;
   import flash.utils.IDataInput;
   
   public class FighterBuffInfo
   {
      
      private static const TYPE_PERMANENT:int = 1000000000;
      
      private static const TYPE_NEXT_TIME:int = 1000000101;
      
      private static const TYPE_NEXT_ROUND:int = 1000010001;
      
      private static const ITEM_LIST:Vector.<uint> = Vector.<uint>([3427,3428,3429,3430,3431]);
      
      private static const EQUIP_LIST:Vector.<uint> = Vector.<uint>([3442,3443,3444,3445,3446]);
       
      
      public var buffId:uint;
      
      public var round:int;
      
      public var dummy0:int;
      
      public var dummy1:int;
      
      public var dummy2:int;
      
      public function FighterBuffInfo(param1:IDataInput)
      {
         super();
         this.buffId = param1.readUnsignedInt();
         this.round = param1.readInt();
         this.dummy0 = param1.readInt();
         this.dummy1 = param1.readInt();
         this.dummy2 = param1.readInt();
      }
      
      public function get tip() : String
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this.round < 10000)
         {
            if(ITEM_LIST.indexOf(this.buffId) != -1)
            {
               _loc2_ = SkillSideEffectConfig.getDescription(this.buffId).replace(",0","").replace("，",",").replace("，",",").replace("，",",").replace(" 持续直到战斗结束","").replace(" 持续到战斗结束","") + this.dummy0;
            }
            else if(EQUIP_LIST.indexOf(this.buffId) != -1)
            {
               _loc2_ = "永久提升" + this.dummy0 + SkillSideEffectConfig.getDescription(this.buffId).replace(",0","").replace("，",",").replace("，",",");
            }
            else
            {
               _loc2_ = SkillSideEffectConfig.getDescription(this.buffId).replace("x","" + this.round).replace("y",this.dummy0).replace(",0","").replace("，",",").replace("，",",").replace(" 持续直到战斗结束","").replace(" 持续到战斗结束","");
            }
         }
         else if(ITEM_LIST.indexOf(this.buffId) != -1)
         {
            _loc2_ = SkillSideEffectConfig.getDescription(this.buffId).replace(",0","") + this.dummy0 + "点";
         }
         else if(EQUIP_LIST.indexOf(this.buffId) != -1)
         {
            _loc2_ = "永久提升" + this.dummy0 + SkillSideEffectConfig.getDescription(this.buffId).replace(",0","");
         }
         else
         {
            _loc2_ = SkillSideEffectConfig.getDescription(this.buffId).replace("x","" + this.round).replace("y",this.dummy0).replace(",0","").replace("，",",").replace("，",",").replace(" 持续直到战斗结束","").replace(" 持续到战斗结束","");
         }
         if(this.dummy2 > 0 && EQUIP_LIST.indexOf(this.buffId) == -1)
         {
            _loc1_ = SkillSideEffectConfig.getName(this.buffId) + "[" + this.dummy2 + "], " + _loc2_;
         }
         else if(ITEM_LIST.indexOf(this.buffId) != -1)
         {
            _loc1_ = this.dummy1 + SkillSideEffectConfig.getName(this.buffId) + "," + _loc2_;
         }
         else if(EQUIP_LIST.indexOf(this.buffId) != -1)
         {
            _loc1_ = SkillSideEffectConfig.getName(this.buffId) + "," + _loc2_;
         }
         else if(this.buffId == 3517 || this.buffId == 3516 || this.buffId == 3514)
         {
            _loc1_ = SkillSideEffectConfig.getName(this.buffId) + this.dummy0.toString() + "," + _loc2_;
         }
         else
         {
            _loc1_ = SkillSideEffectConfig.getName(this.buffId) + "," + _loc2_;
         }
         if(this.round <= TYPE_PERMANENT && this.round > 10000)
         {
            if(ITEM_LIST.indexOf(this.buffId) == -1 || EQUIP_LIST.indexOf(this.buffId) != -1)
            {
               if(this.buffId == 3468)
               {
                  _loc1_ += this.dummy0.toString() + "点伤害";
               }
               else
               {
                  _loc1_ += ",持续到战斗结束";
               }
            }
         }
         else if(this.round <= TYPE_NEXT_TIME && this.round > TYPE_PERMANENT)
         {
            _loc1_ += ",下一回合生效";
         }
         else if(this.round <= TYPE_NEXT_ROUND && this.round > TYPE_NEXT_TIME)
         {
            _loc1_ += ",下一次生效";
         }
         else
         {
            _loc1_ += ",持续回合" + this.round;
         }
         return _loc1_;
      }
   }
}
