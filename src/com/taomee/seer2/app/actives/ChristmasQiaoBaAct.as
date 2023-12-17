package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ChristmasQiaoBaAct
   {
      
      private static var _instance:ChristmasQiaoBaAct;
       
      
      private const FIGHT_LIMIT_ID:uint = 897;
      
      private const FIGHT_ID:uint = 740;
      
      private var fullState:Boolean;
      
      private var hurtNpc:Mobile;
      
      private var skyNpc:Mobile;
      
      private var fightSkyNum:uint;
      
      public function ChristmasQiaoBaAct()
      {
         super();
      }
      
      public static function getInstance() : ChristmasQiaoBaAct
      {
         if(!_instance)
         {
            _instance = new ChristmasQiaoBaAct();
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         if(this.hurtNpc)
         {
            this.hurtNpc.removeEventListener(MouseEvent.CLICK,this.onHurtClick);
         }
         if(this.skyNpc)
         {
            this.skyNpc.removeEventListener(MouseEvent.CLICK,this.onSkyClick);
         }
         ModuleManager.removeEventListener("QiaoBaSkyDreamPanel",ModuleEvent.HIDE,this.reqBuffer);
      }
      
      public function setup() : void
      {
         DayLimitManager.getDoCount(this.FIGHT_LIMIT_ID,this.getFightSky);
      }
      
      private function getFightSky(param1:uint) : void
      {
         this.fightSkyNum = param1;
         ModuleManager.addEventListener("QiaoBaSkyDreamPanel",ModuleEvent.HIDE,this.reqBuffer);
         this.reqBuffer();
         this.initHurtNpc();
      }
      
      private function initHurtNpc() : void
      {
         if(!this.hurtNpc)
         {
            this.hurtNpc = new Mobile();
            this.hurtNpc.width = 40;
            this.hurtNpc.height = 85;
            this.hurtNpc.setPostion(new Point(600,170));
            this.hurtNpc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this.hurtNpc.label = "受伤的小鹿";
            this.hurtNpc.buttonMode = true;
         }
         this.hurtNpc.resourceUrl = URLUtil.getNpcSwf(451);
         this.hurtNpc.labelImage.y = -this.hurtNpc.height - 10;
         MobileManager.addMobile(this.hurtNpc,MobileType.NPC);
         this.hurtNpc.addEventListener(MouseEvent.CLICK,this.onHurtClick);
      }
      
      private function onHurtClick(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("QiaoBaSkyDreamPanel"));
      }
      
      private function reqBuffer(param1:ModuleEvent = null) : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_57,this.getFullState,false);
      }
      
      private function getFullState(param1:ServerBuffer) : void
      {
         var _loc2_:Date = null;
         this.fullState = param1.readDataAtPostion(36) != 0;
         if(this.fullState)
         {
            MonsterManager.showAllMonster();
            _loc2_ = new Date(TimeManager.getPrecisionServerTime() * 1000);
            if(_loc2_.hours == 12 || _loc2_.hours == 19)
            {
               this.cretateSkyNpc();
            }
         }
         else
         {
            MonsterManager.hideAllMonster();
         }
      }
      
      private function cretateSkyNpc() : void
      {
         if(SceneManager.active.type != SceneType.COPY)
         {
            return;
         }
         if(!this.skyNpc)
         {
            this.skyNpc = new Mobile();
            this.skyNpc.width = 100;
            this.skyNpc.height = 160;
            this.skyNpc.setPostion(new Point(425,290));
            this.skyNpc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this.skyNpc.label = "飞天小鹿";
            this.skyNpc.buttonMode = true;
         }
         if(this.skyNpc.hasEventListener(MouseEvent.CLICK))
         {
            return;
         }
         this.skyNpc.resourceUrl = URLUtil.getNpcSwf(670);
         this.skyNpc.labelImage.y = -this.skyNpc.height - 10;
         MobileManager.addMobile(this.skyNpc,MobileType.NPC);
         this.skyNpc.addEventListener(MouseEvent.CLICK,this.onSkyClick);
      }
      
      protected function onSkyClick(param1:MouseEvent) : void
      {
         if(this.fightSkyNum >= 3)
         {
            AlertManager.showAlert("每天最多挑战3次，现在我累了~不想跟你玩了~");
            return;
         }
         FightManager.startFightWithWild(this.FIGHT_ID);
      }
   }
}
