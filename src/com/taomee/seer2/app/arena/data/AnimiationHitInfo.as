package com.taomee.seer2.app.arena.data
{
   import com.taomee.seer2.app.arena.util.FighterActionType;
   import com.taomee.seer2.core.config.ClientConfig;
   
   public class AnimiationHitInfo
   {
       
      
      public var id:uint;
      
      public var physics:uint;
      
      public var attribute:uint;
      
      public var special:uint;
      
      public var critical:uint;
      
      public var fit:uint;
      
      public function AnimiationHitInfo()
      {
         super();
      }
      
      public function getHitValue(param1:String) : Number
      {
         var _loc2_:Number = 0;
         switch(param1)
         {
            case FighterActionType.ATK_PHY:
               _loc2_ = this.physics;
               break;
            case FighterActionType.ATK_BUF:
               _loc2_ = this.attribute;
               break;
            case FighterActionType.ATK_SPE:
               _loc2_ = this.special;
               break;
            case FighterActionType.ATK_POW:
               _loc2_ = this.critical;
               break;
            case FighterActionType.INTERCOURSE:
               _loc2_ = this.fit;
         }
         return _loc2_ / ClientConfig.timeRate;
      }
   }
}
