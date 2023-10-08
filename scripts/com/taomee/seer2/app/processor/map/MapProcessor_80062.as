package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class MapProcessor_80062 extends MapProcessor
   {
      
      private static const FIGHT_INDEX:Vector.<int> = Vector.<int>([634,635,636,637]);
      
      private static const FIGHT_WIN_FOR:uint = 203339;
      
      private static const FIGHT_NUM_DAY:uint = 841;
      
      private static const NPC_ID:Vector.<int> = Vector.<int>([603,630,619,620]);
      
      private static const BOSS_POS:Array = [[220,365],[365,230],[550,280],[765,350]];
      
      private static const BOSS_SIZE:Array = [[85,110],[126,135],[80,104],[140,150]];
       
      
      private var _resLib:ApplicationDomain;
      
      private var _menu:MovieClip;
      
      private var _bossList:Vector.<Mobile>;
      
      private var _bossState:int;
      
      private var _fightNum:int;
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function MapProcessor_80062(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initBloodPlusAct();
      }
      
      private function initBloodPlusAct() : void
      {
         this.getURL();
         this.addBoss();
         this.updateState();
      }
      
      private function addBoss() : void
      {
         var _loc1_:Mobile = null;
         var _loc2_:int = 0;
         this._bossList = new Vector.<Mobile>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new Mobile();
            _loc1_.width = BOSS_SIZE[_loc2_][0];
            _loc1_.height = BOSS_SIZE[_loc2_][1];
            _loc1_.x = BOSS_POS[_loc2_][0];
            _loc1_.y = BOSS_POS[_loc2_][1];
            _loc1_.buttonMode = true;
            _loc1_.resourceUrl = URLUtil.getNpcSwf(NPC_ID[_loc2_]);
            MobileManager.addMobile(_loc1_,MobileType.NPC);
            this._bossList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function removeResAndVars() : void
      {
         var _loc1_:int = 0;
         if(this._bossList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._bossList.length)
            {
               DisplayUtil.removeForParent(this._bossList[_loc1_]);
               _loc1_++;
            }
            this._bossList = null;
         }
         DisplayUtil.removeForParent(this._menu);
         this._menu = null;
         this.removeMouseHint();
         this._resLib = null;
      }
      
      private function addBossClickEvent() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._bossList.length)
         {
            this._bossList[_loc1_].addEventListener(MouseEvent.CLICK,this.onBossClick);
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         if(this._bossList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._bossList.length)
            {
               this._bossList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onBossClick);
               _loc1_++;
            }
         }
         if(this._menu)
         {
            this._menu.removeEventListener(MouseEvent.CLICK,this.onMenu);
         }
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var _loc2_:int = this._bossList.indexOf(param1.currentTarget);
         if(_loc2_ > this._bossState)
         {
            AlertManager.showAlert("战胜前面几位幻灵骑士再来和我挑战吧!");
         }
         else if(_loc2_ < this._bossState)
         {
            AlertManager.showAlert("我已被挑战成功，请挑战之后的幻灵骑士吧!");
         }
         else if(this._fightNum > 0)
         {
            FightManager.startFightWithWild(FIGHT_INDEX[_loc2_]);
         }
         else
         {
            AlertManager.showAlert("你今天的挑战次数已用完，明天再来吧!");
         }
      }
      
      private function showMouseHintAtMonster(param1:Sprite) : void
      {
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -param1.height - 10;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
         param1.addChild(this._mouseHint);
      }
      
      private function removeMouseHint() : void
      {
         DisplayUtil.removeForParent(this._mouseHint);
         this._mouseHint = null;
      }
      
      private function updateState() : void
      {
         ActiveCountManager.requestActiveCount(FIGHT_WIN_FOR,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var val:uint = param2;
            DayLimitManager.getDoCount(FIGHT_NUM_DAY,function(param1:int):void
            {
               if(ActorManager.actorInfo.vipInfo.isVip())
               {
                  _fightNum = 10 - param1;
               }
               else
               {
                  _fightNum = 8 - param1;
               }
               _bossState = val;
               addBossClickEvent();
               showMouseHintAtMonster(_bossList[_bossState]);
            });
         });
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("BloodKingAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            addMenu();
         });
      }
      
      private function addMenu() : void
      {
         this._menu = this.getMovie("Menu");
         this._menu.buttonMode = true;
         TooltipManager.addCommonTip(this._menu,"获得幻灵骑士团精灵");
         this._menu.addEventListener(MouseEvent.CLICK,this.onMenu);
      }
      
      private function onMenu(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("EidolonPanel"),"正在打开幻灵骑士团面板...");
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      private function disposeBloodPlusAct() : void
      {
         this.removeEvent();
         this.removeResAndVars();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.disposeBloodPlusAct();
      }
   }
}
