package com.taomee.seer2.app.processor.quest.handler.main.quest91 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.common.MovieClipPlayer;
import com.taomee.seer2.app.common.ResourceLibraryLoader;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_91_80384 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _resourceLoader:ResourceLibraryLoader;

    private var _resLib:ResourceLibrary;

    private var _recycleMc:MovieClip;

    private var _movieClipPlayer:MovieClipPlayer;

    private var equipMcList:Vector.<MovieClip>;

    private var _curIdx:int;

    private var flag:Boolean = false;

    private var equipNum:int = 0;

    private var _npc:Mobile;

    private var _npc1:Mobile;

    private var NPCID:int = 844;

    private var NPCID1:int = 845;

    public function QuestMapHandler_91_80384(param1:QuestProcessor) {
        this._movieClipPlayer = new MovieClipPlayer();
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._resourceLoader = new ResourceLibraryLoader(URLUtil.getRes("common/home/garbage" + URLUtil.POSTFIX_SWF));
        this._resourceLoader.getLib(this.handlerGarbage);
    }

    private function handlerGarbage(param1:ResourceLibrary):void {
        this._resLib = param1;
        RightToolbarConter.instance.hide();
        ActorManager.getActor().hide();
        ActorManager.getActor().blockFollowingPet = true;
        ActorManager.getActor().blockNoNo = true;
        this.equipMcList = new Vector.<MovieClip>();
        var _loc2_:int = 0;
        while (_loc2_ < 6) {
            this.equipMcList.push(_map.content["gabageMc" + _loc2_]);
            this.equipMcList[_loc2_].buttonMode = true;
            this.equipMcList[_loc2_].addEventListener(MouseEvent.CLICK, this.onClick);
            _loc2_++;
        }
        if (!QuestManager.isAccepted(questID)) {
            QuestManager.accept(questID);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccepted);
        }
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.initStep1();
        }
        if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2) && !QuestManager.isComplete(questID)) {
            this.initStep2(null);
        }
        if (QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function onAccepted(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
        this.initStep1();
    }

    private function initStep1():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("91_0"), function ():void {
            NpcDialog.show(400, "赛尔", [[0, "这里看来已经荒废很久了。"]], ["这就是能量转化装置吗？"], [function ():void {
                NpcDialog.show(400, "赛尔", [[0, "这台机器已经坏了吧！"]], ["该怎么办呢？"], [function ():void {
                    NpcDialog.show(400, "赛尔", [[0, "地上有好多零件，试试能不能把他修好吧。"]], ["收集地上的零件。"], [function ():void {
                        ActorManager.getActor().show();
                        ActorManager.getActor().blockFollowingPet = false;
                        ActorManager.getActor().blockNoNo = false;
                        equipNum = 0;
                    }]);
                }]);
            }]);
        });
    }

    private function onClick(param1:MouseEvent):void {
        if (this.flag == true) {
            return;
        }
        this.flag = true;
        this._curIdx = this.equipMcList.indexOf(param1.currentTarget as MovieClip);
        this._recycleMc = this._resLib.getMovieClip("recyle");
        this._recycleMc.scaleX = this._recycleMc.scaleY = 0.8;
        this.equipMcList[this._curIdx].addChild(this._recycleMc);
        this._movieClipPlayer.playMc(this._recycleMc, 1, this._recycleMc.totalFrames, false, this.onRecyclePlayEnd);
    }

    private function onRecyclePlayEnd():void {
        this.flag = false;
        this.equipMcList[this._curIdx].visible = false;
        DisplayObjectUtil.removeFromParent(this._recycleMc);
        ++this.equipNum;
        if (this.equipNum >= 6) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("91_1"), function ():void {
                createNpc();
            });
        }
    }

    private function createNpc():void {
        this._npc = new Mobile();
        this._npc.setPostion(new Point(707, 535));
        this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
        this._npc.buttonMode = true;
        MobileManager.addMobile(this._npc, MobileType.NPC);
        var _loc1_:AcceptableMark = new AcceptableMark();
        this._npc.addChild(_loc1_);
        _loc1_.y = -130;
        this._npc.addEventListener(MouseEvent.CLICK, this.dialogShow);
        this._npc1 = new Mobile();
        this._npc1.setPostion(new Point(220, 480));
        this._npc1.resourceUrl = URLUtil.getNpcSwf(this.NPCID1);
        this._npc1.buttonMode = true;
        MobileManager.addMobile(this._npc1, MobileType.NPC);
        var _loc2_:AcceptableMark = new AcceptableMark();
        this._npc1.addChild(_loc2_);
        _loc2_.y = -130;
        this._npc1.addEventListener(MouseEvent.CLICK, this.dialogShow);
    }

    private function dialogShow(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(845, "宇宙骑士", [[0, "                    机器人，是你在向本王求救吗？ "]], ["我也不知道，你是从那块宝石里蹦出来的吗？"], [function ():void {
            NpcDialog.show(845, "宇宙骑士", [[0, "                      哼！本王是宇宙骑士，受到你的求救特地前来。 "]], ["有危险，是那个远古地魔！"], [function ():void {
                ActorManager.getActor().hide();
                ActorManager.getActor().blockFollowingPet = true;
                ActorManager.getActor().blockNoNo = true;
                if (_npc != null) {
                    MobileManager.removeMobile(_npc, MobileType.NPC);
                }
                if (_npc1 != null) {
                    MobileManager.removeMobile(_npc1, MobileType.NPC);
                }
                _mc1 = _processor.resLib.getMovieClip("Mc91_0");
                _map.content.addChild(_mc1);
                _mc1.gotoAndStop(1);
                MovieClipUtil.playMc(_mc1, 1, _mc1.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_mc1);
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("91_2"), function ():void {
                        QuestManager.completeStep(questID, 1);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, initStep2);
                    });
                }, true);
            }]);
        }]);
    }

    private function initStep2(param1:QuestEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 80374);
    }

    override public function processMapDispose():void {
        RightToolbarConter.instance.show();
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        if (SeatTipsManager.hasSeat(80384, new Point(300, 250))) {
            SeatTipsManager.removeSeat(new Point(300, 250), 80384);
        }
        super.processMapDispose();
    }
}
}
