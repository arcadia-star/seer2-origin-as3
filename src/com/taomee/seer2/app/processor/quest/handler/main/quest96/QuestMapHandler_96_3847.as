package com.taomee.seer2.app.processor.quest.handler.main.quest96 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.geom.Point;

public class QuestMapHandler_96_3847 extends QuestMapHandler {


    private const FIGHT_ID:uint = 1656;

    private var _mouse:MouseClickHintSprite;

    private var _dropMc:MovieClip;

    private var _mainUI:MovieClip;

    private var _closeBtn:SimpleButton;

    private var _targetList:Vector.<MovieClip>;

    private var _targetLightList:Vector.<MovieClip>;

    private var _pieceList:Vector.<MovieClip>;

    private var _curDrag:MovieClip;

    private var _oldPos:Point;

    private var npc:Mobile;

    private var _npc:Mobile;

    public function QuestMapHandler_96_3847(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false) {
            RightToolbarConter.instance.hide();
            if (QuestManager.isStepComplete(questID, 1) == false) {
                this.createNPC40();
            } else if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
                MovieClipUtil.getSwfContent(URLUtil.getActivityAnimation("SearchDarkCode/dropBox"), function callBack(param1:MovieClip):void {
                    _dropMc = param1;
                    _map.content.addChild(param1);
                    showMouseClick(_dropMc.boxMc.x + 20, _dropMc.boxMc.y + 10);
                    _dropMc.dropBox.visible = false;
                    _dropMc.boxMc.buttonMode = true;
                    MovieClip(_dropMc.boxMc).addEventListener(MouseEvent.CLICK, onBoxMc);
                });
            } else if (QuestManager.isStepComplete(questID, 2) && !QuestManager.isStepComplete(questID, 3)) {
                this.showMouseClick(934, 253);
            }
        } else if (!QuestManager.isAccepted(questID)) {
            SceneManager.changeScene(SceneType.LOBBY, 3848);
        }
    }

    private function showMouseClick(param1:Number, param2:Number):void {
        if (this._mouse == null) {
            this._mouse = new MouseClickHintSprite();
        }
        this._mouse.x = param1;
        this._mouse.y = param2;
        _map.front.addChild(this._mouse);
    }

    private function onBoxMc(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        MovieClip(evt.currentTarget).removeEventListener(MouseEvent.CLICK, this.onBoxMc);
        _map.front.removeChild(this._mouse);
        NpcDialog.show(11, "多罗", [[0, "这是什么？"]], ["好像是个盒子"], [function ():void {
            NpcDialog.show(10, "巴蒂", [[0, "好像里面装了什么东西，我们试试看能不能打开来~"]], ["好奇怪的盒子啊"], [function ():void {
                NpcDialog.show(11, "多罗", [[0, "面有些奇怪的符文诶~"]], ["我也看到了"], [function ():void {
                    NpcDialog.show(10, "巴蒂", [[0, "似乎是打开这个盒子的机关，刚那个小喽啰被我踢飞的时候身上好像还掉了些什么下来，我们在附近找找，或许能打开它"]], ["好~我来找找"], [function ():void {
                        if (!QuestManager.isStepComplete(questID, 1)) {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete1);
                            QuestManager.completeStep(questID, 1);
                        } else {
                            startGame();
                        }
                    }]);
                }]);
            }]);
        }]);
    }

    private function onCompleteSwitch(param1:SceneEvent):void {
        var e:SceneEvent = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onCompleteSwitch);
            if (this.FIGHT_ID == FightManager.currentFightRecord.initData.positionIndex) {
                if (FightManager.isWinWar()) {
                    this.npc = MobileManager.getMobile(40, MobileType.NPC);
                    if (this.npc) {
                        this.npc.visible = false;
                    }
                    MovieClipUtil.getSwfContent(URLUtil.getActivityAnimation("SearchDarkCode/dropBox"), function callBack(param1:MovieClip):void {
                        var mc:MovieClip = param1;
                        _dropMc = mc;
                        _map.front.addChild(mc);
                        mc.boxMc.visible = false;
                        MovieClipUtil.playMc(MovieClip(mc.dropBox), 2, MovieClip(mc.dropBox).totalFrames, function ended():void {
                            MovieClip(mc.dropBox).gotoAndStop(1);
                            mc.dropBox.visible = false;
                            _map.front.removeChild(mc);
                            mc.boxMc.visible = true;
                            _mouse = new MouseClickHintSprite();
                            _mouse.x = mc.boxMc.x + 20;
                            _mouse.y = mc.boxMc.y + 10;
                            _map.front.addChild(_mouse);
                            mc.boxMc.buttonMode = true;
                            _map.content.addChild(mc.boxMc);
                            MovieClip(mc.boxMc).addEventListener(MouseEvent.CLICK, onBoxMc);
                        });
                    });
                } else {
                    NpcDialog.show(3020, "费雷德", [[0, "小渣渣！以后大爷的事记得少管！知道了吗？！！"]], ["你你你等着！！"]);
                }
            }
        }
    }

    private function onStepComplete1(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete1);
        this.startGame();
    }

    private function startGame():void {
        MovieClipUtil.getSwfContent(URLUtil.getActivityAnimation("SearchDarkCode/game"), function callBack(param1:MovieClip):void {
            ActorManager.getActor().hide();
            ActorManager.getActor().blockFollowingPet = false;
            ActorManager.getActor().blockNoNo = false;
            _mainUI = param1;
            initGame();
            initGameEvent();
            _map.front.addChild(_mainUI);
        });
    }

    private function initGame():void {
        _map.content.addChild(this._mainUI);
        var _loc1_:int = 0;
        this._targetList = new Vector.<MovieClip>();
        this._targetLightList = new Vector.<MovieClip>();
        this._pieceList = new Vector.<MovieClip>();
        _loc1_ = 0;
        while (_loc1_ < 3) {
            this._targetList.push(this._mainUI["targetMc"]["targetDark" + _loc1_]);
            this._targetLightList.push(this._mainUI["targetMc"]["targetLight" + _loc1_]);
            this._targetLightList[_loc1_].visible = false;
            this._pieceList.push(this._mainUI["piece" + _loc1_]);
            this._pieceList[_loc1_].buttonMode = true;
            _loc1_++;
        }
        this._closeBtn = this._mainUI["targetMc"]["closeBtn"];
        this._oldPos = new Point();
    }

    private function initGameEvent():void {
        this._mainUI.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        var _loc1_:int = 0;
        _loc1_ = 0;
        while (_loc1_ < this._targetList.length) {
            this._targetList[_loc1_].addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this._pieceList[_loc1_].addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            _loc1_++;
        }
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
    }

    private function onClose(param1:MouseEvent):void {
        this._mainUI.visible = false;
        this._mouse = new MouseClickHintSprite();
        this._mouse.x = this._dropMc.boxMc.x + 20;
        this._mouse.y = this._dropMc.boxMc.y + 10;
        _map.front.addChild(this._mouse);
        this._dropMc.boxMc.buttonMode = true;
        this._dropMc["boxMc"].addEventListener(MouseEvent.CLICK, this.onBoxMc);
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
    }

    private function onMouseDown(param1:MouseEvent):void {
        var _loc2_:int = this._pieceList.indexOf(param1.currentTarget as MovieClip);
        if (_loc2_ != -1) {
            this._pieceList[_loc2_].startDrag(true);
            this._pieceList[_loc2_].mouseEnabled = this._pieceList[_loc2_].mouseChildren = false;
            this._curDrag = this._pieceList[_loc2_];
            this.setFilter(this._curDrag, 16711680);
            this._oldPos.x = this._pieceList[_loc2_].x;
            this._oldPos.y = this._pieceList[_loc2_].y;
        }
    }

    private function setFilter(param1:DisplayObject, param2:uint):void {
        var _loc3_:GlowFilter = new GlowFilter();
        _loc3_.blurX = 10;
        _loc3_.blurY = 10;
        _loc3_.color = param2;
        _loc3_.inner = false;
        param1.filters = [_loc3_];
    }

    private function onMouseUp(param1:MouseEvent):void {
        var _loc3_:Boolean = false;
        var _loc4_:int = 0;
        var _loc2_:int = this._targetList.indexOf(param1.currentTarget as MovieClip);
        if (_loc2_ != -1) {
            if (Boolean(this._curDrag) && this._pieceList.indexOf(this._curDrag) == _loc2_) {
                this._curDrag.stopDrag();
                this._targetList[_loc2_].mouseEnabled = this._targetList[_loc2_].mouseChildren = false;
                this._pieceList[_loc2_].mouseEnabled = this._pieceList[_loc2_].mouseChildren = false;
                this._pieceList[_loc2_].filters = [];
                this._targetLightList[_loc2_].visible = true;
                this._curDrag.visible = false;
                _loc3_ = true;
                _loc4_ = 0;
                _loc4_ = 0;
                while (_loc4_ < this._targetLightList.length) {
                    if (this._targetLightList[_loc4_].visible == false) {
                        _loc3_ = false;
                    }
                    _loc4_++;
                }
                if (_loc3_) {
                    ActorManager.getActor().show();
                    ActorManager.getActor().blockFollowingPet = false;
                    ActorManager.getActor().blockNoNo = false;
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete2);
                    QuestManager.completeStep(questID, 2);
                }
            } else if (this._curDrag) {
                this._curDrag.stopDrag();
                this._curDrag.x = this._oldPos.x;
                this._curDrag.y = this._oldPos.y;
                this._curDrag.mouseEnabled = this._curDrag.mouseChildren = true;
                this.setFilter(this._curDrag, 16776960);
            }
        } else if (this._curDrag) {
            this._curDrag.stopDrag();
            this._curDrag.x = this._oldPos.x;
            this._curDrag.y = this._oldPos.y;
            this._curDrag.mouseEnabled = this._curDrag.mouseChildren = true;
            this.setFilter(this._curDrag, 16776960);
        }
    }

    private function onStepComplete2(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete2);
        if (this._mainUI) {
            this._mainUI.visible = false;
        }
        MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("searchDarkCode/searchDarkCode0"), function callBack():void {
            NpcDialog.show(11, "多罗", [[0, "这是什么？"]], ["。。。。。。"], [function ():void {
                NpcDialog.show(10, "巴蒂", [[0, "好像是一张从书上撕下来的残页，会不会就是黑暗法典?"]], ["。。。。。。"], [function ():void {
                    NpcDialog.show(11, "多罗", [[0, "但是上面什么东西都没写啊？！"]], ["。。。。。。"], [function ():void {
                        NpcDialog.show(10, "巴蒂", [[0, "你要是能能看得懂才怪了！我们先去问问弗雷德吧~"]], ["。。。。。。"], [function ():void {
                            if (!QuestManager.isStepComplete(questID, 3)) {
                                showMouseClick(934, 253);
                            }
                        }]);
                    }]);
                }]);
            }]);
        }, true, true, 2, true);
    }

    private function createNPC40():void {
        this._npc = new Mobile();
        this._npc.setPostion(new Point(960, 420));
        this._npc.label = "萨伦小兵";
        this._npc.id = 40;
        this._npc.resourceUrl = URLUtil.getNpcSwf(40);
        this._npc.buttonMode = true;
        MobileManager.addMobile(this._npc, MobileType.NPC);
        var _loc1_:AcceptableMark = new AcceptableMark();
        this._npc.addChild(_loc1_);
        _loc1_.y = -60;
        this._npc.addEventListener(MouseEvent.CLICK, this.dialogShow);
    }

    private function dialogShow(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(400, "赛尔", [[0, "站住，你！鬼鬼祟祟的在做什么?"]], ["是不是偷法典的家伙？"], [function ():void {
            NpcDialog.show(40, "萨伦小兵", [[0, "咳……你是什么鬼，我们要干嘛还轮不到你管，找死吗？"]], ["找死的是你吧！"], [function ():void {
                NpcDialog.show(40, "萨伦小兵", [[0, "好好好！等着啊！有种你放学别走！"]], ["现在就揍你！"], [function ():void {
                    SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onCompleteSwitch);
                    FightManager.startFightWithWild(FIGHT_ID);
                }]);
            }]);
        }]);
    }

    override public function processMapDispose():void {
        if (Boolean(this._closeBtn) && this._closeBtn.hasEventListener(MouseEvent.CLICK)) {
            this._closeBtn.removeEventListener(MouseEvent.CLICK, this.onClose);
            this._closeBtn = null;
        }
        while (Boolean(this._targetList) && Boolean(this._targetList.length)) {
            this._targetList.pop();
        }
        while (Boolean(this._targetLightList) && Boolean(this._targetList.length)) {
            this._targetLightList.pop();
        }
        while (Boolean(this._pieceList) && Boolean(this._targetList.length)) {
            this._pieceList.pop();
        }
        if (this._mainUI) {
            this._mainUI = null;
        }
        if (this.npc) {
            this.npc.visible = true;
        }
        if (this._npc) {
            MobileManager.removeMobile(this._npc, MobileType.NPC);
        }
        super.processMapDispose();
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
    }
}
}
