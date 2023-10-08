package com.taomee.seer2.app.controls
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.controls.petAvatarPanel.PetItem;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class PetAvatarPanel extends Sprite
   {
      
      private static var _instance:com.taomee.seer2.app.controls.PetAvatarPanel;
      
      private static const _showXPos:int = 68;
      
      private static const _hideXPos:int = -142;
       
      
      private var _mainPanel:MovieClip;
      
      private var _isRetract:Boolean = true;
      
      private var _recoverBtn:SimpleButton;
      
      private var _petListBg:MovieClip;
      
      private var _showPetBtn:SimpleButton;
      
      private var _petListSp:Sprite;
      
      private var _mainPetItem:PetItem;
      
      private var colorEggBtn:SimpleButton;
      
      private var _startingPetInfo:PetInfo;
      
      private var _petList:Vector.<PetItem>;
      
      private var oldCoinNum:int = 0;
      
      public function PetAvatarPanel()
      {
         super();
         x = 169;
         y = 100;
         this.createChildren();
         this.initEventListener();
      }
      
      public static function show() : void
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.controls.PetAvatarPanel();
         }
         _instance.updateData();
         LayerManager.uiLayer.addChild(_instance);
         ActorAvatarPanel.show();
         _instance.checkIcon();
      }
      
      public static function hide() : void
      {
         DisplayObjectUtil.removeFromParent(_instance);
         ActorAvatarPanel.hide();
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
      
      public static function hideExpIcon() : void
      {
      }
      
      private function initColoreeg() : void
      {
         this.colorEggBtn = UIManager.getButton("UI_ColorEgg");
         this.colorEggBtn.x = 90;
         this.colorEggBtn.y = 68;
         this.colorEggBtn.addEventListener(MouseEvent.CLICK,this.showPanel);
         addChild(this.colorEggBtn);
      }
      
      private function createChildren() : void
      {
         this._mainPanel = UIManager.getMovieClip("UI_PetAvatar_Panel");
         addChild(this._mainPanel);
         this.checkIcon();
         this._recoverBtn = this._mainPanel["recoverBtn"];
         TooltipManager.addCommonTip(this._recoverBtn,"恢复全部精灵体力");
         this._petListSp = new Sprite();
         this._petListSp.x = 180;
         this._petListSp.y = 31;
         addChild(this._petListSp);
         this._petListSp.buttonMode = true;
         this._showPetBtn = this._mainPanel["showPetBtn"];
         this._showPetBtn.x = -248;
         this._showPetBtn.y = 2;
         this._petListSp.addChild(this._showPetBtn);
         this._petListSp.addEventListener(MouseEvent.ROLL_OVER,this.onPetListShow);
         this._petListSp.addEventListener(MouseEvent.ROLL_OUT,this.onPetListHide);
         this._petListBg = this._mainPanel["petListBg"];
         this._petListSp.addChild(this._petListBg);
         this._petListBg.x = -100 - 185;
         this._petListBg.y = -33 + 37;
         this._petListBg.visible = false;
         this._mainPetItem = new PetItem();
         addChild(this._mainPetItem);
         this._mainPetItem.getPetIconMC().buttonMode = true;
         TooltipManager.addCommonTip(this._mainPetItem.getPetIconMC(),"精灵背包");
      }
      
      private function onPetListShow(param1:MouseEvent) : void
      {
         var _loc3_:PetInfo = null;
         var _loc4_:PetItem = null;
         var _loc5_:int = 0;
         var _loc6_:PetItem = null;
         if(this._startingPetInfo == null)
         {
            return;
         }
         LayerManager.uiLayer.setChildIndex(_instance,LayerManager.uiLayer.numChildren - 1);
         if(this._petList)
         {
            for each(_loc6_ in this._petList)
            {
               _loc6_.dispose();
            }
            this._petList = null;
         }
         this._petList = new Vector.<PetItem>();
         var _loc2_:Vector.<PetInfo> = new Vector.<PetInfo>();
         for each(_loc3_ in PetInfoManager.getAllBagPetInfo())
         {
            if(_loc3_.catchTime != this._startingPetInfo.catchTime)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = new PetItem();
            this._petListSp.addChild(_loc4_);
            this._petList.push(_loc4_);
            _loc4_.x = 3 - 185;
            _loc4_.y = 2 + (_loc4_.height + 2) * _loc5_ + 37;
            _loc4_.info = _loc2_[_loc5_];
            _loc5_++;
         }
         if(_loc2_.length == 0)
         {
            this._petListBg.height = 0;
         }
         else
         {
            this._petListBg.height = 5 + 57 * _loc2_.length;
         }
         this._petListBg.visible = true;
      }
      
      private function onPetListHide(param1:MouseEvent) : void
      {
         var _loc2_:PetItem = null;
         if(this._petList)
         {
            for each(_loc2_ in this._petList)
            {
               _loc2_.dispose();
            }
            this._petList = null;
         }
         this._petListBg.visible = false;
      }
      
      private function checkIcon() : void
      {
      }
      
      private function showPanel(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("LuckySeerGeneralPanel"),"抽奖");
      }
      
      private function updateData() : void
      {
         this._startingPetInfo = PetInfoManager.getFirstPetInfo();
         if(this._startingPetInfo != null)
         {
            this._mainPetItem.info = this._startingPetInfo;
         }
      }
      
      private function initEventListener() : void
      {
         this._recoverBtn.addEventListener(MouseEvent.CLICK,this.onRecover);
         PetInfoManager.addEventListener(PetInfoEvent.PET_CURE,this.onPetCure);
         PetInfoManager.addEventListener(PetInfoEvent.PET_PROPERTIES_CHANGE,this.onPetPropertiesChange);
         PetInfoManager.addEventListener(PetInfoEvent.PET_CHANGE_STARTING,this.onPetStart);
         if(PetInfoManager.getFirstPetInfo() == null)
         {
            PetInfoManager.addEventListener(PetInfoEvent.PET_ADD,this.onAddFirstPet);
         }
         this._mainPetItem.getPetIconMC().addEventListener(MouseEvent.ROLL_OVER,this.onMainIconOver);
         this._mainPetItem.getPetIconMC().addEventListener(MouseEvent.ROLL_OUT,this.onMainIconOut);
         this._mainPetItem.getPetIconMC().addEventListener(MouseEvent.CLICK,this.onShowPetBag);
         this._mainPetItem.lvLink.addEventListener(MouseEvent.ROLL_OVER,this.onMainPetItemOver);
         this._mainPetItem.lvLink.addEventListener(MouseEvent.ROLL_OUT,this.onMainPetItemOut);
      }
      
      private function onMainPetItemOver(param1:MouseEvent) : void
      {
         this.setFilter(this._mainPetItem.lvLink);
      }
      
      private function onMainPetItemOut(param1:MouseEvent) : void
      {
         this._mainPetItem.lvLink.filters = null;
      }
      
      private function onMainIconOver(param1:MouseEvent) : void
      {
         this.setFilter(this._mainPetItem.getPetIconMC());
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
      
      private function onMainIconOut(param1:MouseEvent) : void
      {
         this._mainPetItem.getPetIconMC().filters = null;
      }
      
      private function onAddFirstPet(param1:PetInfoEvent) : void
      {
         var _loc2_:PetInfo = param1.info;
         if(this._startingPetInfo != null && _loc2_.catchTime == this._startingPetInfo.catchTime)
         {
            this.updateData();
         }
      }
      
      private function onRecover(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_316);
         if(QuestManager.isAccepted(68) && QuestManager.isStepComplete(68,2))
         {
            this.completeRecoverPetGudie();
            ServerMessager.addMessage("背包中所有精灵已经恢复成功！");
            return;
         }
         if(PetInfoManager.canCure() == false)
         {
            ServerMessager.addMessage("你的精灵不需要恢复");
            return;
         }
         if(VipManager.vipInfo.isVip())
         {
            this.oldCoinNum = ActorManager.actorInfo.coins;
            this.recoverAllPetBagPet();
         }
         else
         {
            ModuleManager.showAppModule("CurePetsTipPanel");
         }
      }
      
      private function recoverAllPetBagPet() : void
      {
         Connection.addCommandListener(CommandSet.TREAT_ALL_PET_1215,this.onAddAllPetBlood);
         Connection.send(CommandSet.TREAT_ALL_PET_1215);
      }
      
      private function onAddAllPetBlood(param1:MessageEvent) : void
      {
         var _loc3_:PetInfo = null;
         var _loc4_:int = 0;
         Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215,this.onAddAllPetBlood);
         var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         for each(_loc3_ in _loc2_)
         {
            _loc3_.hp = _loc3_.maxHp;
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE,_loc3_);
         }
         _loc4_ = int(param1.message.getRawData().readUnsignedInt());
         ActorManager.actorInfo.coins = _loc4_;
         ServerMessager.addMessage("你是VIP，每次战斗之后自动并且免费回血哦。");
      }
      
      private function completeRecoverPetGudie() : void
      {
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.completeStep(68,3);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         if(param1.questId == 68)
         {
         }
      }
      
      private function onPetPropertiesChange(param1:PetInfoEvent) : void
      {
         var _loc2_:PetInfo = param1.info;
         if(this._startingPetInfo != null && _loc2_.catchTime == this._startingPetInfo.catchTime)
         {
            this.updateData();
         }
      }
      
      private function onPetCure(param1:PetInfoEvent) : void
      {
         var _loc2_:PetInfo = param1.info;
         if(this._startingPetInfo != null && _loc2_.catchTime == this._startingPetInfo.catchTime)
         {
            this.updateData();
         }
      }
      
      private function onPetStart(param1:PetInfoEvent) : void
      {
         var _loc2_:PetInfo = PetInfoManager.getFirstPetInfo();
         if(this._startingPetInfo != null)
         {
            this._startingPetInfo = _loc2_;
            this.updateData();
         }
      }
      
      private function onShowPetBag(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_315);
         ModuleManager.toggleModule(URLUtil.getAppModule("PetBagPanel"),"正在打开" + "精灵背包" + "...");
      }
      
      public function dispose() : void
      {
         PetInfoManager.removeEventListener(PetInfoEvent.PET_CURE,this.onPetCure);
         PetInfoManager.removeEventListener(PetInfoEvent.PET_CHANGE_STARTING,this.onPetStart);
         PetInfoManager.removeEventListener(PetInfoEvent.PET_PROPERTIES_CHANGE,this.onPetPropertiesChange);
      }
   }
}
