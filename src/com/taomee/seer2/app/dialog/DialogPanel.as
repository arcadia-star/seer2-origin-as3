package com.taomee.seer2.app.dialog {
import com.greensock.TweenMax;
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.dialog.events.DialogBoxEvent;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
import com.taomee.seer2.app.home.panel.HomePanel;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.questTiny.QuestTinyPanel;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.StringConstants;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

import org.taomee.utils.MathUtil;

public class DialogPanel extends Sprite {

    public static const DIALOG_BRANCH:String = "gotoDialogBranch";

    private static var _instance:DialogPanel;

    private static var _isShowing:Boolean = false;

    private static var _dialogId:uint = 0;


    private var _prevNpc:uint = 0;

    private var _back:MovieClip;

    private var _dialogBox:DialogBox;

    private var _functionalityBox:FunctionalityBox;

    private var _customFunctionality:Sprite;

    private var _closeHandler:Function;

    private var _currentNpcId:int;

    private var _currentNpcName:String;

    private var _currentDialogData:XML;

    private var _currentDialog:DialogDefinition;

    private var dialogPanel:DialogPanel;

    public function DialogPanel() {
        super();
        this.initialize();
    }

    public static function get dialogBox():DialogBox {
        if (!instance._dialogBox) {
            instance.createDialogBox();
        }
        return instance._dialogBox;
    }

    private static function get instance():DialogPanel {
        if (_instance == null) {
            _instance = new DialogPanel();
        }
        return _instance;
    }

    public static function layIcon():void {
        instance.layIcons();
    }

    public static function showForNpc(param1:NpcDefinition):void {
        if (_isShowing) {
            return;
        }
        if (param1.dialogData != null) {
            instance._currentNpcId = param1.id;
            instance._currentNpcName = param1.name;
            instance.setDialogBoxXml(param1.dialogData);
            instance.showFunctionalityBox(param1.functionalityData);
            instance._closeHandler = null;
            instance.show();
            instance.layIcons();
        }
    }

    public static function showForCommon(param1:DialogDefinition, param2:Function = null, param3:Sprite = null):void {
        if (_isShowing) {
            return;
        }
        instance._currentNpcId = 0;
        instance.setDialogBoxDefinition(param1);
        instance.addCustomFunioniality(param3);
        instance._closeHandler = param2;
        instance.show();
    }

    public static function showForCommonReturnNpcId(param1:int, param2:String, param3:Array, param4:String, param5:Function = null, param6:Sprite = null):void {
        var _loc7_:DialogDefinition = DialogDefinition.generateDefinition(param1, param2, param3, param4);
        if (_isShowing) {
            return;
        }
        instance._currentNpcId = param1;
        instance.setDialogBoxDefinition(_loc7_);
        instance.addCustomFunioniality(param6);
        instance._functionalityBox.clear();
        instance.addChild(instance._functionalityBox);
        instance._closeHandler = param5;
        instance.show();
    }

    public static function addFunctionalityBox():void {
        instance._functionalityBox.clear();
        instance.addChild(instance._functionalityBox);
    }

    public static function showForSimple(param1:int, param2:String, param3:Array, param4:String, param5:Function = null, param6:Sprite = null):void {
        var _loc7_:DialogDefinition = DialogDefinition.generateDefinition(param1, param2, param3, param4);
        showForCommon(_loc7_, param5, param6);
    }

    public static function hide(param1:String = ""):void {
        instance.hide(param1);
    }

    public static function get dialogId():uint {
        return _dialogId;
    }

    public static function get functionalityBox():FunctionalityBox {
        return _instance._functionalityBox;
    }

    private static function dispatchCustomEvent(param1:String, param2:* = undefined):void {
        if (_instance.hasEventListener(param1)) {
            _instance.dispatchEvent(new DialogPanelEvent(param1, _dialogId, param2));
        }
    }

    public static function addEventListener(param1:String, param2:Function):void {
        instance.addEventListener(param1, param2);
    }

    public static function removeEventListener(param1:String, param2:Function):void {
        instance.removeEventListener(param1, param2);
    }

    public static function addCloseEventListener(param1:Function):void {
        instance.addEventListener(Event.CLOSE, param1);
    }

    public static function removeCloseEventListener(param1:Function):void {
        instance.removeEventListener(Event.CLOSE, param1);
    }

    public function get currentNpcId():int {
        return this._currentNpcId;
    }

    private function initialize():void {
        this.mouseEnabled = false;
        this.createChildren();
    }

    private function createChildren():void {
        this.createBack();
        this.createDialogBox();
        this.createFunctionalityBox();
    }

    private function createBack():void {
        this._back = UIManager.getMovieClip("UI_DialogPanel");
        this._back.x = 263;
        this._back.y = 507;
        addChild(this._back);
    }

    private function createDialogBox():void {
        this._dialogBox = new DialogBox();
        this._dialogBox.x = 100;
        this._dialogBox.y = 100;
        addChild(this._dialogBox);
        this.addDialogBoxEventListener();
    }

    private function addDialogBoxEventListener():void {
        this._dialogBox.addEventListener(DialogBoxEvent.CUSTOM_REPLY_CLICK, this.onCustomReplayClick);
        this._dialogBox.addEventListener(DialogBoxEvent.UPDATE_CONTENT, this.onupdate);
    }

    private function onCustomReplayClick(param1:DialogBoxEvent):void {
        dispatchCustomEvent(DialogPanelEvent.CUSTOM_REPLY_CLICK, param1.content);
    }

    private function onupdate(param1:DialogBoxEvent):void {
        if (instance._currentNpcId != this._prevNpc) {
            this.tweenDialog();
            this.dialogPanel = this;
            this._prevNpc = instance._currentNpcId;
        }
    }

    private function createFunctionalityBox():void {
        this._functionalityBox = new FunctionalityBox();
        this._functionalityBox.x = this._back.x + 135;
        this._functionalityBox.y = this._back.y + 95;
        this.addFunctionalityUnitEventListener();
    }

    private function addFunctionalityUnitEventListener():void {
        this._functionalityBox.addEventListener(FunctionalityBoxEvent.QUEST_CLICK, this.onQuestUnitClick);
        this._functionalityBox.addEventListener(FunctionalityBoxEvent.CUSTOM_UNIT_CLICK, this.onCustomUnitClick);
        this._functionalityBox.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK, this.onQuestUnitNewClick);
    }

    private function onQuestUnitClick(param1:FunctionalityBoxEvent):void {
        var _loc2_:Quest = param1.content.quest;
        var _loc3_:int = int(param1.content.stepId);
        var _loc4_:DialogDefinition;
        if (_loc4_ = _loc2_.getQuestDialogDefintion(_loc3_)) {
            this._dialogBox.setQuestInfo(_loc2_, _loc3_, _loc4_);
            if (instance._currentNpcId != this._prevNpc) {
                this.tweenDialog();
                this.dialogPanel = this;
                this._prevNpc = instance._currentNpcId;
            }
        }
        this.hideFunctionalityBox();
        dispatchCustomEvent(DialogPanelEvent.QUEST_UNIT_CLICK, {
            "questId": _loc2_.id,
            "stepId": _loc3_
        });
    }

    private function onQuestUnitNewClick(param1:FunctionalityBoxEvent):void {
        var _loc2_:int = int(param1.content.questId);
        var _loc3_:int = int(param1.content.stepId);
        this.hide("");
        dispatchCustomEvent(DialogPanelEvent.NPC_QUEST_CLICK, {
            "questId": _loc2_,
            "stepId": _loc3_
        });
    }

    private function onCustomUnitClick(param1:FunctionalityBoxEvent):void {
        param1.stopPropagation();
        this.hide("");
        dispatchCustomEvent(DialogPanelEvent.CUSTOM_UNIT_CLICK, param1.content);
    }

    private function showFunctionalityBox(param1:XML):void {
        this._functionalityBox.clear();
        addChild(this._functionalityBox);
        this.addDefaultFunctionalityUnit(param1);
        this.addQuestFunctionalityUnit();
    }

    private function hideFunctionalityBox():void {
        DisplayObjectUtil.removeFromParent(this._functionalityBox);
    }

    private function addDefaultFunctionalityUnit(param1:XML):void {
        this._functionalityBox.createUnitList(param1);
    }

    private function addQuestFunctionalityUnit():void {
        var _loc2_:Quest = null;
        var _loc3_:uint = 0;
        if (this._currentNpcId == 0) {
            return;
        }
        var _loc1_:Vector.<Quest> = QuestManager.getQuestListByStatus(QuestStatus.ACCEPTABLE).concat(QuestManager.getQuestListByStatus(QuestStatus.IN_PROGRESS));
        for each(_loc2_ in _loc1_) {
            if (_loc2_.getCurrentNpcIdVec().indexOf(this._currentNpcId) != -1) {
                if (_loc2_.id != 10072 && _loc2_.id != 10073 && _loc2_.id != 10074) {
                    this._functionalityBox.createQuestUnit(this._currentNpcId, _loc2_);
                } else {
                    _loc3_ = new Date(2012, 3, 2, 1).getTime() / 1000;
                    if (TimeManager.getServerTime() < _loc3_) {
                        this._functionalityBox.createQuestUnit(this._currentNpcId, _loc2_);
                    }
                }
            }
        }
    }

    private function addCustomFunioniality(param1:Sprite):void {
        this._customFunctionality = param1;
        if (this._customFunctionality != null) {
            this._customFunctionality.x = _instance._back.x + 195;
            this._customFunctionality.y = _instance._back.y + 95;
            instance.addChild(this._customFunctionality);
        }
    }

    private function removeCustomFunioniality():void {
        if (this._customFunctionality != null) {
            DisplayObjectUtil.removeFromParent(this._customFunctionality);
            this._customFunctionality = null;
        }
    }

    private function show():void {
        if (!_isShowing) {
            _isShowing = true;
            this.addToParent();
            this.hideToolBar();
            this.afterShowDialog();
        }
    }

    private function addToParent():void {
        if (instance._currentNpcId != this._prevNpc) {
            this.tweenDialog();
            this._prevNpc = instance._currentNpcId;
        }
        LayerManager.topLayer.addChild(this);
        this.dialogPanel = this;
        this.layIcons();
        LayerManager.focusOnTopLayer();
    }

    private function tweenDialog():void {
        var _loc1_:Number = this.x;
        var _loc2_:Number = this.y;
        var _loc3_:int = int(MathUtil.randomRegion(1, 4));
        if (_loc3_ == 1) {
            this.x = -this.width;
            this.alpha = 0.3;
            TweenMax.to(this, 0.5, {
                "x": _loc1_,
                "alpha": 1
            });
        } else if (_loc3_ == 2) {
            this.x = LayerManager.stage.stageWidth;
            this.alpha = 0.3;
            TweenMax.to(this, 0.5, {
                "x": _loc1_,
                "alpha": 1
            });
        } else if (_loc3_ == 3) {
            this.y = LayerManager.stage.stageHeight;
            this.alpha = 0.3;
            TweenMax.to(this, 0.5, {
                "y": _loc2_,
                "alpha": 1
            });
        }
        this.dialogPanel = this;
    }

    private function layIcons():void {
        if (this.dialogPanel) {
            this.dialogPanel.x = 1200 * (LayerManager.stage.stageWidth / 1200) - 1200;
            this.dialogPanel.y = 660 * (LayerManager.stage.stageHeight / 660) - 660;
        }
    }

    private function hideToolBar():void {
        if (SceneManager.active.type == SceneType.LOBBY) {
            ToolBar.hide();
            QuestTinyPanel.instance.hide();
        }
        if (SceneManager.active.type == SceneType.HOME) {
            HomePanel.hide();
        }
    }

    private function afterShowDialog():void {
        ++_dialogId;
        if (this._currentNpcId != 0) {
            dispatchCustomEvent(DialogPanelEvent.DIALOG_SHOW, this._currentNpcId);
        }
    }

    private function hide(param1:String):void {
        if (_isShowing) {
            _isShowing = false;
            this.removeFromParent();
            this.clearFunctionlity();
            this.afterHideDialog(param1);
        }
    }

    private function removeFromParent():void {
        DisplayObjectUtil.removeFromParent(this);
        LayerManager.resetOperation();
        if (SceneManager.active.type == SceneType.LOBBY) {
            ToolBar.show();
            QuestTinyPanel.instance.show();
        }
        if (SceneManager.active.type == SceneType.HOME) {
            HomePanel.show();
        }
    }

    private function clearFunctionlity():void {
        this.hideFunctionalityBox();
        this.removeCustomFunioniality();
    }

    private function afterHideDialog(param1:String):void {
        if (this._closeHandler != null) {
            if (param1 == "") {
                this._closeHandler();
            } else {
                this._closeHandler(param1);
            }
        } else {
            dispatchCustomEvent(DialogPanelEvent.DIALOG_CLOSED, new DialogPanelEventData("close", param1));
            if (hasEventListener(Event.CLOSE)) {
                dispatchEvent(new DialogCloseEvent(param1, Event.CLOSE));
            }
        }
    }

    private function setDialogBoxXml(param1:XML):void {
        this._currentDialogData = param1;
        this._currentDialog = new DialogDefinition(this._currentDialogData);
        if (this._currentDialog.npcName == StringConstants.EMPTY) {
            this._currentDialog.updateNpcName(this._currentNpcName);
        }
        this.setDialogBoxDefinition(this._currentDialog);
    }

    private function setDialogBoxDefinition(param1:DialogDefinition):void {
        this._dialogBox.setDialogDefinition(param1);
    }
}
}
