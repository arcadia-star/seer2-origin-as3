package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DomainUtil;
   import org.taomee.utils.Tick;
   
   public class HalloweenPumpkinAct
   {
      
      private static var _instance:HalloweenPumpkinAct;
       
      
      private var isHitWin:Boolean = false;
      
      private var pet:SpawnedPet;
      
      private var petBlood:MovieClip;
      
      private var currentBlood:int = 10;
      
      private var hitStickBar:MovieClip;
      
      private var groundBar:MovieClip;
      
      private var pumpkinPetAppear:MovieClip;
      
      private var fightBuff:uint = 0;
      
      private var isShowDia:Boolean = false;
      
      private var isOut:Boolean;
      
      public function HalloweenPumpkinAct()
      {
         super();
      }
      
      public static function get instance() : HalloweenPumpkinAct
      {
         if(!_instance)
         {
            _instance = new HalloweenPumpkinAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         this.isShowDia = false;
         LayerManager.resetOperation();
         if(SceneManager.active.type == SceneType.ARENA)
         {
            Tick.instance.removeRender(this.updateTime);
            return;
         }
         if(Tick.instance.hasRender(this.showTips))
         {
            Tick.instance.removeRender(this.showTips);
         }
         if(!Tick.instance.hasRender(this.updateTime))
         {
            Tick.instance.addRender(this.updateTime,60000);
         }
         this.checkCreate();
      }
      
      private function checkCreate() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc1_.fullYear == 2012 && _loc1_.month == 9 && _loc1_.date == 27)
         {
            if(_loc1_.hours >= 13 && _loc1_.hours < 14)
            {
               if(SceneManager.active.mapID == ActorManager.actorInfo.id)
               {
                  if(SceneManager.prevSceneType == SceneType.ARENA)
                  {
                     if(_loc1_.minutes < 15)
                     {
                        this.fightBuff = BitUtil.setBit(this.fightBuff,0,true);
                     }
                     else if(_loc1_.minutes < 30)
                     {
                        this.fightBuff = BitUtil.setBit(this.fightBuff,1,true);
                     }
                     else if(_loc1_.minutes < 45)
                     {
                        this.fightBuff = BitUtil.setBit(this.fightBuff,2,true);
                     }
                     else if(_loc1_.minutes < 60)
                     {
                        this.fightBuff = BitUtil.setBit(this.fightBuff,3,true);
                     }
                     ServerBufferManager.updateServerBuffer(ServerBufferType.HALLOWEEN_BUFF,9,this.fightBuff);
                     if(!FightManager.isWinWar() && !this.isShowDia)
                     {
                        this.isShowDia = true;
                        NpcDialog.show(523,"大南瓜",[[0,"想打败我，你还差得远呢！！哈哈哈"]],[" 可恶，你别跑呀！"]);
                     }
                     this.getServerBuff();
                  }
                  else
                  {
                     ServerBufferManager.getServerBuffer(ServerBufferType.HALLOWEEN_BUFF,this.getServerBuff);
                  }
               }
            }
            else if(SceneManager.active.mapID == ActorManager.actorInfo.id)
            {
               if(SceneManager.prevSceneType == SceneType.ARENA)
               {
                  if(!FightManager.isWinWar() && !this.isShowDia)
                  {
                     this.isShowDia = true;
                     NpcDialog.show(523,"大南瓜",[[0,"想打败我，你还差得远呢！！哈哈哈"]],[" 可恶，你别跑呀！"]);
                  }
               }
               else
               {
                  _loc2_ = Math.random() * 100;
                  if(_loc2_ < 5 && SceneManager.prevSceneType != SceneType.ARENA)
                  {
                     this.createPet();
                  }
               }
            }
         }
      }
      
      private function onComplete1(param1:ContentInfo) : void
      {
         this.pumpkinPetAppear = DomainUtil.getMovieClip("pumpkinPetAppear",param1.domain);
         this.playAppearTips();
      }
      
      private function playAppearTips() : void
      {
         SceneManager.active.mapModel.front.addChild(this.pumpkinPetAppear);
         MovieClipUtil.playMc(this.pumpkinPetAppear,1,this.pumpkinPetAppear.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(pumpkinPetAppear);
         },true);
      }
      
      private function updateTime(param1:int) : void
      {
         var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc2_.fullYear == 2012 && _loc2_.month == 9 && _loc2_.date == 27)
         {
            if(_loc2_.hours >= 13 && _loc2_.hours < 14)
            {
               this.isOut = false;
               this.checkCreate();
            }
            else if(_loc2_.hours >= 14)
            {
               this.isOut = true;
               Tick.instance.removeRender(this.updateTime);
            }
         }
         else
         {
            this.isOut = true;
            Tick.instance.removeRender(this.updateTime);
            if(this.pet)
            {
               MobileManager.removeMobile(this.pet,MobileType.PET);
               this.pet.removeEventListener(MouseEvent.CLICK,this.toFight);
               this.pet = null;
            }
         }
      }
      
      private function getServerBuff(param1:ServerBuffer = null) : void
      {
         if(param1)
         {
            this.fightBuff = param1.readDataAtPostion(9);
         }
         var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc2_.fullYear == 2012 && _loc2_.month == 9 && _loc2_.date == 27)
         {
            if(_loc2_.hours >= 13 && _loc2_.hours <= 14)
            {
               if(SceneManager.active.mapID != ActorManager.actorInfo.id)
               {
                  if(_loc2_.minutes < 15 && !BitUtil.getBit(this.fightBuff,0))
                  {
                     this.checkTips();
                  }
                  else if(_loc2_.minutes >= 15 && _loc2_.minutes < 30 && !BitUtil.getBit(this.fightBuff,1))
                  {
                     this.checkTips();
                  }
                  else if(_loc2_.minutes >= 30 && _loc2_.minutes < 45 && !BitUtil.getBit(this.fightBuff,2))
                  {
                     this.checkTips();
                  }
                  else if(_loc2_.minutes >= 45 && _loc2_.minutes < 60 && !BitUtil.getBit(this.fightBuff,3))
                  {
                     this.checkTips();
                  }
               }
               else if(_loc2_.minutes < 15 && !BitUtil.getBit(this.fightBuff,0))
               {
                  this.createPet();
               }
               else if(_loc2_.minutes >= 15 && _loc2_.minutes < 30 && !BitUtil.getBit(this.fightBuff,1))
               {
                  this.createPet();
               }
               else if(_loc2_.minutes >= 30 && _loc2_.minutes < 45 && !BitUtil.getBit(this.fightBuff,2))
               {
                  this.createPet();
               }
               else if(_loc2_.minutes >= 45 && _loc2_.minutes < 60 && !BitUtil.getBit(this.fightBuff,3))
               {
                  this.createPet();
               }
            }
         }
      }
      
      private function checkTips() : void
      {
         if(this.pumpkinPetAppear)
         {
            this.playAppearTips();
         }
         else
         {
            QueueLoader.load(URLUtil.getActivityAnimation("hitStickBar"),LoadType.SWF,this.onComplete1);
         }
      }
      
      private function createPet() : void
      {
         if(Boolean(this.pet) && Boolean(this.pet.parent))
         {
            return;
         }
         if(this.pet)
         {
            MobileManager.removeMobile(this.pet,MobileType.PET);
            this.pet.removeEventListener(MouseEvent.CLICK,this.toFight);
            this.pet = null;
         }
         this.pet = new SpawnedPet(280,15,0);
         this.pet.mouseEnabled = false;
         this.pet.addEventListener(MouseEvent.CLICK,this.toFight,false,1000);
         MobileManager.addMobile(this.pet,MobileType.PET);
         QueueLoader.load(URLUtil.getActivityAnimation("hitStickBar"),LoadType.SWF,this.onComplete);
      }
      
      private function onComplete(param1:ContentInfo) : void
      {
         var info:ContentInfo = param1;
         this.currentBlood = 10;
         this.groundBar = DomainUtil.getMovieClip("GroundBar",info.domain);
         this.hitStickBar = DomainUtil.getMovieClip("HitStickBar",info.domain);
         this.hitStickBar.gotoAndStop(1);
         this.petBlood = DomainUtil.getMovieClip("PetBlood",info.domain);
         this.groundBar.x = 390;
         this.groundBar.y = 260;
         this.groundBar.stop();
         this.groundBar.buttonMode = true;
         SceneManager.active.mapModel.content.addChild(this.groundBar);
         this.pumpkinPetAppear = DomainUtil.getMovieClip("pumpkinPetAppear",info.domain);
         SceneManager.active.mapModel.front.addChild(this.pumpkinPetAppear);
         MovieClipUtil.playMc(this.pumpkinPetAppear,1,this.pumpkinPetAppear.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(pumpkinPetAppear);
            Tick.instance.addRender(showTips,1000);
            groundBar.addEventListener(MouseEvent.CLICK,getBar);
         },true);
      }
      
      private function getBar(param1:MouseEvent) : void
      {
         Tick.instance.removeRender(this.showTips);
         this.hitStickBar.x = param1.stageX;
         this.hitStickBar.y = param1.stageY;
         this.hitStickBar.gotoAndStop(1);
         DisplayObjectUtil.removeFromParent(this.groundBar);
         this.groundBar.removeEventListener(MouseEvent.CLICK,this.getBar);
         SceneManager.active.mapModel.front.addChild(this.hitStickBar);
         this.pet.addChild(this.petBlood);
         this.petBlood.x = -this.petBlood.width / 2;
         this.petBlood.y = -this.pet.height;
         Mouse.hide();
         this.hitStickBar.startDrag(true);
         LayerManager.stage.addEventListener(MouseEvent.CLICK,this.hitPet);
         LayerManager.stage.mouseChildren = false;
         param1.stopImmediatePropagation();
      }
      
      private function hitPet(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         LayerManager.stage.removeEventListener(MouseEvent.CLICK,this.hitPet);
         MovieClipUtil.playMc(this.hitStickBar,1,this.hitStickBar.totalFrames,function():void
         {
            LayerManager.stage.addEventListener(MouseEvent.CLICK,hitPet);
            if(hitStickBar.hitTestObject(pet))
            {
               --currentBlood;
               petBlood["bar"].scaleX = 0.1 * currentBlood;
               if(currentBlood == 0)
               {
                  StatisticsManager.sendNovice(StatisticsManager.ui_interact_96);
                  DisplayObjectUtil.removeFromParent(petBlood);
                  DisplayObjectUtil.removeFromParent(hitStickBar);
                  pet.mouseEnabled = true;
                  Mouse.show();
                  LayerManager.stage.mouseChildren = true;
                  LayerManager.stage.removeEventListener(MouseEvent.CLICK,hitPet);
                  hitStickBar.stopDrag();
               }
            }
         });
      }
      
      private function moveBar(param1:MouseEvent) : void
      {
         this.hitStickBar.x = param1.stageX;
         this.hitStickBar.y = param1.stageY;
      }
      
      private function showTips(param1:int) : void
      {
         ServerMessager.addMessage("快拿起木棍去打那个大南瓜！快呀！快呀！");
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         this.pet.removeEventListener(MouseEvent.CLICK,this.toFight);
         MobileManager.removeMobile(this.pet,MobileType.PET);
         this.pet = null;
         if(Math.random() > 0.5)
         {
            FightManager.startFightWithWild(192);
         }
         else
         {
            FightManager.startFightWithWild(197);
         }
         param1.stopImmediatePropagation();
      }
      
      public function dispose() : void
      {
         Tick.instance.removeRender(this.showTips);
         Tick.instance.removeRender(this.updateTime);
         if(this.groundBar)
         {
            this.groundBar.removeEventListener(MouseEvent.CLICK,this.getBar);
         }
         LayerManager.stage.mouseChildren = true;
         LayerManager.stage.removeEventListener(MouseEvent.CLICK,this.hitPet);
         Mouse.show();
      }
   }
}
