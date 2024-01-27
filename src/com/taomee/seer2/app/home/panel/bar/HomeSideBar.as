package com.taomee.seer2.app.home.panel.bar {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.ds.HashMap;

public class HomeSideBar extends HomeBar {

    public static const HOME_DAYILY_BTN:String = "homeDailyBtn";

    public static const HOME_NEWS_BTN:String = "buddyNewsBtn";

    public static const TRAINING_PET_BTN:String = "trainingPetBtn";

    public static const PET_STORAGE_BTN:String = "petStorageBtn";


    private var _buddyNewsBtn:SimpleButton;

    private var _trainingPetBtn:SimpleButton;

    private var _petStorageBtn:SimpleButton;

    private var _medalBtn:SimpleButton;

    private var _birthBtn:SimpleButton;

    private var _planetBtn:SimpleButton;

    private var _petBagBtn:SimpleButton;

    private var _nextBtn:SimpleButton;

    private var _sideBtnMap:HashMap;

    public function HomeSideBar() {
        super();
        this.adjustPosition();
        _container = UIManager.getMovieClip("UI_HomeSideBar");
        addChild(_container);
        _buttonVec = new Vector.<SimpleButton>();
        this._sideBtnMap = new HashMap();
        this._buddyNewsBtn = _container["buddyNews"];
        TooltipManager.addCommonTip(this._buddyNewsBtn, "小屋动态");
        this._buddyNewsBtn.addEventListener(MouseEvent.CLICK, this.onBuddyBtnClick);
        _buttonVec.push(this._buddyNewsBtn);
        this._sideBtnMap.add(HOME_NEWS_BTN, this._buddyNewsBtn);
        this._trainingPetBtn = _container["trainingPet"];
        TooltipManager.addCommonTip(this._trainingPetBtn, "精灵训练");
        this._trainingPetBtn.addEventListener(MouseEvent.CLICK, this.onTrainingBtnClick);
        _buttonVec.push(this._trainingPetBtn);
        this._sideBtnMap.add(TRAINING_PET_BTN, this._trainingPetBtn);
        this._petStorageBtn = _container["petStorage"];
        TooltipManager.addCommonTip(this._petStorageBtn, "精灵仓库");
        this._petStorageBtn.addEventListener(MouseEvent.CLICK, this.onPetStorageBtnClick);
        _buttonVec.push(this._petStorageBtn);
        this._sideBtnMap.add(PET_STORAGE_BTN, this._petStorageBtn);
        this._medalBtn = _container["medalBtn"];
        TooltipManager.addCommonTip(this._medalBtn, "勋章列表");
        _buttonVec.push(this._medalBtn);
        this._medalBtn.addEventListener(MouseEvent.CLICK, this.onOpenMedalPanel);
        this._planetBtn = _container["planetBtn"];
        TooltipManager.addCommonTip(this._planetBtn, "星球大发现");
        _buttonVec.push(this._planetBtn);
        this._planetBtn.addEventListener(MouseEvent.CLICK, this.onPlanet);
        this._petBagBtn = _container["petBagBtn"];
        TooltipManager.addCommonTip(this._petBagBtn, "精灵背包");
        _buttonVec.push(this._petBagBtn);
        this._petBagBtn.addEventListener(MouseEvent.CLICK, this.onPetBag);
    }

    private function onPetBag(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("PetBagPanel"), "正在打开...");
    }

    private function onNext(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("PetKingAdvancePanel"), "正在打开...");
    }

    public function adjustPosition():void {
        this.x = LayerManager.stage.stageWidth - 70;
        this.y = 47 * (LayerManager.stage.stageHeight / 660);
    }

    private function onPlanet(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("PlanetPanel"), "正在打开勋章列表...");
    }

    private function onOpenMedalPanel(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_242);
        ModuleManager.toggleModule(URLUtil.getAppModule("MedalPanel"), "正在打开勋章列表...");
    }

    private function onBuddyBtnClick(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_240);
        ModuleManager.toggleModule(URLUtil.getAppModule("HomeBuddyNewsPanel"), "正在打开好友动态...");
    }

    private function onTrainingBtnClick(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("TrainingPetPanel"), "正在打开精灵训练...", _homeInfo.trainingPetInfoVec);
    }

    private function onPetStorageBtnClick(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_241);
        ModuleManager.toggleModule(URLUtil.getAppModule("PetStoragePanel"), "正在打开精灵仓库...");
    }

    private function onHomeDailyBtnClick(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("HomeDailyQuestPanel"), "正在打开小屋日常面板...");
    }

    private function onBirth(param1:MouseEvent):void {
        var _loc2_:Object = new Object();
        if (Boolean(SceneManager.active) && SceneManager.active.mapID == ActorManager.actorInfo.id) {
            StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_66);
            _loc2_.birthType = 2;
        } else {
            StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_67);
            _loc2_.birthType = 3;
        }
        ModuleManager.toggleModule(URLUtil.getAppModule("BirthSystemPanel"), "正在打开繁殖...", _loc2_);
    }

    override protected function getShowButtonIndexVec(param1:Boolean):Vector.<int> {
        if (param1) {
            return Vector.<int>([0, 1, 2, 3, 4, 5, 6]);
        }
        return Vector.<int>([4, 5, 6]);
    }

    override protected function updateCurrBtn():void {
        var _loc1_:int = int(currButtonVec.length);
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            currButtonVec[_loc2_].y = 15 + 50 * _loc2_;
            _loc2_++;
        }
    }

    public function enableSomeBtn():void {
        DisplayObjectUtil.enableButton(this.getBtnByName(HOME_DAYILY_BTN));
        DisplayObjectUtil.enableButton(this.getBtnByName(HOME_NEWS_BTN));
    }

    public function disEnableSomeBtn():void {
        DisplayObjectUtil.disableButton(this.getBtnByName(HOME_DAYILY_BTN));
        DisplayObjectUtil.disableButton(this.getBtnByName(HOME_NEWS_BTN));
    }

    public function getBtnByName(param1:String):SimpleButton {
        return this._sideBtnMap.getValue(param1);
    }

    override public function dispose():void {
        TooltipManager.remove(this._buddyNewsBtn);
        TooltipManager.remove(this._trainingPetBtn);
        TooltipManager.remove(this._petStorageBtn);
        TooltipManager.remove(this._medalBtn);
        this._medalBtn.removeEventListener(MouseEvent.CLICK, this.onOpenMedalPanel);
        this._buddyNewsBtn.removeEventListener(MouseEvent.CLICK, this.onBuddyBtnClick);
        this._trainingPetBtn.removeEventListener(MouseEvent.CLICK, this.onTrainingBtnClick);
        this._petStorageBtn.removeEventListener(MouseEvent.CLICK, this.onPetStorageBtnClick);
        this._sideBtnMap.clear();
        this._sideBtnMap = null;
    }
}
}
