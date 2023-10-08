package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.gameRule.fish.FishEventDispatcher;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.BitUtil;
   
   public class GaiYaAct
   {
       
      
      private const FIGHT_STATE_ID:uint = 744;
      
      private const BOMB_ID:uint = 603169;
      
      private const MAX_NUM:uint = 12;
      
      private const GUARD_ID:uint = 602;
      
      private const GAIYA_ID:uint = 601;
      
      private const GAIYA_SEAT:Point = new Point(442,425);
      
      private const GUARD_SEAT:Array = [new Point(250,235),new Point(460,260),new Point(570,280),new Point(760,260),new Point(830,330),new Point(830,400),new Point(430,515),new Point(540,510),new Point(340,330),new Point(350,420),new Point(540,390),new Point(630,365)];
      
      private const FIGHT_GUARD_MODULE:String = "GaiyaFightGuardPanel";
      
      private const FIGHT_GAIYA_MODULE:String = "GaiyaFightPanel";
      
      private const GAIYA_BOMB_MODULE:String = "GaiyaBombPanel";
      
      private var fight_state:uint;
      
      private var guard_list:Vector.<Mobile>;
      
      private var gaiya_npc:Mobile;
      
      private var _resLib:ResourceLibrary;
      
      private var map:MapModel;
      
      private var boxBtn:SimpleButton;
      
      private var bombBtn:SimpleButton;
      
      private var mapBombBtn:SimpleButton;
      
      private var eftList:Vector.<MovieClip>;
      
      private var eft_mobile_list:Array;
      
      public function GaiYaAct()
      {
         super();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         FishEventDispatcher.getInstance().removeEventListener("buy_bomb_complete",this.buyBombComplete);
         if(this.guard_list)
         {
            _loc1_ = 0;
            while(_loc1_ < this.MAX_NUM)
            {
               if(this.guard_list[_loc1_])
               {
                  this.guard_list[_loc1_].removeEventListener(MouseEvent.CLICK,this.clickGuard);
               }
               _loc1_++;
            }
         }
         if(this.gaiya_npc)
         {
            this.gaiya_npc.removeEventListener(MouseEvent.CLICK,this.clickGaiya);
         }
         this.boxBtn.removeEventListener(MouseEvent.CLICK,this.showBox);
         this.bombBtn.removeEventListener(MouseEvent.CLICK,this.showBombPane);
      }
      
      public function setup() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
         this.map = SceneManager.active.mapModel;
         this.boxBtn = this.map.front["boxBtn"];
         this.bombBtn = this.map.front["bombBtn"];
         DayLimitManager.getDoCount(this.FIGHT_STATE_ID,this.getFightNum);
         FishEventDispatcher.getInstance().addEventListener("buy_bomb_complete",this.buyBombComplete);
         StatisticsManager.sendNovice("0x1003396D");
      }
      
      private function getFightNum(param1:uint) : void
      {
         this.fight_state = param1;
         this.boxBtn.addEventListener(MouseEvent.CLICK,this.showBox);
         this.bombBtn.addEventListener(MouseEvent.CLICK,this.showBombPane);
         if(this.fight_state == 4095)
         {
            this.createGaiya();
            return;
         }
         this.createGuard();
         this.createGaiya();
      }
      
      private function createGaiya() : void
      {
         if(this.gaiya_npc)
         {
            return;
         }
         this.gaiya_npc = new Mobile();
         this.gaiya_npc.x = this.GAIYA_SEAT.x;
         this.gaiya_npc.y = this.GAIYA_SEAT.y;
         this.gaiya_npc.buttonMode = true;
         this.gaiya_npc.mouseChildren = false;
         this.gaiya_npc.resourceUrl = URLUtil.getNpcSwf(this.GAIYA_ID);
         this.gaiya_npc.addEventListener(MouseEvent.CLICK,this.clickGaiya);
         MobileManager.addMobile(this.gaiya_npc,MobileType.NPC);
      }
      
      private function createGuard() : void
      {
         var _loc1_:int = 0;
         this.guard_list = new Vector.<Mobile>();
         _loc1_ = 0;
         while(_loc1_ < this.MAX_NUM)
         {
            this.guard_list.push(null);
            if(!BitUtil.getBit(this.fight_state,_loc1_))
            {
               this.guard_list[_loc1_] = new Mobile();
               this.guard_list[_loc1_].x = this.GUARD_SEAT[_loc1_].x;
               this.guard_list[_loc1_].y = this.GUARD_SEAT[_loc1_].y;
               this.guard_list[_loc1_].buttonMode = true;
               this.guard_list[_loc1_].mouseChildren = false;
               this.guard_list[_loc1_].resourceUrl = URLUtil.getNpcSwf(this.GUARD_ID);
               this.guard_list[_loc1_].addEventListener(MouseEvent.CLICK,this.clickGuard);
               MobileManager.addMobile(this.guard_list[_loc1_],MobileType.NPC);
            }
            _loc1_++;
         }
      }
      
      private function showBombPane(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("GaiyaBombPanel"));
      }
      
      private function showBox(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("MedicineShopPanel"));
      }
      
      private function clickGaiya(param1:MouseEvent) : void
      {
         if(this.fight_state != 4095)
         {
            NpcDialog.show(this.GAIYA_ID,"盖亚",[[0,"战神盖亚在此，想挑战我，请先击败我的12只守护精灵吧！"]],["谁怕谁！这就去！"]);
            return;
         }
         ModuleManager.toggleModule(URLUtil.getAppModule(this.FIGHT_GAIYA_MODULE));
      }
      
      private function clickGuard(param1:MouseEvent) : void
      {
         var _loc2_:int = this.guard_list.indexOf(param1.target);
         ModuleManager.toggleModule(URLUtil.getAppModule(this.FIGHT_GUARD_MODULE),"",_loc2_ + 1);
      }
      
      private function buyBomb(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule(this.GAIYA_BOMB_MODULE));
      }
      
      private function buyBombComplete(param1:Event) : void
      {
         DayLimitManager.getDoCount(this.FIGHT_STATE_ID,this.getFightNum);
         QueueLoader.load(URLUtil.getActivityAnimation("GaiYaEft"),LoadType.DOMAIN,this.onLoadComplete);
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         var _loc4_:MovieClip = null;
         this._resLib = new ResourceLibrary(param1.content);
         this.eftList = new Vector.<MovieClip>();
         this.eft_mobile_list = [];
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_NUM)
         {
            if(this.guard_list[_loc2_])
            {
               (_loc4_ = this._resLib.getMovieClip("GaiYaEft")).x = this.GUARD_SEAT[_loc2_].x;
               _loc4_.y = this.GUARD_SEAT[_loc2_].y;
               this.map.content.addChild(_loc4_);
               this.eftList.push(_loc4_);
               this.eft_mobile_list.push(this.guard_list[_loc2_]);
            }
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.eftList.length)
         {
            MovieClipUtil.playMc(this.eftList[_loc3_],1,this.eftList[_loc3_].totalFrames,this.playComplete);
            _loc3_++;
         }
      }
      
      private function playComplete() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.eftList.length)
         {
            if(Boolean(this.eftList[_loc1_].parent) && this.eftList[_loc1_].currentFrame == this.eftList[_loc1_].totalFrames)
            {
               DisplayObjectUtil.removeFromParent(this.eftList[_loc1_]);
               MobileManager.removeMobile(this.eft_mobile_list[_loc1_],MobileType.NPC);
               break;
            }
            _loc1_++;
         }
      }
   }
}
