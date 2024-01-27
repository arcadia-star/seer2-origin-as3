package com.taomee.seer2.app.dialog {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.constant.DialogReplyActionType;
import com.taomee.seer2.app.dialog.events.DialogBoxEvent;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.animation.QuestAnimationPresenter;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.quest.data.dialog.BranchDefinition;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;
import com.taomee.seer2.core.utils.Util;

import flash.display.Graphics;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;

import org.taomee.utils.DisplayUtil;

public class DialogBox extends Sprite {


    private var _contentTxt:TextField;

    private var _npcPreview:NpcPreview;

    private var _nextNodeBtn:SimpleButton;

    private var _labelFormat:TextFormat;

    private var _labelBtnVec:Vector.<SimpleButton>;

    private var _createClickRec:Sprite;

    private var _npcName:String;

    private var _definition:DialogDefinition;

    private var _branchIndex:int = 0;

    private var _branch:BranchDefinition;

    private var _nodeIndex:int = 0;

    private var _contentFormat:TextFormat;

    private var _emotionList:Vector.<MovieClip>;

    private var _numLines:int;

    private var _quest:Quest;

    private var _stepId:int;

    public function DialogBox() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseEnabled = false;
        this._labelBtnVec = new Vector.<SimpleButton>();
        this.createChildren();
    }

    private function createChildren():void {
        this.createNpcPreview();
        this.createContentTxt();
    }

    private function createNpcPreview():void {
        this._npcPreview = new NpcPreview();
        this._npcPreview.x = 170;
        this._npcPreview.y = 562;
        addChild(this._npcPreview);
    }

    private function createContentTxt():void {
        this._contentFormat = new TextFormat();
        this._contentFormat.size = 14;
        this._contentFormat.color = 5432825;
        this._contentFormat.font = "_sans";
        this._contentFormat.leading = 9;
        this._contentTxt = new TextField();
        this._contentTxt.multiline = true;
        this._contentTxt.wordWrap = true;
        this._contentTxt.width = 470;
        this._contentTxt.height = 60;
        this._contentTxt.selectable = false;
        this._contentTxt.defaultTextFormat = this._contentFormat;
        addChild(this._contentTxt);
        this._contentTxt.x = 280;
        this._contentTxt.y = 440;
    }

    private function createReplyBtn(param1:String):SimpleButton {
        var _loc2_:Sprite = this.createBtnState(param1, 16777113);
        var _loc3_:Sprite = this.createBtnState(param1, 9696572);
        var _loc4_:Sprite = this.createBtnState(param1, 16777113);
        var _loc5_:Shape = this.createBtnHitState(_loc4_.width);
        return new SimpleButton(_loc2_, _loc3_, _loc4_, _loc5_);
    }

    private function createBtnState(param1:String, param2:uint):Sprite {
        if (this._labelFormat == null) {
            this._labelFormat = new TextFormat();
            this._labelFormat.size = 18;
            this._labelFormat.underline = true;
            this._labelFormat.bold = true;
        }
        this._labelFormat.color = param2;
        var _loc3_:Sprite = new Sprite();
        var _loc4_:TextField;
        (_loc4_ = new TextField()).defaultTextFormat = this._labelFormat;
        _loc4_.type = TextFieldType.DYNAMIC;
        _loc4_.selectable = false;
        _loc4_.autoSize = TextFieldAutoSize.LEFT;
        _loc4_.htmlText = param1;
        _loc3_.addChild(_loc4_);
        return _loc3_;
    }

    private function createClickRec():void {
        this._createClickRec = new Sprite();
        this._createClickRec.graphics.beginFill(16777215, 0);
        this._createClickRec.graphics.drawRect(0, 0, 600, 145);
        this._createClickRec.graphics.endFill();
        this._createClickRec.buttonMode = true;
        this._createClickRec.x = 200;
        this._createClickRec.y = 410;
        addChild(this._createClickRec);
        this._createClickRec.addEventListener(MouseEvent.CLICK, this.onRecClick);
    }

    private function onRecClick(param1:MouseEvent):void {
        this.processReplyAction(0);
        param1.stopImmediatePropagation();
    }

    private function createBtnHitState(param1:int):Shape {
        var _loc2_:Shape = new Shape();
        var _loc3_:Graphics = _loc2_.graphics;
        _loc3_.beginFill(16777215, 0);
        _loc3_.drawRect(0, 0, param1, 25);
        _loc3_.endFill();
        return _loc2_;
    }

    public function setQuestInfo(param1:Quest, param2:int, param3:DialogDefinition):void {
        this._quest = param1;
        this._stepId = param2;
        this.setDialogDefinition(param3);
    }

    public function setDialogDefinition(param1:DialogDefinition):void {
        this._definition = param1;
        this.changeBranch(0);
    }

    private function changeBranch(param1:int):void {
        this._branchIndex = param1;
        this._nodeIndex = 0;
        this.update();
    }

    private function update():void {
        this._branch = this._definition.branchVec[this._branchIndex];
        this.updateNpcPreview();
        this.updateContent();
        if (this._nodeIndex == this._branch.contentVec.length - 1) {
            this.showLabelBtn();
        } else {
            this.showNextNodeBtn();
        }
    }

    private function updateNpcPreview():void {
        var _loc1_:int = int(this._branch.emotionVec[this._nodeIndex]);
        this._npcPreview.update(this._branch.npcName, this._branch.npcId, _loc1_);
    }

    private function updateContent():void {
        var _loc1_:Object = new Object();
        _loc1_["name"] = "<font color=\'#FFFF99\' size=\'14\'>" + ActorManager.actorInfo.nick + "</font>";
        var _loc2_:* = String(this._branch.contentVec[this._nodeIndex]);
        _loc2_ = String(Util.replaceVariables(_loc2_, _loc1_));
        _loc2_ = "<font color=\'#52E5F9\' size=\'14\'>" + _loc2_ + "</font>";
        this._contentTxt.htmlText = _loc2_;
        if (this._contentTxt.numLines >= 2) {
            this._contentTxt.y = 427;
        } else {
            this._contentTxt.y = 440;
        }
        this._numLines = this._contentTxt.numLines;
        this._contentTxt.defaultTextFormat = this._contentFormat;
        this.checkFaces(this._contentTxt);
    }

    public function checkFaces(param1:TextField):void {
        var _loc2_:String = null;
        var _loc3_:String = null;
        var _loc12_:uint = 0;
        var _loc13_:MovieClip = null;
        var _loc4_:Array = new Array();
        var _loc5_:Array = new Array();
        var _loc6_:Array = new Array();
        _loc2_ = param1.htmlText;
        var _loc7_:RegExp = /\/:[0-9]{2}/g;
        if ((_loc6_ = _loc2_.match(_loc7_)).length == 0) {
            return;
        }
        param1.htmlText = _loc2_.replace(_loc7_, "    ");
        var _loc8_:uint = 0;
        _loc3_ = param1.text;
        while (1) {
            _loc4_.push(_loc3_.indexOf("    ", _loc8_));
            if (_loc4_[_loc4_.length - 1] == -1) {
                _loc4_.pop();
                break;
            }
            _loc8_ = _loc4_[_loc4_.length - 1] + 1;
        }
        var _loc9_:uint = 0;
        var _loc10_:Number = param1.height;
        while (_loc9_ < _loc4_.length) {
            _loc5_.push(param1.getCharBoundaries(_loc4_[_loc9_]));
            _loc9_++;
        }
        _loc6_ = _loc6_.reverse();
        _loc5_ = _loc5_.reverse();
        this._emotionList = Vector.<MovieClip>([]);
        var _loc11_:uint = 0;
        while (_loc11_ < _loc6_.length) {
            if (_loc5_[_loc11_] != null) {
                _loc12_ = uint(_loc6_[_loc11_].substr(2, 2));
                (_loc13_ = UIManager.getMovieClip("UI_Emotion" + _loc12_)).name = "UI_Emotion" + _loc12_;
                _loc13_.scaleX = _loc13_.scaleY = 0.7;
                _loc13_.x = _loc5_[_loc11_].x + 294;
                _loc13_.y = _loc5_[_loc11_].y + 436;
                if (_loc5_[_loc11_].y > 20) {
                    this.createFormat(11, _loc13_);
                } else {
                    this.createFormat(5, _loc13_);
                }
                this.parent.addChild(_loc13_);
                this._emotionList.push(_loc13_);
                _loc13_ = null;
                _loc11_++;
            }
        }
        _loc7_ = null;
        _loc6_ = null;
        _loc5_ = null;
        _loc4_ = null;
        _loc3_ = null;
        _loc2_ = null;
    }

    private function createFormat(param1:uint, param2:MovieClip):void {
        if (param1 == 11) {
            this._contentTxt.y = 427;
        } else if (this._numLines == 1) {
            param2.y += 13;
        }
        var _loc3_:TextFormat = new TextFormat();
        _loc3_.size = 14;
        _loc3_.color = 5432825;
        _loc3_.font = "_sans";
        _loc3_.leading = param1;
        this._contentTxt.defaultTextFormat = _loc3_;
    }

    private function showLabelBtn():void {
        var _loc3_:String = null;
        var _loc4_:SimpleButton = null;
        this.clearBtn();
        var _loc1_:int = int(this._branch.replyLabelVec.length);
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = String(this._branch.replyLabelVec[_loc2_]);
            (_loc4_ = this.createReplyBtn(_loc3_)).addEventListener(MouseEvent.CLICK, this.onLabelBtnClick);
            this._labelBtnVec.push(_loc4_);
            _loc2_++;
        }
        if (_loc1_ == 1) {
            this.createClickRec();
        }
        this.layoutLabelBtn();
    }

    private function clearBtn():void {
        var _loc1_:SimpleButton = null;
        DisplayUtil.removeForParent(this._createClickRec);
        for each(_loc1_ in this._labelBtnVec) {
            removeChild(_loc1_);
        }
        this._labelBtnVec = new Vector.<SimpleButton>();
        if (Boolean(this._nextNodeBtn) && Boolean(this._nextNodeBtn.parent)) {
            removeChild(this._nextNodeBtn);
        }
    }

    private function layoutLabelBtn():void {
        var _loc1_:int = 790;
        var _loc2_:int = 520;
        var _loc3_:Vector.<int> = new Vector.<int>();
        var _loc4_:int;
        var _loc5_:int = (_loc4_ = int(this._labelBtnVec.length)) - 1;
        while (_loc5_ >= 0) {
            _loc3_.push(_loc1_ - this._labelBtnVec[_loc5_].width);
            _loc1_ -= this._labelBtnVec[_loc5_].width + 10;
            _loc5_--;
        }
        _loc3_.reverse();
        _loc5_ = 0;
        while (_loc5_ < _loc4_) {
            this._labelBtnVec[_loc5_].x = _loc3_[_loc5_];
            this._labelBtnVec[_loc5_].y = _loc2_;
            addChild(this._labelBtnVec[_loc5_]);
            _loc5_++;
        }
    }

    private function onLabelBtnClick(param1:MouseEvent):void {
        var _loc2_:int = this.findBtnIndex(param1.currentTarget as SimpleButton);
        this.processReplyAction(_loc2_);
        param1.stopImmediatePropagation();
    }

    private function processReplyAction(param1:int):void {
        var _loc2_:String = String(this._branch.replyActionVec[param1]);
        var _loc3_:String = String(this._branch.replyParamVec[param1]);
        switch (_loc2_) {
            case DialogReplyActionType.GO_TO_BRANCH:
                this.changeBranch(this.findBranchIndex(_loc3_));
                dispatchEvent(new DialogBoxEvent(DialogBoxEvent.UPDATE_CONTENT, null));
                break;
            case DialogReplyActionType.CLOSE:
                this.closeDialogPanel(_loc3_);
                break;
            case DialogReplyActionType.ACCEPT:
                this.acceptQuest();
                this.closeDialogPanel(_loc3_);
                break;
            case DialogReplyActionType.COMPLETE_STEP:
                this.completeQuestStep();
                this.closeDialogPanel(_loc3_);
                break;
            case DialogReplyActionType.FIGHT_BOSS:
                this.startFightBoss(_loc3_);
                this.closeDialogPanel(_loc3_);
                break;
            case DialogReplyActionType.PLAY_ANIMATION:
                this.playAnimation(_loc3_);
                this.closeDialogPanel(_loc3_);
                break;
            case DialogReplyActionType.OPEN_MODULE:
                this.openModule(_loc3_);
                this.closeDialogPanel(_loc3_);
                break;
            case DialogReplyActionType.CHANGE_SCENE:
                this.changeScene(_loc3_);
                this.closeDialogPanel(_loc3_);
                break;
            default:
                this.closeDialogPanel(_loc3_);
                dispatchEvent(new DialogBoxEvent(DialogBoxEvent.CUSTOM_REPLY_CLICK, new DialogPanelEventData(_loc2_, _loc3_)));
        }
    }

    private function closeDialogPanel(param1:String):void {
        var _loc2_:MovieClip = null;
        for each(_loc2_ in this._emotionList) {
            DisplayUtil.removeForParent(_loc2_);
        }
        this._emotionList = null;
        DialogPanel.hide(param1);
    }

    private function startFightBoss(param1:String):void {
        var _loc2_:uint = uint(param1);
        FightManager.startFightWithSPTBoss(_loc2_);
    }

    private function playAnimation(param1:String):void {
        QuestAnimationPresenter.playQuestAnimation(param1);
    }

    private function openModule(param1:String):void {
        var _loc2_:Array = param1.split(" ");
        if (_loc2_.length >= 3) {
            ModuleManager.showModule(URLUtil.getAppModule(_loc2_[0]), _loc2_[1], _loc2_[2]);
        } else {
            ModuleManager.showModule(URLUtil.getAppModule(_loc2_[0]), _loc2_[1]);
        }
    }

    private function changeScene(param1:String):void {
        ActsHelperUtil.goHandle(int(param1));
    }

    private function acceptQuest():void {
        QuestManager.accept(this._quest.id);
        if (this._definition.transport != "") {
            SceneManager.changeScene(SceneType.LOBBY, uint(this._definition.transport));
        }
    }

    private function completeQuestStep():void {
        QuestManager.completeStep(this._quest.id, this._stepId);
    }

    private function findBtnIndex(param1:SimpleButton):int {
        var _loc2_:int = int(this._labelBtnVec.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (this._labelBtnVec[_loc3_] == param1) {
                return _loc3_;
            }
            _loc3_++;
        }
        return -1;
    }

    private function findBranchIndex(param1:String):int {
        var _loc4_:BranchDefinition = null;
        var _loc2_:int = int(this._definition.branchVec.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if ((_loc4_ = this._definition.branchVec[_loc3_]).id == param1) {
                return _loc3_;
            }
            _loc3_++;
        }
        return -1;
    }

    private function showNextNodeBtn():void {
        this.clearBtn();
        if (this._nextNodeBtn == null) {
            this._nextNodeBtn = UIManager.getButton("UI_DialogNextNode");
            this._nextNodeBtn.addEventListener(MouseEvent.CLICK, this.onNextNode);
        }
        this._nextNodeBtn.x = 760;
        this._nextNodeBtn.y = 530;
        addChild(this._nextNodeBtn);
    }

    private function onNextNode(param1:MouseEvent):void {
        ++this._nodeIndex;
        this.update();
    }
}
}
