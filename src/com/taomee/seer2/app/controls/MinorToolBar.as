package com.taomee.seer2.app.controls {
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.taomee.seer2.app.controls.widget.CopyWidgetClick;
import com.taomee.seer2.app.controls.widget.FortressWidgetClick;
import com.taomee.seer2.app.controls.widget.MonsterWidgetClick;
import com.taomee.seer2.app.controls.widget.QuestWidgetClick;
import com.taomee.seer2.app.controls.widget.ToolBarWidget;
import com.taomee.seer2.app.controls.widget.TrainerWidgetClick;
import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.taomee.ds.HashMap;

public class MinorToolBar extends Sprite {

    private static var _instance:MinorToolBar;

    private static const _showXPos:int = 611;

    private static const _hideXPos:int = 940;


    private var _mainPanel:MovieClip;

    private var _retractBtn:MovieClip;

    private var _sptBtn:SimpleButton;

    private var _skyBtn:SimpleButton;

    private var _isRetract:Boolean = false;

    private var _widgetMap:HashMap;

    private var _copyMC:MovieClip;

    private var _monsterMC:MovieClip;

    public function MinorToolBar() {
        super();
        y = 8;
        x = _showXPos;
        this._mainPanel = UIManager.getMovieClip("UI_Toolbar_Minor");
        addChild(this._mainPanel);
        this._retractBtn = this._mainPanel["btnRetract"];
        this._retractBtn.gotoAndStop(2);
        SoundEffects.setArrow(this._retractBtn);
        this._widgetMap = new HashMap();
        this.addToolBarWidget(TrainerWidgetClick.TRAINER, this._mainPanel["trainerBtn"], this._mainPanel["trainerMc"], "训练师手册", new TrainerWidgetClick());
        this.addToolBarWidget(QuestWidgetClick.QUEST, this._mainPanel["questBtn"], this._mainPanel["questMc"], "任务档案", new QuestWidgetClick());
        this.addToolBarWidget(FortressWidgetClick.FORTRESS, this._mainPanel["fortressBtn"], this._mainPanel["fortressMC"], "英格瓦要塞", new FortressWidgetClick());
        this.addToolBarWidget(CopyWidgetClick.COPY, this._mainPanel["copyBtn"], null, "炼狱", new CopyWidgetClick());
        this.addToolBarWidget(MonsterWidgetClick.MONSTER, this._mainPanel["monsterBtn"], null, "灵兽", new MonsterWidgetClick());
        this._sptBtn = this._mainPanel["sptBtn"];
        TooltipManager.addCommonTip(this._sptBtn, "SPT先锋队任务");
        SoundEffects.setButton(this._sptBtn);
        this._copyMC = this._mainPanel["copyMC"];
        this._copyMC.mouseEnabled = false;
        this._copyMC.mouseChildren = false;
        MovieClipUtil.playMc(this._copyMC, 1, this._copyMC.totalFrames, function ():void {
            _copyMC.visible = false;
        });
        this._skyBtn = this._mainPanel["skyBtn"];
        TooltipManager.addCommonTip(this._skyBtn, "天空竞技场");
        this._skyBtn.addEventListener(MouseEvent.CLICK, this.onSky);
        this._monsterMC = this._mainPanel["monsterMC"];
        this._monsterMC.mouseEnabled = false;
        this._monsterMC.mouseChildren = false;
        MovieClipUtil.playMc(this._monsterMC, 1, this._monsterMC.totalFrames, function ():void {
            _monsterMC.visible = false;
        });
        this._retractBtn.addEventListener(MouseEvent.CLICK, this.onRetractPanel);
        this._sptBtn.addEventListener(MouseEvent.CLICK, this.onSptBtnClick);
    }

    public static function show():void {
        if (_instance == null) {
        }
    }

    public static function hide():void {
    }

    public static function showTrainerAni():void {
    }

    public static function showShine():void {
    }

    public static function showCopyShine():void {
    }

    public static function hideShine():void {
    }

    public static function hideCopyShine():void {
    }

    private function onSky(param1:MouseEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 1300);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_364);
    }

    public function show():void {
        LayerManager.uiLayer.addChild(this);
    }

    public function hide():void {
        DisplayObjectUtil.removeFromParent(this);
    }

    public function playTrainerAni():void {
        ToolBarWidget(this._widgetMap.getValue(TrainerWidgetClick.TRAINER)).showNotice();
    }

    private function addToolBarWidget(param1:String, param2:SimpleButton, param3:MovieClip, param4:String, param5:IToolBarWidgetClick):void {
        var _loc6_:ToolBarWidget = new ToolBarWidget(param2, param3, param4, param5);
        param5.widget = _loc6_;
        this._mainPanel.addChild(_loc6_);
        this._widgetMap.add(param1, _loc6_);
    }

    private function onRetractPanel(param1:MouseEvent):void {
        if (this._isRetract) {
            this._retractBtn.gotoAndStop(1);
            this._isRetract = false;
            TweenLite.to(this, 0.6, {
                "x": _showXPos,
                "ease": Expo.easeOut
            });
        } else {
            this._retractBtn.gotoAndStop(2);
            this._isRetract = true;
            TweenLite.to(this, 0.6, {
                "x": _hideXPos,
                "ease": Expo.easeOut
            });
        }
        param1.stopImmediatePropagation();
    }

    private function onSptBtnClick(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_323);
        ModuleManager.toggleModule(URLUtil.getAppModule("SPTPanel"), "正在打开SPT面板...", new Object());
    }
}
}
