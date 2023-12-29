package com.taomee.seer2.app.controls
{
   import com.adobe.crypto.MD5;
   import com.greensock.TweenLite;
   import com.greensock.easing.Expo;
   import com.taomee.seer2.app.MainEntry;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.events.UserInfoEvent;
   import com.taomee.seer2.app.mail.GmailDataManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.PetPowerUpdate;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.app.vip.data.VipInfo;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.NumberUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import org.taomee.filter.ColorFilter;
   import org.taomee.manager.EventManager;
   
   public class ActorAvatarPanel extends Sprite
   {
      
      private static var _instance:ActorAvatarPanel;
      
      private static const _showXPos:int = 0;
      
      private static const _hideXPos:int = -207;
       
      
      private var _mainPanel:MovieClip;
      
      private var _actorMC:MovieClip;
      
      private var _teamMC:MovieClip;
      
      private var _vipMC:MovieClip;
      
      private var _jumpBtn:SimpleButton;
      
      private var _nameTxt:TextField;
      
      private var _passWordTipMC:MovieClip;
      
      private var mailBtn:MovieClip;
      
      private var _levelTxt:TextField;
      
      private var _xingzuanTxt:TextField;
      
      private var _conisTxt:TextField;
      
      private var _allNumList:Vector.<MovieClip>;
      
      private var _isRetract:Boolean = true;
      
      public function ActorAvatarPanel()
      {
         super();
         x = 0;
         this.createChildren();
         this.initEventListener();
         GmailDataManager.getInstance().updateMailNum();
      }
      
      public static function getInstance() : ActorAvatarPanel
      {
         if(_instance == null)
         {
            _instance = new ActorAvatarPanel();
         }
         return _instance;
      }
      
      public static function show() : void
      {
         if(_instance == null)
         {
            _instance = new ActorAvatarPanel();
         }
         _instance.updateData();
         LayerManager.uiLayer.addChild(_instance);
      }
      
      public static function hide() : void
      {
         DisplayObjectUtil.removeFromParent(_instance);
      }
      
      public static function darkenPanel() : void
      {
         if(_instance)
         {
            DisplayObjectUtil.darkenDisplayObject(_instance);
            DisplayObjectUtil.disableButtonMode(_instance);
         }
      }
      
      public static function recoverPanel() : void
      {
         if(_instance)
         {
            _instance.filters = [];
            DisplayObjectUtil.enableButtonMode(_instance);
         }
      }
      
      public static function showPassWord(param1:Boolean) : void
      {
         if(_instance)
         {
            _instance._passWordTipMC.visible = param1;
         }
      }
      
      public function setMailStatus(param1:int) : void
      {
         if(this.mailBtn == null)
         {
            return;
         }
         if(param1 <= 0)
         {
            (this.mailBtn["numTip"] as MovieClip).visible = false;
         }
         else
         {
            (this.mailBtn["numTip"] as MovieClip).visible = true;
            (this.mailBtn["numTip"]["numTxt"] as TextField).text = param1.toString();
         }
      }
      
      private function createChildren() : void
      {
         this._mainPanel = UIManager.getMovieClip("UI_ActorAvatar_Panel");
         addChild(this._mainPanel);
         this._actorMC = this._mainPanel["actor"];
         this._actorMC.buttonMode = true;
         this._teamMC = this._mainPanel["teamMC"];
         this._vipMC = this._mainPanel["vipMC"];
         this._jumpBtn = this._mainPanel["jumpBtn"];
         this._vipMC.buttonMode = true;
         this._nameTxt = this._mainPanel["nameTxt"];
         this._nameTxt.mouseEnabled = false;
         this.mailBtn = this._mainPanel["mailMc"];
         this.mailBtn.buttonMode = true;
         this._passWordTipMC = this._mainPanel["passWordTipMC"];
         this._passWordTipMC.mouseChildren = false;
         this._passWordTipMC.mouseEnabled = false;
         this._passWordTipMC.visible = false;
         this._levelTxt = this._mainPanel["levelTxt"];
         this._xingzuanTxt = this._mainPanel["xingzuanTxt"];
         ActorManager.actorInfo.addEventListener(UserInfoEvent.UPDATE_MONEY,this.onUpdate);
         ActorManager.actorInfo.addEventListener(UserInfoEvent.UPDATE_COIN,this.onUpdateCoin);
         this._conisTxt = this._mainPanel["conisTxt"];
         this._allNumList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            this._allNumList.push(this._mainPanel["allNum" + _loc1_]);
            this._allNumList[_loc1_].visible = false;
            _loc1_++;
         }
         this.updateAllPower();
         Connection.send(CommandSet.CLI_MONEY_COUNT_1253,this.getResult());
      }
      
      private function updateAllPower() : void
      {
         var _loc3_:PetInfo = null;
         var _loc1_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         var _loc2_:int = 0;
         for each(_loc3_ in _loc1_)
         {
            _loc2_ += PetInfoManager.getPowerByPetInfo(_loc3_);
         }
         this.showAllNumList(_loc2_);
      }
      
      private function showAllNumList(param1:int) : void
      {
         var _loc2_:Vector.<int> = NumberUtil.parseNumberToDigitVec(param1);
         var _loc3_:int = 0;
         while(_loc3_ < this._allNumList.length)
         {
            if(_loc3_ < _loc2_.length)
            {
               this._allNumList[_loc3_].gotoAndStop(_loc2_[_loc3_] + 1);
               this._allNumList[_loc3_].visible = true;
            }
            else
            {
               this._allNumList[_loc3_].visible = false;
            }
            _loc3_++;
         }
      }
      
      private function getResult() : LittleEndianByteArray
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         var _loc2_:String = String(MD5.hash("0"));
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.substr(_loc4_,2);
            _loc6_ = parseInt(_loc5_,16);
            _loc1_.writeByte(_loc6_);
            _loc4_ += 2;
         }
         return _loc1_;
      }
      
      private function onUpdate(param1:UserInfoEvent) : void
      {
         this.updateXingzuan();
      }
      
      private function onUpdateCoin(param1:UserInfoEvent) : void
      {
         this._conisTxt.text = ActorManager.actorInfo.coins.toString();
      }
      
      public function updateXingzuan() : void
      {
         this._xingzuanTxt.text = ActorManager.actorInfo.moneyCount.toString();
      }
      
      private function updateData() : void
      {
         var _loc1_:UserInfo = ActorManager.actorInfo;
         this._nameTxt.text = _loc1_.nick;
         this.onTrainerScoreUpdate(null);
         if(_loc1_.teamInfo.userPost == 1)
         {
            this._teamMC.visible = false;
            TooltipManager.addCommonTip(this._teamMC,_loc1_.teamInfo.name + "战队队长");
         }
         else
         {
            this._teamMC.visible = false;
         }
         this._vipMC.removeEventListener(MouseEvent.ROLL_OVER,this.onVipMcOver);
         this._vipMC.removeEventListener(MouseEvent.ROLL_OUT,this.onVipMcOut);
         if(VipManager.vipInfo.isVip() == false)
         {
            ColorFilter.setGrayscale(this._vipMC);
            TooltipManager.addCommonTip(this._vipMC,"加入VIP点亮图标");
         }
         else
         {
            this._vipMC.filters = [];
            TooltipManager.remove(this._vipMC);
            this._vipMC.addEventListener(MouseEvent.ROLL_OVER,this.onVipMcOver);
            this._vipMC.addEventListener(MouseEvent.ROLL_OUT,this.onVipMcOut);
         }
         this._levelTxt.text = "Lv" + ActorManager.actorInfo.trainerLevel.toString();
         this._actorMC.gotoAndStop(ActorManager.actorInfo.sex + 1);
         this._conisTxt.text = ActorManager.actorInfo.coins.toString();
      }
      
      private function onVipMcOver(param1:MouseEvent) : void
      {
         this.setFilter(this._vipMC);
      }
      
      private function onVipMcOut(param1:MouseEvent) : void
      {
         this._vipMC.filters = null;
      }
      
      private function initEventListener() : void
      {
         this._actorMC.addEventListener(MouseEvent.CLICK,this.onActor);
         this._actorMC.addEventListener(MouseEvent.ROLL_OVER,this.onActorMcOver);
         this._jumpBtn.addEventListener(MouseEvent.CLICK,this.onJumpBianQiang);
         this._actorMC.addEventListener(MouseEvent.ROLL_OUT,this.onActorMcOut);
         TooltipManager.addCommonTip(this._jumpBtn,"内网调试工具");
         TooltipManager.addCommonTip(this._actorMC,"训练师资料");
         ActorManager.actorInfo.addEventListener(UserInfoEvent.TRAINER_SCORE_UPDATE,this.onTrainerScoreUpdate);
         this._vipMC.addEventListener(MouseEvent.CLICK,this.onVip);
         VipManager.vipInfo.addEventListener(VipInfo.VIP_UPDATE,this.onVipUpdate);
         this.mailBtn.addEventListener(MouseEvent.CLICK,this.onClickMail);
         this.mailBtn.addEventListener(MouseEvent.ROLL_OVER,this.onMailOver);
         this.mailBtn.addEventListener(MouseEvent.ROLL_OUT,this.onMailOut);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
         ModuleManager.addEventListener("GmailPanel",ModuleEvent.HIDE,function onGailHide(param1:ModuleEvent):void
         {
            GmailDataManager.getInstance().updateMailNum();
         });
         EventManager.addEventListener(PetPowerUpdate.PET_RE_COUNT,this.onPetPowerUpdate);
         EventManager.addEventListener(PetPowerUpdate.PET_UPDATE,this.onPetPowerUpdate);
      }
      
      private function onJumpBianQiang(param1:MouseEvent) : void
      {
         //ModuleManager.showAppModule("NewGuidelines");
         MainEntry.showDebugToolPanel(true);
      }
      
      private function onPetPowerUpdate(param1:Event = null) : void
      {
         this.updateAllPower();
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active.type != SceneType.ARENA)
         {
            this._conisTxt.text = ActorManager.actorInfo.coins.toString();
         }
      }
      
      private function onMailOver(param1:MouseEvent) : void
      {
         this.setFilter(this.mailBtn);
      }
      
      private function onMailOut(param1:MouseEvent) : void
      {
         this.mailBtn.filters = null;
      }
      
      private function onActorMcOver(param1:MouseEvent) : void
      {
         this.setFilter(this._actorMC);
      }
      
      private function setFilter(param1:DisplayObject) : void
      {
         var _loc2_:GlowFilter = new GlowFilter();
         _loc2_.blurX = 10;
         _loc2_.blurY = 10;
         _loc2_.color = 6750207;
         _loc2_.inner = false;
         param1.filters = [_loc2_];
      }
      
      private function onActorMcOut(param1:MouseEvent) : void
      {
         this._actorMC.filters = null;
      }
      
      private function onClickMail(param1:MouseEvent) : void
      {
         if(this.mailBtn.currentFrame != 1)
         {
            this.mailBtn.gotoAndStop(1);
         }
         ModuleManager.showModule(URLUtil.getAppModule("GmailPanel"),"");
      }
      
      private function onVipUpdate(param1:Event) : void
      {
      }
      
      private function retracte() : void
      {
         this._isRetract = false;
         LeftMinorToolBar.hide();
         TweenLite.to(this,0.6,{
            "x":_hideXPos,
            "ease":Expo.easeOut
         });
      }
      
      private function expand(param1:Boolean = true) : void
      {
         this._isRetract = true;
         LeftMinorToolBar.show();
         if(param1)
         {
            TweenLite.to(this,0.6,{
               "x":_showXPos,
               "ease":Expo.easeOut
            });
         }
         else
         {
            x = _showXPos;
         }
      }
      
      private function onVip(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("SuperNonoPanel"),"",{"currentTab":0});
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_360);
      }
      
      private function onTrainerScoreUpdate(param1:UserInfoEvent) : void
      {
         var _loc2_:UserInfo = ActorManager.actorInfo;
         var _loc3_:Number = _loc2_.currentLevelExp / _loc2_.nextLevelNeedExp;
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
      }
      
      private function onActor(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("UserPanel"),"正在打开个人信息面板...",ActorManager.actorInfo.id);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_314);
         this._passWordTipMC.visible = false;
      }
   }
}
