package com.taomee.seer2.app.processor.quest.handler.main.quest8 {
import com.taomee.seer2.app.arena.data.FightResultInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class QuestMapHandler_8_160 extends QuestMapHandler {


    private var _npcTalkContainer:MovieClip;

    private var _npcTalkContent:MovieClip;

    private var _npcTalkBtn:SimpleButton;

    private var _npcTalkIndex:int;

    private var _resultInfo:FightResultInfo;

    public function QuestMapHandler_8_160(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (Boolean(_quest.isStepCompete(6)) && !_quest.isStepCompete(7)) {
            PetInfoManager.addEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
            UILoader.load(URLUtil.getQuestAnimation("8/npcTalk_1"), LoadType.SWF, this.onLoadNpcTalkComplete);
        }
    }

    private function onLoadNpcTalkComplete(param1:ContentInfo):void {
        this._npcTalkContainer = param1.content as MovieClip;
        LayerManager.uiLayer.addChild(this._npcTalkContainer);
        LayerManager.focusOnUILayer();
        this._npcTalkContainer.x += 120;
        this._npcTalkContainer.y += 50;
        this._npcTalkBtn = UIManager.getButton("UI_NpcTalkBtn");
        this._npcTalkIndex = 1;
        this.playNpcTalk();
    }

    private function playNpcTalk():void {
        if (this._npcTalkIndex == 1) {
            this._npcTalkBtn.x = 910;
            this._npcTalkBtn.y = 530;
        } else {
            this._npcTalkBtn.x = 890;
            this._npcTalkBtn.y = 450;
        }
        MovieClipUtil.getChildList(this._npcTalkContainer, this._npcTalkIndex, [0], function (param1:Vector.<DisplayObject>):void {
            var children:Vector.<DisplayObject> = param1;
            _npcTalkContent = children[0] as MovieClip;
            MovieClipUtil.playMc(_npcTalkContent, 1, "talk1", function ():void {
                LayerManager.uiLayer.addChild(_npcTalkBtn);
                _npcTalkBtn.addEventListener(MouseEvent.CLICK, onClickNpcBtn1);
            });
        });
    }

    private function onClickNpcBtn1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        DisplayObjectUtil.removeFromParent(this._npcTalkBtn);
        this._npcTalkBtn.removeEventListener(MouseEvent.CLICK, this.onClickNpcBtn1);
        MovieClipUtil.playMc(this._npcTalkContent, "talk1", "talk2", function ():void {
            LayerManager.uiLayer.addChild(_npcTalkBtn);
            _npcTalkBtn.addEventListener(MouseEvent.CLICK, onClickNpcBtn2);
        });
    }

    private function onClickNpcBtn2(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        DisplayObjectUtil.removeFromParent(this._npcTalkBtn);
        this._npcTalkBtn.removeEventListener(MouseEvent.CLICK, this.onClickNpcBtn2);
        MovieClipUtil.playMc(this._npcTalkContent, "talk2", this._npcTalkContent.totalFrames, function ():void {
            if (_npcTalkIndex == 1) {
                ++_npcTalkIndex;
                playNpcTalk();
            } else {
                DisplayObjectUtil.removeFromParent(_npcTalkContainer);
                LayerManager.resetOperation();
                MovieClipUtil.playFullScreen(URLUtil.getQuestAnimation("8/fullScreen_2"), function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                    QuestManager.completeStep(_quest.id, 7);
                });
            }
        });
    }

    private function onQuestComplete(param1:QuestEvent):void {
        ModuleManager.addEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }

    private function onPetLevelUp(param1:PetInfoEvent):void {
        this._resultInfo = param1.content.resultInfo;
    }

    private function teacherPlayerHandler(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
    }

    override public function processMapDispose():void {
        PetInfoManager.removeEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
        ModuleManager.removeEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        super.processMapDispose();
    }
}
}
