package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.gameRule.fish.FishRule_152;
   import com.taomee.seer2.app.gameRule.spt.SptMMdiSupport;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_152 extends TitleMapProcessor
   {
       
      
      private var _fishRule:FishRule_152;
      
      private var npcMobile:Mobile;
      
      public function MapProcessor_152(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         SptMMdiSupport.getInstance().init(_map);
         this._fishRule = new FishRule_152();
         this._fishRule.init(_map);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_132);
         this.initFishNpc();
      }
      
      private function initFishNpc() : void
      {
         this.npcMobile = new Mobile();
         this.npcMobile.resourceUrl = URLUtil.getNpcSwf(443);
         this.npcMobile.buttonMode = true;
         var _loc1_:AcceptableMark = new AcceptableMark();
         this.npcMobile.addChild(_loc1_);
         _loc1_.y -= 90;
         this.npcMobile.addEventListener(MouseEvent.CLICK,this.toDia);
         this.npcMobile.setPostion(new Point(530,320));
         MobileManager.addMobile(this.npcMobile,MobileType.NPC);
      }
      
      private function toDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(443,"埃卡维特",[[0,"你们知道的，我有很多怪毛病，比方说最近我就迷上了吃鱼！没有鱼吃我就会……就会……忧郁！"]],["哎约！给你鱼吃！","那你就忧郁呗~"],[function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("FeedFishPanel"),"",npcMobile);
         }]);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         SptMMdiSupport.getInstance().dispose();
         this._fishRule.dispose();
         this._fishRule = null;
         this.npcMobile.removeOverHeadMark();
         this.npcMobile.removeEventListener(MouseEvent.CLICK,this.toDia);
      }
   }
}
