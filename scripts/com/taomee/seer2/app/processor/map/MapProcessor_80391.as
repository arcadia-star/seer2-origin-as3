package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
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
   
   public class MapProcessor_80391 extends MapProcessor
   {
       
      
      private var _npc1:Mobile;
      
      private var _npc2:Mobile;
      
      private const FIGHT_LIST:Vector.<uint> = Vector.<uint>([1461,1460]);
      
      public function MapProcessor_80391(param1:MapModel)
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
         this._npc1 = null;
         this._npc2 = null;
         super.dispose();
      }
      
      private function createNpc() : void
      {
         if(!this._npc1)
         {
            this._npc1 = new Mobile();
            this._npc1.setPostion(new Point(270,458));
            this._npc1.resourceUrl = URLUtil.getNpcSwf(771);
            this._npc1.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc1.label = "魔渊梦神";
            this._npc1.labelImage.y = -this._npc1.height - 10;
            this._npc1.buttonMode = true;
            MobileManager.addMobile(this._npc1,MobileType.NPC);
            this._npc1.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
         if(!this._npc2)
         {
            this._npc2 = new Mobile();
            this._npc2.setPostion(new Point(970,480));
            this._npc2.resourceUrl = URLUtil.getNpcSwf(769);
            this._npc2.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc2.label = "梦魇";
            this._npc2.labelImage.y = -this._npc2.height - 10;
            this._npc2.buttonMode = true;
            MobileManager.addMobile(this._npc2,MobileType.NPC);
            this._npc2.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      protected function onNpcClick(param1:MouseEvent) : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
         FightManager.startFightWithBoss(this.FIGHT_LIST[[this._npc1,this._npc2].indexOf(param1.currentTarget)]);
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         var index:int = 0;
         var result:int = 0;
         var event:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            index = this.FIGHT_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex);
            if(index != -1)
            {
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  result = 0;
               }
               else
               {
                  result = 1;
               }
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,function on70(param1:SceneEvent):void
               {
                  SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,on70);
                  ModuleManager.showModule(URLUtil.getAppModule("UKFightResultPanel"),"正在打开战斗结算面板...",{
                     "space":0,
                     "result":result
                  });
               });
               SceneManager.changeScene(SceneType.LOBBY,70);
            }
         }
      }
   }
}
