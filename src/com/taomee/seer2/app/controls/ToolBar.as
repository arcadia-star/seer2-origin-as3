package com.taomee.seer2.app.controls
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.controls.toolbar.emotion.EmotionSelectPanel;
   import com.taomee.seer2.app.controls.widget.ActorBagWidgetClick;
   import com.taomee.seer2.app.controls.widget.AllPetBagWidgetClick;
   import com.taomee.seer2.app.controls.widget.BatteryTimeWidget;
   import com.taomee.seer2.app.controls.widget.BuddyWidgetClick;
   import com.taomee.seer2.app.controls.widget.ChatInputFrameWidget;
   import com.taomee.seer2.app.controls.widget.ChatMessageBoardWidget;
   import com.taomee.seer2.app.controls.widget.DicInputFrameWidget;
   import com.taomee.seer2.app.controls.widget.EmotionWidgetClick;
   import com.taomee.seer2.app.controls.widget.HeaderShootWidgetClick;
   import com.taomee.seer2.app.controls.widget.HomeInputFrameWidget;
   import com.taomee.seer2.app.controls.widget.NonoInputFrameWidget;
   import com.taomee.seer2.app.controls.widget.ShipMapWidgetClick;
   import com.taomee.seer2.app.controls.widget.ShouyouWidgetClick;
   import com.taomee.seer2.app.controls.widget.SpringLessTaobaoToolbar;
   import com.taomee.seer2.app.controls.widget.SystemWidgetClick;
   import com.taomee.seer2.app.controls.widget.TeamWidgetClick;
   import com.taomee.seer2.app.controls.widget.ToolBarRadioWidget;
   import com.taomee.seer2.app.controls.widget.ToolBarWidget;
   import com.taomee.seer2.app.controls.widget.TrainerWidgetClick;
   import com.taomee.seer2.app.controls.widget.WorldMapWidgetClick;
   import com.taomee.seer2.app.controls.widget.YueseNonoWidgetClick;
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.map.MapCategory;
   import com.taomee.seer2.app.onlineServiceController.OnlineServiceController;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import org.taomee.ds.HashMap;
   
   public class ToolBar extends Sprite
   {
      
      private static var _instance:ToolBar;
       
      
      private var _mainUI:MovieClip;
      
      private var _widgetMap:HashMap;
      
      private var _emotionPanel:EmotionSelectPanel;
      
      private var _difficultyBtn:SimpleButton;
      
      private var _springLessTaobao:SpringLessTaobaoToolbar;
      
      public function ToolBar()
      {
         super();
         mouseEnabled = false;
         this._mainUI = UIManager.getMovieClip("UI_ToolBarUI");
         addChild(this._mainUI);
         this.createPanel();
         this.createWidget();
         this.initEventListener();
         this.layIcons();
      }
      
      private static function get instance() : ToolBar
      {
         if(_instance == null)
         {
            _instance = new ToolBar();
         }
         return _instance;
      }
      
      public static function layIcons() : void
      {
         instance.layIcons();
      }
      
      public static function show() : void
      {
         LayerManager.uiLayer.addChild(instance);
         GiftRemind.instance.setAllBtnsVisible(true);
      }
      
      public static function hide() : void
      {
         if(instance)
         {
            DisplayObjectUtil.removeFromParent(instance);
            instance._emotionPanel.hide();
            instance._widgetMap.getValue(ChatMessageBoardWidget.CHAT_OUTPUT).hide();
         }
         GiftRemind.instance.setAllBtnsVisible(false);
      }
      
      public static function disableAllBtn() : void
      {
         var _loc1_:Sprite = null;
         for each(_loc1_ in _instance._widgetMap.getValues())
         {
            DisplayObjectUtil.disableSprite(_loc1_);
         }
      }
      
      public static function enableAllBtn() : void
      {
         var _loc1_:Sprite = null;
         for each(_loc1_ in _instance._widgetMap.getValues())
         {
            DisplayObjectUtil.enableSprite(_loc1_);
         }
      }
      
      public static function disableBtn(param1:String) : void
      {
         var _loc2_:Sprite = getBtn(param1);
         DisplayObjectUtil.grayDisplayObject(_loc2_);
         DisplayObjectUtil.disableSprite(_loc2_);
      }
      
      public static function enableBtn(param1:String) : void
      {
         var _loc2_:Sprite = getBtn(param1);
         DisplayObjectUtil.recoverDisplayObject(_loc2_);
         DisplayObjectUtil.enableSprite(_loc2_);
      }
      
      public static function getBtn(param1:String) : Sprite
      {
         return instance._widgetMap.getValue(param1) as Sprite;
      }
      
      public static function addBtnEffect(param1:Sprite) : void
      {
         instance.addChild(param1);
      }
      
      public static function addSpringLess(param1:uint) : void
      {
         instance.showSpringLess(param1);
      }
      
      public static function getWidget(param1:String) : IWidgetable
      {
         return instance._widgetMap.getValue(param1) as IWidgetable;
      }
      
      private function layIcons() : void
      {
         var _loc1_:Number = 1200 - LayerManager.stage.stageWidth;
         this._mainUI.scaleX = LayerManager.stage.stageWidth / 1200;
         this._mainUI.scaleY = this._mainUI.scaleX;
         this._mainUI.x = 0;
         this._mainUI.y = LayerManager.stage.stageHeight - 342 * this._mainUI.scaleY;
         this._emotionPanel.x = 115 * this._mainUI.scaleX;
         this._emotionPanel.y = 148 * this._mainUI.scaleY;
      }
      
      private function createWidget() : void
      {
         var onUserUp:Function = null;
         onUserUp = function():void
         {
            OnlineServiceController.show();
         };
         var onRemoteUserOn:Function = function():void
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_19);
            ActorManager.showRemoteActor = true;
         };
         var onRemoteUserOff:Function = function():void
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_19);
            ActorManager.showRemoteActor = false;
         };
         var onSoundOff:Function = function():void
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_18);
            var _loc1_:SoundTransform = new SoundTransform(0);
            SoundMixer.soundTransform = _loc1_;
            writeSoundCookie(false);
         };
         var onSoundOn:Function = function():void
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_18);
            var _loc1_:SoundTransform = new SoundTransform(1);
            SoundMixer.soundTransform = _loc1_;
            writeSoundCookie(true);
         };
         this._widgetMap = new HashMap();
         this.addToolBarWidget(WorldMapWidgetClick.MAP,this._mainUI["mapBtn"],null,"大地图",new WorldMapWidgetClick());
         this.addToolBarWidget(ShipMapWidgetClick.SHIP_MAP,this._mainUI["shipmapBtn"],null,"小地图",new ShipMapWidgetClick());
         this.addToolBarWidget(EmotionWidgetClick.EMOTION,this._mainUI["emotionBtn"],null,"表情",new EmotionWidgetClick(this._emotionPanel));
         this.addToolBarWidget(HeaderShootWidgetClick.SHOOT,this._mainUI["shootBtn"],null,"头部射击",new HeaderShootWidgetClick());
         this.addToolBarWidget(BuddyWidgetClick.BUDDY,this._mainUI["buddyBtn"],this._mainUI["buddyMc"],"好友",new BuddyWidgetClick());
         this.addToolBarWidget(TeamWidgetClick.TEAM,this._mainUI["teamBtn"],this._mainUI["teamMc"],"战队",new TeamWidgetClick());
         this.addToolBarWidget(TrainerWidgetClick.TRAINER,this._mainUI["trainerBtn"],null,"训练师",new TrainerWidgetClick());
         this.addToolBarWidget(ActorBagWidgetClick.ACTOR_BAG,this._mainUI["actorBag"],null,"背包",new ActorBagWidgetClick());
         this.addToolBarWidget(AllPetBagWidgetClick.ALL_PET_BAG,this._mainUI["petBag"],null,"精灵",new AllPetBagWidgetClick());
         this.addWidget(ChatMessageBoardWidget.CHAT_OUTPUT,new ChatMessageBoardWidget(this._mainUI["chatOutput"]),0);
         this.addWidget(ChatInputFrameWidget.CHAT_INPUT,new ChatInputFrameWidget(this._mainUI["chatInput"]));
         this.addWidget(BatteryTimeWidget.TIME,new BatteryTimeWidget(this._mainUI["timePanel"]));
         this.addWidget(NonoInputFrameWidget.NONOINPUT,new NonoInputFrameWidget(this._mainUI["nonoPanel"]));
         this.addWidget(HomeInputFrameWidget.HOME_INPUT,new HomeInputFrameWidget(this._mainUI["homePanel"]));
         this.addWidget(DicInputFrameWidget.DIC_INPUT,new DicInputFrameWidget(this._mainUI["dicPanel"]));
         this.addWidget(YueseNonoWidgetClick.YUESE_NONO,new YueseNonoWidgetClick(this._mainUI["yueseNono"]));
         this.addWidget(SystemWidgetClick.SYSTEM_WIDGET,new SystemWidgetClick(this._mainUI["systemPanel"]));
         //this.addWidget(ShouyouWidgetClick.SHOUYOU_WIDGET,new ShouyouWidgetClick(this._mainUI["shouyouBtn"]));
         this._mainUI["userUp"].gotoAndStop(1);
         this._mainUI["userUp"].buttonMode = true;
         this._mainUI.addChild(this._mainUI["userUp"]);
         this._mainUI["userUp"].addEventListener(MouseEvent.CLICK,onUserUp);
         TooltipManager.addCommonTip(this._mainUI["userUp"],"在线提问");
         this.readSound();
      }
      
      private function showSpringLess(param1:uint) : void
      {
         if(SceneManager.active.type == SceneType.LOBBY || SceneManager.active.type == SceneType.COPY)
         {
            if(this._springLessTaobao._isShow == false)
            {
               this._springLessTaobao.show(param1);
            }
         }
      }
      
      private function onJl(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("JLPanel"),"正在打开...");
      }
      
      private function addRadioWidget(param1:String, param2:MovieClip, param3:Array, param4:Array, param5:Boolean = true) : void
      {
         var _loc6_:ToolBarRadioWidget;
         (_loc6_ = new ToolBarRadioWidget(param2,param3,param4)).toggle(param5);
         this._mainUI.addChild(_loc6_);
         this._widgetMap.add(param1,_loc6_);
      }
      
      private function addWidget(param1:String, param2:IWidgetable, param3:int = -1) : void
      {
         if(param3 != -1)
         {
            this._mainUI.addChildAt(param2 as DisplayObject,param3);
         }
         else
         {
            this._mainUI.addChild(param2 as DisplayObject);
         }
         this._widgetMap.add(param1,param2);
      }
      
      private function addToolBarWidget(param1:String, param2:SimpleButton, param3:MovieClip, param4:String, param5:IToolBarWidgetClick) : void
      {
         var _loc6_:ToolBarWidget = new ToolBarWidget(param2,param3,param4,param5);
         param5.widget = _loc6_;
         this._mainUI.addChild(_loc6_);
         this._widgetMap.add(param1,_loc6_);
      }
      
      private function createPanel() : void
      {
         this._emotionPanel = new EmotionSelectPanel();
         this._emotionPanel.hide();
         this._mainUI.addChild(this._emotionPanel);
      }
      
      private function readSound() : void
      {
         var _loc2_:SoundTransform = null;
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.USER_SETTING);
         if(_loc1_.data["sound"] == null || _loc1_.data["sound"] == 1)
         {
            _loc1_.data["sound"] = 1;
            _loc2_ = new SoundTransform(1);
            SoundMixer.soundTransform = _loc2_;
         }
         else
         {
            _loc2_ = new SoundTransform(0);
            SoundMixer.soundTransform = _loc2_;
         }
      }
      
      private function writeSoundCookie(param1:Boolean) : void
      {
         var _loc2_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.USER_SETTING);
         _loc2_.data["sound"] = param1 ? 1 : 0;
         SharedObjectManager.flush(_loc2_);
      }
      
      private function initEventListener() : void
      {
         this.updateVipRewardStatus();
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
      }
      
      private function updateVipRewardStatus() : void
      {
         if(VipManager.vipInfo.vipFlag == 0)
         {
            return;
         }
         ActiveCountManager.requestActiveCount(VipManager.vipInfo.level + 9,function(param1:int, param2:int):void
         {
            var type:int = param1;
            var times:int = param2;
            if(times != 0)
            {
               ActiveCountManager.requestActiveCount(VipManager.vipInfo.level + 100000,function(param1:int, param2:int):void
               {
                  if(param2 == 0)
                  {
                  }
               });
            }
         });
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active.mapCategoryID == MapCategory.VIP || SceneManager.active.mapCategoryID == MapCategory.CHRISTMAS || SceneManager.active.mapCategoryID == MapCategory.TEAM || SceneManager.active.mapCategoryID == MapCategory.FASTING || SceneManager.active.mapID == 80075)
         {
            ToolBar.disableBtn(ShipMapWidgetClick.SHIP_MAP);
         }
         else
         {
            ToolBar.enableBtn(ShipMapWidgetClick.SHIP_MAP);
         }
      }
   }
}
