package com.taomee.seer2.app.processor.activity.GrabXiaoYueSeAct
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class GrabXiaoYueSeAct
   {
      
      private static var _self:GrabXiaoYueSeAct;
       
      
      private var _map:MapModel;
      
      private var _npc:Mobile;
      
      private const MAPS:Array = [50,60,8011,80122,170,1210,980];
      
      public function GrabXiaoYueSeAct()
      {
         super();
      }
      
      public static function getInstance() : GrabXiaoYueSeAct
      {
         if(_self == null)
         {
            _self = new GrabXiaoYueSeAct();
         }
         return _self;
      }
      
      public function setup(param1:MapModel) : void
      {
         var map:MapModel = param1;
         this._map = map;
         ModuleManager.addEventListener("RewardInHatPanel",ModuleEvent.DISPOSE,function onGameClose(param1:ModuleEvent):void
         {
            ModuleManager.removeEventListener("RewardInHatPanel",ModuleEvent.DISPOSE,onGameClose);
            clearNpc();
         });
         this.update();
      }
      
      private function update() : void
      {
         DayLimitManager.getDoCount(1416,function(param1:int):void
         {
            if(_map.id == MAPS[param1 - 1])
            {
               createNpc();
            }
            else
            {
               clearNpc();
            }
         });
      }
      
      public function createNpc() : void
      {
         this._npc = new Mobile();
         this._npc.width = 100;
         this._npc.height = 160;
         this._npc.setPostion(new Point(400,470));
         this._npc.resourceUrl = URLUtil.getNpcSwf(3089);
         this._npc.buttonMode = true;
         this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         this._npc.label = "凯小萨";
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onMark);
      }
      
      private function clearNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onMark);
            MobileManager.removeMobile(this._npc,MobileType.NPC);
            this._npc = null;
         }
      }
      
      private function isInAct() : Boolean
      {
         var _loc1_:Boolean = false;
         if(Boolean(DateUtil.isInTime(new Date(2016,1,5),new Date(2016,1,19))) && Boolean(DateUtil.isInHourScope(13,14,0,0)))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function onMark(param1:MouseEvent) : void
      {
         if(!this.isInAct())
         {
            NpcDialog.show(3089,"凯小萨",[[0,"2.5~2.11  凯小萨大欢抢13:00~14:00"]],[]);
         }
         else
         {
            ModuleManager.showAppModule("BigRewardPanel");
         }
      }
      
      public function dispose() : void
      {
         this.clearNpc();
      }
   }
}
