package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_80393 extends MapProcessor
   {
       
      
      private var _npc:Mobile;
      
      private const FIGHT_ID:uint = 1465;
      
      public function MapProcessor_80393(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.createNpc();
      }
      
      override public function dispose() : void
      {
         this._npc = null;
         super.dispose();
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(800,400));
            this._npc.resourceUrl = URLUtil.getNpcSwf(855);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "星魂守护者";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      protected function onNpcClick(param1:MouseEvent) : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
         FightManager.startFightWithBoss(this.FIGHT_ID);
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         var event:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this.FIGHT_ID == FightManager.currentFightRecord.initData.positionIndex)
            {
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,function on70(param1:SceneEvent):void
               {
                  SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,on70);
                  ModuleManager.showModule(URLUtil.getAppModule("UKFightResultPanel"),"正在打开战斗结算面板...",{
                     "space":2,
                     "result":1
                  });
               });
               SceneManager.changeScene(SceneType.LOBBY,70);
            }
         }
      }
   }
}
