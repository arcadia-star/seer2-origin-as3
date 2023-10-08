package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.config.TimeLimitConfig;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.CommonUseManager;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_3849 extends MapProcessor
   {
       
      
      private var _npc766:Mobile;
      
      private var cancelBtn:SimpleButton;
      
      private var timeMc:MovieClip;
      
      private var _teleport:Teleport;
      
      private var leftTime:int;
      
      private var isTake:int;
      
      private var isPlaying:int;
      
      public function MapProcessor_3849(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(TimeLimitConfig.InLimitTime(260) == false)
         {
            return;
         }
         StatisticsManager.newSendNovice("2015活动","小梦的轰趴派对","进入场景");
         this.initMc();
         CommonUseManager.hideLobbyMenu();
         this.udpateDate();
      }
      
      private function initMc() : void
      {
         this.cancelBtn = _map.front["cancelBtn"];
         this.cancelBtn.addEventListener(MouseEvent.CLICK,this.onCancel);
         this.timeMc = _map.front["timeMc"];
         this.createTeleport();
      }
      
      private function onCancel(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("SmallDreamBirthdayPartyPausePanel");
      }
      
      private function udpateDate() : void
      {
         ActiveCountManager.requestActiveCountList([205800],function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            isPlaying = par.infoVec[0];
            DayLimitListManager.getDaylimitList([1705,1706],function(param1:DayLimitListInfo):void
            {
               leftTime = 900 - param1.getCount(1705);
               isTake = param1.getCount(1706);
               if(leftTime > 0)
               {
                  updateTimeTxt();
                  if(Tick.instance.hasRender(updateTime) == false)
                  {
                     Tick.instance.addRender(updateTime,1000);
                  }
               }
               else if(!isTake)
               {
                  ModuleManager.showAppModule("SmallDreamBirthdayPartyResultPanel");
               }
               if(par.infoVec[0] <= 0)
               {
                  timeMc.visible = false;
                  cancelBtn.visible = false;
                  createNpc766();
               }
            });
         });
      }
      
      private function updateTimeTxt() : void
      {
         --this.leftTime;
         this.timeMc["timeTxt"].text = DateUtil.getMS(this.leftTime);
      }
      
      private function updateTime(param1:uint) : void
      {
         if(this.leftTime <= 0)
         {
            Tick.instance.removeRender(this.updateTime);
            SceneManager.changeScene(SceneType.LOBBY,70);
            ModuleManager.showAppModule("SmallDreamBirthdayPartyResultPanel");
         }
         else
         {
            this.updateTimeTxt();
         }
      }
      
      private function createNpc766() : void
      {
         var _loc1_:MouseClickHintSprite = null;
         if(!this._npc766)
         {
            this._npc766 = new Mobile();
            this._npc766.setPostion(new Point(750,450));
            this._npc766.resourceUrl = URLUtil.getNpcSwf(766);
            this._npc766.buttonMode = true;
            MobileManager.addMobile(this._npc766,MobileType.NPC);
            _loc1_ = new MouseClickHintSprite();
            this._npc766.addChild(_loc1_);
            _loc1_.y = -100;
            this._npc766.addEventListener(MouseEvent.CLICK,this.onDialog);
         }
      }
      
      private function onDialog(param1:MouseEvent) : void
      {
         if(this.isTake <= 0 && this.leftTime <= 0)
         {
            ModuleManager.showAppModule("SmallDreamBirthdayPartyResultPanel");
            return;
         }
         SceneManager.changeScene(SceneType.LOBBY,70);
         ModuleManager.showAppModule("SmallDreamBirthdayPartyPanel");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._npc766)
         {
            MobileManager.removeMobile(this._npc766,MobileType.NPC);
            this._npc766 = null;
         }
         if(Tick.instance.hasRender(this.updateTime))
         {
            Tick.instance.removeRender(this.updateTime);
         }
         RightToolbarConter.instance.show();
         if(this._teleport)
         {
            DisplayObjectUtil.removeFromParent(this._teleport);
            this._teleport = null;
         }
      }
      
      private function createTeleport() : void
      {
         var _loc1_:XML = <teleport id="1" name="淘米市场" pos="422,560" targetMapId="330" targetPos="990,574"/>;
         this._teleport = new Teleport();
         this._teleport.setData(_loc1_);
         SceneManager.active.mapModel.content.addChild(this._teleport);
         this._teleport.addEventListener(MouseEvent.CLICK,this.onActivityTeleportClick,false,1);
      }
      
      private function hideTeleport() : void
      {
         if(this._teleport)
         {
            this._teleport.visible = false;
         }
      }
      
      private function onActivityTeleportClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(this.isPlaying > 0)
         {
            ModuleManager.showAppModule("SmallDreamBirthdayPartyPausePanel",{
               "tele":this._teleport,
               "event":param1
            });
         }
         else
         {
            (param1.target as Teleport).onMouseClick(param1);
            (SceneManager.active as LobbyScene).showToolbar();
         }
      }
   }
}
