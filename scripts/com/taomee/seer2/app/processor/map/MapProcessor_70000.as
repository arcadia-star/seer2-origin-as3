package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.PipeBigSulleyAct;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.plantSystem.PlantManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_70000 extends MapProcessor
   {
       
      
      private const pointList:Vector.<Point> = Vector.<Point>([new Point(323,365),new Point(384,380),new Point(441,398),new Point(499,414),new Point(264,391),new Point(324,407),new Point(382,424),new Point(446,441),new Point(204,420),new Point(264,436),new Point(321,453),new Point(381,473),new Point(149,447),new Point(208,465),new Point(269,484),new Point(330,503)]);
      
      private var _plantManager:PlantManager;
      
      private var _npc:Mobile;
      
      public function MapProcessor_70000(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         var _loc1_:Teleport = AnimateElementManager.getElement(1) as Teleport;
         var _loc2_:Teleport = AnimateElementManager.getElement(2) as Teleport;
         if(QuestManager.isComplete(60))
         {
            _loc1_.visible = true;
            _loc2_.visible = true;
         }
         else
         {
            _loc1_.visible = false;
            _loc2_.visible = false;
         }
         this._plantManager = new PlantManager(this.pointList);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_173);
         this.magicFlowerInit();
         PipeBigSulleyAct.getInstance().setup();
      }
      
      private function magicFlowerInit() : void
      {
         var _loc1_:uint = new Date(2013,7,23,23,59,59).getTime() / 1000;
         if(TimeManager.getServerTime() > _loc1_)
         {
            return;
         }
         if(!Boolean(DateUtil.isInHourScope(13,14,0,0) || DateUtil.isInHourScope(18,19,0,0)))
         {
            return;
         }
         this.addNpc();
      }
      
      private function addNpc() : void
      {
         this._npc = new Mobile();
         this._npc.width = 278;
         this._npc.height = 212;
         this._npc.setPostion(new Point(310,280));
         this._npc.resourceUrl = URLUtil.getNpcSwf(336);
         this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         this._npc.label = "白瑞婆婆";
         this._npc.labelImage.y = -this._npc.height + 90;
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(336,"白瑞婆婆",[[0,"有没有空啊？有魔法花吗？来感受一下魔法花的神奇力量呀~"]],["婆婆的魔法花","我这就去种"],[function():void
         {
            ModuleManager.showModule(URLUtil.getAppModule("MagicFlowerPowerPanel"),"正在打开婆婆的魔法花入口面板...");
         }]);
      }
      
      private function magicFlowerDispose() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      override public function dispose() : void
      {
         if(this._plantManager)
         {
            this._plantManager.dispose();
         }
         this._plantManager = null;
         this.magicFlowerDispose();
         PipeBigSulleyAct.getInstance().dispose();
      }
   }
}
