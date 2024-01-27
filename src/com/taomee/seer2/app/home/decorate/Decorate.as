package com.taomee.seer2.app.home.decorate {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.home.HomeScene;
import com.taomee.seer2.app.home.data.DecorateInfo;
import com.taomee.seer2.app.home.panel.HomePanel;
import com.taomee.seer2.app.manager.InteractiveRewardManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.net.parser.Parser_1140;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.ds.HashMap;
import org.taomee.utils.Tick;

public class Decorate {

    private static const QUEST_ID:Array = [10044, 10045, 10046, 10047, 10048, 10049];

    private static const SWAP_ID:uint = 212;

    private static const FIGHT_INDEX:uint = 49;

    private static const NPC_HEIGHT:Array = [105, 165, 80, 80, 80, 80, 80, 80, 80, 80, 100];

    private static const VIP_NPC_DEF:XML = <npc id="66" resId="66" name="包工头的头" dir="0" width="70" height="75"
                                                pos="767, 386" actorPos="740, 380" path="">
        <dialog npcId="70" transport="1,300,400">
            <branch id="default">
                <node emotion="0"><![CDATA[不用质疑不用怀疑！我就是这次装修工程的包工头的头！有什么我能为您效劳吗？]]></node>
                <reply action="close"><![CDATA[一会再来找你商量]]></reply>
            </branch>
        </dialog>
        <functionality>
            <node type="module" name="小屋装修图纸" params="DecorateQuestPanel"/>
        </functionality>
        <eventHandler>
            <click>
                <HandlerOpenDialogPanel/>
            </click>
        </eventHandler>
    </npc>;

    private static const NORMAL_NPC_DEF:XML = <npc id="65" resId="65" name="包工头" dir="0" width="70" height="75"
                                                   pos="767, 386" actorPos="740, 380" path="">
        <dialog npcId="69" transport="1,300,400">
            <branch id="default">
                <node emotion="0"><![CDATA[新年快乐！啧啧啧，俺是负责您这次基地施工的包工头，请问您需要装修哪些呢？]]></node>
                <reply action="close"><![CDATA[一会再来找你商量]]></reply>
            </branch>
        </dialog>
        <functionality>
            <node type="module" name="小屋装修图纸" params="DecorateQuestPanel"/>
        </functionality>
        <eventHandler>
            <click>
                <HandlerOpenDialogPanel/>
            </click>
        </eventHandler>
    </npc>;


    private var _info:DecorateInfo;

    private var _npcIdMap:HashMap;

    private var _npc:Mobile;

    private var _ornamentResLib:ResourceLibrary;

    private var _surpriseMark:AcceptableMark;

    private var _isSpecialPlaying:Boolean;

    private var _pet:MovieClip;

    private var _cheerIcon:MovieClip;

    private var _timeMcVec:Vector.<MovieClip>;

    private var _groundContainer:MovieClip;

    private var _timerCount:uint;

    public function Decorate(param1:DecorateInfo, param2:ResourceLibrary) {
        var mc:MovieClip = null;
        var info:DecorateInfo = param1;
        var resLib:ResourceLibrary = param2;
        super();
        this._info = info;
        this._ornamentResLib = resLib;
        this.initialize();
        this.processDecorate();
        this.createNpc((SceneManager.active as HomeScene).homeInfo.userInfo.vipInfo.isVip());
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
            mc = this._ornamentResLib.getMovieClip("success");
            mc.x = 500;
            mc.y = 410;
            SceneManager.active.mapModel.front.addChild(mc);
            MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                mc.buttonMode = true;
                mc.addEventListener(MouseEvent.CLICK, onSuccessPetClick);
                initQuest();
            });
        } else if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.RIGHT && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
            mc = this._ornamentResLib.getMovieClip("fail");
            mc.x = 530;
            mc.y = 357;
            SceneManager.active.mapModel.front.addChild(mc);
            MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                DisplayObjectUtil.removeFromParent(mc);
                initQuest();
            });
        } else {
            this.initQuest();
        }
    }

    private function onSuccessPetClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        _loc2_.removeEventListener(MouseEvent.CLICK, this.onSuccessPetClick);
        DisplayObjectUtil.removeFromParent(_loc2_);
        InteractiveRewardManager.requestReward(65, this.onGetSuccessPetReward, this.onGetPetRewardError);
    }

    private function onGetSuccessPetReward(param1:Parser_1060):void {
        if (param1.addItemVec[0].id != 13) {
            param1.showResult();
        }
    }

    private function onGetPetRewardError():void {
        ServerMessager.addMessage("你真厉害，我今天带的所有礼物都被你拿走了");
    }

    private function initQuest():void {
        if (SceneManager.active.mapID == ActorManager.actorInfo.id && this._info.inprogressQuest && this._info.resideTime == 0) {
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestCompleted);
            QuestManager.completeStep(this._info.inprogressQuest, 2);
        } else if (this._info.resideTime > 0 && Boolean(this._info.inprogressQuest)) {
            this._timerCount = 0;
            Tick.instance.addRender(this.onTimer, 1000);
        } else if (!(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX)) {
            this.processSpecialEvent();
        }
    }

    private function onTimer(param1:uint):void {
        ++this._timerCount;
        if (this._info.resideTime) {
            --this._info.resideTime;
            this.updateCheerStatus();
            this.updateResideTimeIcon();
        }
        if (this._isSpecialPlaying == false && (this._info.resideTime == 0 || this._timerCount >= 60)) {
            this._timerCount = 0;
            Tick.instance.removeRender(this.onTimer);
            Connection.addCommandListener(CommandSet.HOME_GET_ENTRY_INFO_1038, this.onGetHomeInfo);
            Connection.send(CommandSet.HOME_GET_ENTRY_INFO_1038);
        }
    }

    private function onGetHomeInfo(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.HOME_GET_ENTRY_INFO_1038, this.onGetHomeInfo);
        (SceneManager.active as HomeScene).homeInfo.parseSpecialInfo(param1.message.getRawDataCopy());
        this._info = (SceneManager.active as HomeScene).homeInfo.decorateInfo;
        if (SceneManager.active.mapID == ActorManager.actorInfo.id && this._info.resideTime == 0 && this._isSpecialPlaying == false) {
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestCompleted);
            QuestManager.completeStep(this._info.inprogressQuest, 2);
        } else if (SceneManager.active.mapID == ActorManager.actorInfo.id && (this._info.resideTime > 0 || this._isSpecialPlaying == false)) {
            this.updateCheerStatus();
            this.updateResideTimeIcon();
            Tick.instance.addRender(this.onTimer, 1000);
        } else {
            this.updateCheerStatus();
            this.updateResideTimeIcon();
        }
    }

    private function processSpecialEvent():void {
        this._isSpecialPlaying = true;
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandEvent);
        Connection.send(CommandSet.RANDOM_EVENT_1140, 13, 0);
    }

    private function onRandEvent(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandEvent);
        var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawData());
        if (_loc2_.id == 1) {
            this.showSpecialEvent();
        } else {
            this._isSpecialPlaying = false;
        }
    }

    private function showSpecialEvent():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10044_0"), function ():void {
            _isSpecialPlaying = false;
            _pet = _ornamentResLib.getMovieClip("pet");
            _pet.x = 530;
            _pet.y = 357;
            SceneManager.active.mapModel.content.addChild(_pet);
            _pet.buttonMode = true;
            _pet.addEventListener(MouseEvent.CLICK, onFightPet);
        }, true);
    }

    private function clearPet():void {
        if (this._pet) {
            DisplayObjectUtil.removeFromParent(this._pet);
            this._pet.removeEventListener(MouseEvent.CLICK, this.onFightPet);
            this._pet = null;
        }
    }

    private function onFightPet(param1:MouseEvent):void {
        DisplayObjectUtil.disableSprite(this._pet);
        FightManager.addEventListener(FightStartEvent.START_ERROR, this.onStartFightError);
        FightManager.addEventListener(FightStartEvent.START_SUCCESS, this.onStartFightSuccess);
        FightManager.startFightWithWild(FIGHT_INDEX);
    }

    private function onStartFightError(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFightSuccess);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError);
        if (this._pet) {
            DisplayObjectUtil.enableSprite(this._pet);
        }
    }

    private function onStartFightSuccess(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFightSuccess);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError);
        this.clearPet();
    }

    private function onQuestCompleted(param1:QuestEvent):void {
        var str:String = null;
        var evt:QuestEvent = param1;
        if (evt.questId == this._info.inprogressQuest) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestCompleted);
            str = this._info.inprogressQuest.toString();
            this._info.inprogressQuest = 0;
            this.clearCheerIcon();
            this.clearNpc();
            this.createNpc((SceneManager.active as HomeScene).homeInfo.userInfo.vipInfo.isVip());
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation(str), function ():void {
                showCompleteLayout(evt.questId);
            }, true);
        }
    }

    private function onQuestAccepted(param1:QuestEvent):void {
        if (QUEST_ID.indexOf(param1.questId) != -1) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccepted);
            this.updateNpcMark();
        }
    }

    private function createNpc(param1:Boolean):void {
        var _loc2_:NpcDefinition = null;
        if (param1) {
            _loc2_ = new NpcDefinition(VIP_NPC_DEF);
        } else {
            _loc2_ = new NpcDefinition(NORMAL_NPC_DEF);
        }
        var _loc3_:uint = this.getNpcId(param1);
        if (_loc3_) {
            _loc2_.height = NPC_HEIGHT[_loc3_ - 69];
            _loc2_.id = _loc3_;
            _loc2_.resourceId = _loc3_;
        }
        this._npc = MobileManager.createNpc(_loc2_);
        this._npc.buttonMode = true;
        this.updateNpcMark();
        this.updateNpcMouseEvent();
    }

    private function updateNpcMouseEvent():void {
        if (Boolean(this._info.inprogressQuest) && QuestManager.isComplete(this._info.inprogressQuest) == false) {
            this._npc.addEventListener(MouseEvent.ROLL_OVER, this.onNpcOver);
        }
        if (SceneManager.active.mapID != ActorManager.actorInfo.id) {
            this._npc.addEventListener(MouseEvent.CLICK, this.onCoverNpcClick, false, 1);
        } else {
            ModuleManager.addEventListener("DecorateQuestPanel", ModuleEvent.SHOW, this.onQuestPanelShow);
            ModuleManager.addEventListener("DecorateQuestPanel", ModuleEvent.HIDE, this.onQuestPanelHide);
        }
    }

    private function onQuestPanelShow(param1:ModuleEvent):void {
        HomePanel.hideSomePanel();
    }

    private function onQuestPanelHide(param1:ModuleEvent):void {
        HomePanel.showSomePanel();
    }

    private function onCoverNpcClick(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
    }

    private function updateNpcMark():void {
        if (SceneManager.active.mapID != ActorManager.actorInfo.id) {
            return;
        }
        if (QuestManager.isAccepted(10044) || QuestManager.isAccepted(10045) || QuestManager.isAccepted(10046) || QuestManager.isAccepted(10047) || QuestManager.isAccepted(10048) || QuestManager.isAccepted(10049)) {
            if (this._surpriseMark) {
                DisplayObjectUtil.removeFromParent(this._surpriseMark);
            }
        } else if (QuestManager.isComplete(1) && (QuestManager.isCanAccepted(10044) || QuestManager.isCanAccepted(10045) || QuestManager.isCanAccepted(10046) || QuestManager.isCanAccepted(10047) || QuestManager.isCanAccepted(10048) || QuestManager.isCanAccepted(10049))) {
            if (this._surpriseMark == null) {
                this._surpriseMark = new AcceptableMark();
            }
            this._surpriseMark.x = this._npc.x;
            this._surpriseMark.y = this._npc.y - this._npc.height;
            SceneManager.active.mapModel.content.addChild(this._surpriseMark);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onQuestAccepted);
        }
    }

    private function clearNpc():void {
        if (this._npc) {
            this.clearNpcEventListener();
            MobileManager.removeMobile(this._npc, MobileType.NPC);
            this._npc = null;
        }
    }

    private function clearNpcEventListener():void {
        this._npc.removeEventListener(MouseEvent.ROLL_OVER, this.onNpcOver);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onCoverNpcClick);
        ModuleManager.removeEventListener("DecorateQuestPanel", ModuleEvent.SHOW, this.onQuestPanelShow);
        ModuleManager.removeEventListener("DecorateQuestPanel", ModuleEvent.HIDE, this.onQuestPanelHide);
    }

    private function processDecorate():void {
        if (this._ornamentResLib == null) {
            QueueLoader.load(URLUtil.getQuestAnimation("sceneAnimation/" + 10044), LoadType.DOMAIN, this.onLoadComplete);
            return;
        }
        if (SceneManager.active && SceneManager.active.mapModel && SceneManager.active.mapResourceID == 50000) {
            this.processCompleteLayout(this._info.completeList);
        }
    }

    private function onLoadComplete(param1:ContentInfo):void {
        this._ornamentResLib = new ResourceLibrary(param1.content);
        this.processDecorate();
    }

    private function processCompleteLayout(param1:Array = null):void {
        var _loc2_:uint = 0;
        if (param1 != null) {
            for each(_loc2_ in param1) {
                this.showCompleteLayout(_loc2_);
            }
        }
    }

    private function showCompleteLayout(param1:uint):void {
        var _loc2_:MovieClip = null;
        var _loc3_:MovieClip = null;
        var _loc4_:MovieClip = null;
        if (this._groundContainer == null) {
            this._groundContainer = this._ornamentResLib.getMovieClip("groundContainer");
            SceneManager.active.mapModel.ground.addChild(this._groundContainer);
        }
        switch (param1) {
            case 10044:
                DisplayObjectUtil.removeAllChildren(this._groundContainer["quest10044"]);
                this._groundContainer["quest10044"].addChild(this._ornamentResLib.getMovieClip("quest" + 10044));
                break;
            case 10045:
                DisplayObjectUtil.removeAllChildren(this._groundContainer["quest10045"]);
                this._groundContainer["quest10045"].addChild(this._ornamentResLib.getMovieClip("quest" + 10045));
                break;
            case 10046:
                DisplayObjectUtil.removeAllChildren(this._groundContainer["quest10046"]);
                this._groundContainer["quest10046"].addChild(this._ornamentResLib.getMovieClip("quest" + 10046));
                break;
            case 10047:
                _loc2_ = this._ornamentResLib.getMovieClip("quest" + 10047);
                _loc2_.x = 564;
                _loc2_.y = 311;
                SceneManager.active.mapModel.content.addChild(_loc2_);
                break;
            case 10048:
                _loc3_ = this._ornamentResLib.getMovieClip("quest" + 10048);
                _loc3_.x = 427;
                _loc3_.y = 246;
                _loc3_.scaleX = -1;
                SceneManager.active.mapModel.content.addChild(_loc3_);
                break;
            case 10049:
                (_loc4_ = this._ornamentResLib.getMovieClip("quest" + 10049)).x = 300;
                _loc4_.y = 410;
                _loc4_.buttonMode = true;
                _loc4_.addEventListener(MouseEvent.CLICK, this.onSwap10049);
                SceneManager.active.mapModel.content.addChild(_loc4_);
        }
    }

    private function onSwap10049(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        if (_loc2_.currentFrame == 1) {
            _loc2_.gotoAndPlay(2);
        }
        if (SceneManager.active.mapID == ActorManager.actorInfo.id && SwapManager.isSwapNumberMax(SWAP_ID)) {
            SwapManager.entrySwap(SWAP_ID);
        }
    }

    private function initialize():void {
        this._npcIdMap = new HashMap();
        this._npcIdMap.add(100440, 69);
        this._npcIdMap.add(100441, 70);
        this._npcIdMap.add(100450, 71);
        this._npcIdMap.add(100451, 72);
        this._npcIdMap.add(100460, 73);
        this._npcIdMap.add(100461, 74);
        this._npcIdMap.add(100470, 75);
        this._npcIdMap.add(100471, 76);
        this._npcIdMap.add(100480, 77);
        this._npcIdMap.add(100481, 78);
        this._npcIdMap.add(100491, 79);
    }

    private function onNpcOver(param1:MouseEvent):void {
        this.showCheerIcon();
    }

    private function onCheerIconOut(param1:MouseEvent):void {
        if (this._cheerIcon) {
            DisplayObjectUtil.removeFromParent(this._cheerIcon);
        }
    }

    private function showCheerIcon():void {
        if (Boolean(this._cheerIcon) && this._cheerIcon.parent == SceneManager.active.mapModel.front) {
            return;
        }
        if (this._cheerIcon == null) {
            this._timeMcVec = new Vector.<MovieClip>();
            this._cheerIcon = this._ornamentResLib.getMovieClip("cheer");
            this._timeMcVec.push(this._cheerIcon["time"]["mcHourDecade"] as MovieClip);
            this._timeMcVec.push(this._cheerIcon["time"]["mcHourUnit"] as MovieClip);
            this._timeMcVec.push(this._cheerIcon["time"]["mcMinDecade"] as MovieClip);
            this._timeMcVec.push(this._cheerIcon["time"]["mcMinUnit"] as MovieClip);
            this._timeMcVec.push(this._cheerIcon["time"]["mcSecDecade"] as MovieClip);
            this._timeMcVec.push(this._cheerIcon["time"]["mcSecUnit"] as MovieClip);
        }
        this._cheerIcon.addEventListener(MouseEvent.ROLL_OUT, this.onCheerIconOut);
        this._cheerIcon.x = this._npc.x;
        this._cheerIcon.y = this._npc.y - this._npc.height;
        this.updateResideTimeIcon();
        this.updateCheerStatus();
        SceneManager.active.mapModel.front.addChild(this._cheerIcon);
    }

    private function clearCheerIcon():void {
        if (this._cheerIcon) {
            this._cheerIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onCheerIconOut);
            (this._cheerIcon["cheerBtn"] as SimpleButton).removeEventListener(MouseEvent.CLICK, this.onCheer);
            DisplayObjectUtil.removeFromParent(this._cheerIcon);
            this._cheerIcon = null;
        }
        this._timeMcVec = null;
    }

    private function updateResideTimeIcon():void {
        if (this._cheerIcon != null) {
            this.updateTime();
        }
    }

    private function updateTime():void {
        var _loc1_:uint = 0;
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        if (this._timeMcVec != null) {
            _loc1_ = this._info.resideTime / 3600;
            _loc2_ = this._info.resideTime % 3600 / 60;
            _loc3_ = this._info.resideTime % 60;
            this._timeMcVec[0].gotoAndStop(uint(_loc1_ / 10) + 1);
            this._timeMcVec[1].gotoAndStop(uint(_loc1_ % 10) + 1);
            this._timeMcVec[2].gotoAndStop(uint(_loc2_ / 10) + 1);
            this._timeMcVec[3].gotoAndStop(uint(_loc2_ % 10) + 1);
            this._timeMcVec[4].gotoAndStop(uint(_loc3_ / 10) + 1);
            this._timeMcVec[5].gotoAndStop(uint(_loc3_ % 10) + 1);
        }
    }

    private function updateCheerStatus():void {
        var _loc1_:uint = 0;
        if (this._cheerIcon) {
            if (SceneManager.active.mapID == ActorManager.actorInfo.id) {
                _loc1_ = 3600;
            } else {
                _loc1_ = uint(60 * 6);
            }
            if (this._info.resideTime >= _loc1_ && this._info.hasCheer == false && this._info.totalCheerCount < 10 && this._info.beCheeredCount < 6) {
                (this._cheerIcon["cheerBtn"] as SimpleButton).addEventListener(MouseEvent.CLICK, this.onCheer);
            } else {
                DisplayObjectUtil.disableButton(this._cheerIcon["cheerBtn"] as SimpleButton);
                DisplayObjectUtil.grayDisplayObject(this._cheerIcon["cheerBtn"] as SimpleButton);
            }
        }
    }

    private function onCheer(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        DisplayObjectUtil.disableButton(this._cheerIcon["cheerBtn"] as SimpleButton);
        Connection.addCommandListener(CommandSet.DECORATE_CHEER_1188, this.onCheerSuccess);
        Connection.addErrorHandler(CommandSet.DECORATE_CHEER_1188, this.onCheerError);
        Connection.send(CommandSet.DECORATE_CHEER_1188, (SceneManager.active as HomeScene).homeInfo.userId);
    }

    private function onCheerSuccess(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DECORATE_CHEER_1188, this.onCheerSuccess);
        Connection.removeErrorHandler(CommandSet.DECORATE_CHEER_1188, this.onCheerError);
        this._info.hasCheer = true;
        this._info.resideTime = param1.message.getRawData().readUnsignedInt();
        ++this._info.beCheeredCount;
        this.clearCheerIcon();
        this.playCheerSuccessAnimation();
    }

    private function playCheerSuccessAnimation():void {
        var mc:MovieClip = null;
        var str:String = this.getCheerMcName();
        mc = this._ornamentResLib.getMovieClip(str);
        mc.x = this._npc.x;
        mc.y = this._npc.y - this._npc.height;
        SceneManager.active.mapModel.front.addChild(mc);
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(mc);
        });
    }

    private function getCheerMcName():String {
        if ((SceneManager.active as HomeScene).homeInfo.userInfo.vipInfo.isVip()) {
            if (ActorManager.actorInfo.id == SceneManager.active.mapID) {
                return "vip_60";
            }
            return "vip_10";
        }
        if (ActorManager.actorInfo.id == SceneManager.active.mapID) {
            return "normal_60";
        }
        return "normal_10";
    }

    private function onCheerError(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DECORATE_CHEER_1188, this.onCheerSuccess);
        Connection.removeErrorHandler(CommandSet.DECORATE_CHEER_1188, this.onCheerError);
        AlertManager.showAlert("小屋主人信息已更改，正在刷新，请稍后再试");
        Connection.addCommandListener(CommandSet.HOME_GET_ENTRY_INFO_1038, this.onGetHomeInfo);
        Connection.send(CommandSet.HOME_GET_ENTRY_INFO_1038);
    }

    private function getNpcId(param1:Boolean):uint {
        if (SceneManager.active && SceneManager.active is HomeScene && this._info.inprogressQuest && QuestManager.isComplete(this._info.inprogressQuest) == false) {
            return this._npcIdMap.getValue(this._info.inprogressQuest * 10 + uint(param1));
        }
        return 0;
    }

    public function dispose():void {
        Tick.instance.removeRender(this.onTimer);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFightSuccess);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccepted);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestCompleted);
        Connection.removeCommandListener(CommandSet.HOME_GET_ENTRY_INFO_1038, this.onGetHomeInfo);
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandEvent);
        Connection.removeCommandListener(CommandSet.DECORATE_CHEER_1188, this.onCheerSuccess);
        Connection.removeErrorHandler(CommandSet.DECORATE_CHEER_1188, this.onCheerError);
        this.clearCheerIcon();
        this.clearPet();
        this.clearNpc();
        this._npcIdMap = null;
    }
}
}
