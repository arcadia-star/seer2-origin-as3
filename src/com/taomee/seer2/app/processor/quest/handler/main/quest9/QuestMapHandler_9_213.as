package com.taomee.seer2.app.processor.quest.handler.main.quest9 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Mouse;
import flash.utils.Timer;

public class QuestMapHandler_9_213 extends QuestMapHandler {


    private var _duoluoAnimation:MovieClip;

    private var _cookContent:MovieClip;

    private var _bottle:MovieClip;

    private var _dragMcVec:Vector.<MovieClip>;

    private var _dragPosVec:Vector.<Point>;

    private var _dragIndex:int;

    private var _dragMc:MovieClip;

    private var _dragTimer:Timer;

    private var _hotArea:MovieClip;

    private var _stopHotAreaOut:Boolean;

    private var _handMc:MovieClip;

    private var _xuanzhuanMc:MovieClip;

    private var _isDrawing:Boolean;

    private var _interactRect:Rectangle;

    private var _matchAreaArr:Array;

    private var _matchResultArr:Array;

    public function QuestMapHandler_9_213(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._duoluoAnimation = _map.front["quest_9"];
        this._duoluoAnimation.gotoAndStop(2);
        if (_quest.status == QuestStatus.ACCEPTABLE) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAcceptQuest);
        } else if (_quest.status == QuestStatus.IN_PROGRESS) {
            if (!_quest.isStepCompete(1)) {
                this.processStep1();
            } else if (!_quest.isStepCompete(2)) {
                this.processStep2();
            }
            if (_quest.isStepCompete(3)) {
                if (!_quest.isStepCompete(4)) {
                    this.processStep4();
                } else if (!_quest.isStepCompete(5)) {
                    this.processStep5();
                } else if (!_quest.isStepCompete(6)) {
                    this.processStep6();
                }
            }
        } else {
            this._duoluoAnimation.gotoAndStop(1);
        }
    }

    private function onAcceptQuest(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptQuest);
            this.processStep1();
        }
    }

    private function processStep1():void {
        MovieClipUtil.playHahaTalk(URLUtil.getQuestAnimation("9/npctalk_0"), 2, [770, 475], function ():void {
            NpcDialog.show(27, "占卜婆婆", [[3, "我不管！你现在就给我做出一模一样的料理！不然我就不让你走！你就永远陪着我这个老人家！"]], ["（怎么办？作为队长的我要承担责任!）"], [function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "婆婆，多罗的事我代他和你说对不起，请问如何才能制作出一模一样的料理呢？"]], ["（不知道难不难……）"], [function ():void {
                    NpcDialog.show(27, "占卜婆婆", [[0, "呵！这才像样！说难不难，说简单不简单！这样吧！你先去<font color=\'#ffcc00\'>残骸通道</font>替我找料理食材<font color=\'#ffcc00\'>蓝虎鲸的鱼翅</font>"]], [" 额……精灵=食材？天啊……"], [function ():void {
                        MovieClipUtil.getChildList(_duoluoAnimation, 3, ["duoluo"], function (param1:Vector.<DisplayObject>):void {
                            var children:Vector.<DisplayObject> = param1;
                            var mc:* = children[0] as MovieClip;
                            MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                                NpcDialog.show(27, "占卜婆婆", [[3, "怎么？不愿意啊？那好！多罗以后就是我的奴隶！这里又黑又冷！这里晚上还会有很多凶猛的精灵！"]], ["好啦！好啦！我去……"], [function ():void {
                                    MovieClipUtil.getChildList(_duoluoAnimation, 4, ["duoluo"], function (param1:Vector.<DisplayObject>):void {
                                        var children:Vector.<DisplayObject> = param1;
                                        var mc:* = children[0] as MovieClip;
                                        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                                            _duoluoAnimation.gotoAndStop(2);
                                            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[3, "（我怎么会认识你？）……好吧！谁让我是你队长！你给我安分点啦！"]], ["前往悲伤残骸"], [function ():void {
                                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep1);
                                                QuestManager.completeStep(_quest.id, 1);
                                            }]);
                                        }, true);
                                    });
                                }]);
                            }, true);
                        });
                    }]);
                }]);
            }]);
        });
    }

    private function onCompleteStep1(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            this.processStep2();
        }
    }

    private function processStep2():void {
        _processor.showMouseHintAt(90, 290);
    }

    private function processStep4():void {
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[3, "可恶……精灵是我们的朋友！又不是餐桌上的美味！没错！我没有得到鱼翅！我来代替多罗做苦工就是了！"]], ["（老……老巫婆！）"], [function ():void {
            NpcDialog.show(27, "占卜婆婆", [[1, "哟哟哟……看来是生气了！食材的事情就此罢过！你就帮我放置调料"]], ["上就上吧……（第一次做料理）"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep4);
                QuestManager.completeStep(_quest.id, 4);
            }]);
        }]);
    }

    private function onCompleteStep4(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
            this.processStep5();
        }
    }

    private function processStep5():void {
        this._interactRect = new Rectangle(418, 225, 364, 198);
        this._dragTimer = new Timer(500);
        this._dragTimer.addEventListener(TimerEvent.TIMER, this.onTimer);
        MovieClipUtil.getSwfContent(URLUtil.getQuestAnimation("9/cook"), function (param1:MovieClip):void {
            var mc:MovieClip = param1;
            _cookContent = mc;
            MovieClipUtil.getChildList(mc, 2, ["bottle", "water", "chilli", "pepper", "salt", "spoon", "hand", "xuanzhuan", "hotArea", "areaHolder"], function (param1:Vector.<DisplayObject>):void {
                var _loc5_:MovieClip = null;
                LayerManager.topLayer.addChild(_cookContent);
                _cookContent.x += 120;
                _cookContent.y += 50;
                var _loc2_:MovieClip = UIManager.getMovieClip("UI_PlayScreen");
                _loc2_.x -= 120;
                _loc2_.y -= 50;
                _cookContent.addChild(_loc2_);
                LayerManager.focusOnTopLayer();
                _bottle = param1[0] as MovieClip;
                _bottle.gotoAndStop(1);
                _dragMcVec = new Vector.<MovieClip>();
                _dragPosVec = new Vector.<Point>();
                var _loc3_:int = 1;
                while (_loc3_ < 6) {
                    (_loc5_ = param1[_loc3_] as MovieClip).gotoAndStop(1);
                    _loc5_.visible = false;
                    _dragMcVec.push(_loc5_);
                    _dragPosVec.push(new Point(_loc5_.x, _loc5_.y));
                    _loc3_++;
                }
                _dragIndex = 0;
                updateDragMc();
                _handMc = param1[6] as MovieClip;
                _handMc.visible = false;
                _handMc.mouseEnabled = false;
                _handMc.mouseChildren = false;
                _xuanzhuanMc = param1[7] as MovieClip;
                _xuanzhuanMc.mouseEnabled = false;
                _xuanzhuanMc.mouseChildren = false;
                _xuanzhuanMc.visible = false;
                _hotArea = param1[8] as MovieClip;
                _hotArea.addEventListener(MouseEvent.MOUSE_OUT, onHotAreaOut);
                _hotArea.addEventListener(MouseEvent.MOUSE_DOWN, onHotAreaDown);
                _hotArea.addEventListener(MouseEvent.MOUSE_UP, onHotAreaUp);
                _hotArea.addEventListener(MouseEvent.MOUSE_MOVE, onHotAreaMove);
                _hotArea.addEventListener(MouseEvent.CLICK, onHotAreaClick);
                DisplayObjectUtil.disableSprite(_hotArea);
                var _loc4_:MovieClip;
                (_loc4_ = param1[9] as MovieClip).mouseEnabled = false;
                _loc4_.mouseChildren = false;
                _matchAreaArr = [];
                _loc3_ = 0;
                while (_loc3_ < 10) {
                    _matchAreaArr.push(DisplayObject(_loc4_["area" + _loc3_]).getBounds(LayerManager.stage));
                    _loc3_++;
                }
            });
        });
    }

    private function updateDragMc():void {
        Mouse.show();
        this._dragMc = this._dragMcVec[this._dragIndex];
        this._dragMc.x = this._dragPosVec[this._dragIndex].x;
        this._dragMc.y = this._dragPosVec[this._dragIndex].y;
        this._dragMc.visible = true;
        this._dragMc.addEventListener(MouseEvent.ROLL_OVER, this.onDragMcOver);
        this._dragMc.addEventListener(MouseEvent.ROLL_OUT, this.onDragMcOut);
        this._dragMc.addEventListener(MouseEvent.CLICK, this.onDragMcClick);
        this._isDrawing = false;
    }

    private function onDragMcOver(param1:MouseEvent):void {
        Mouse.hide();
        this._handMc.visible = true;
        this._handMc.startDrag(true);
    }

    private function onDragMcOut(param1:MouseEvent):void {
        Mouse.show();
        this._handMc.visible = false;
        this._handMc.stopDrag();
    }

    private function onDragMcClick(param1:MouseEvent):void {
        this._handMc.visible = false;
        this._dragMc.startDrag(true, new Rectangle(172, 81, 608, 311));
        this._dragMc.removeEventListener(MouseEvent.ROLL_OVER, this.onDragMcOver);
        this._dragMc.removeEventListener(MouseEvent.ROLL_OUT, this.onDragMcOut);
        this._dragMc.removeEventListener(MouseEvent.CLICK, this.onDragMcClick);
        DisplayObjectUtil.enableSprite(this._hotArea);
        this._stopHotAreaOut = false;
    }

    private function onHotAreaOut(param1:MouseEvent):void {
        if (this._stopHotAreaOut) {
            return;
        }
        if (this._isDrawing) {
            this._hotArea.graphics.clear();
        }
        this._dragMc.stopDrag();
        this.updateDragMc();
        DisplayObjectUtil.disableSprite(this._hotArea);
    }

    private function onHotAreaMove(param1:MouseEvent):void {
        var _loc2_:int = 0;
        Mouse.hide();
        if (this._isDrawing) {
            this._hotArea.graphics.lineTo(param1.localX, param1.localY);
            _loc2_ = 0;
            while (_loc2_ < this._matchAreaArr.length) {
                if (Rectangle(this._matchAreaArr[_loc2_]).contains(param1.stageX, param1.stageY)) {
                    this._matchResultArr[_loc2_] = true;
                }
                _loc2_++;
            }
        }
    }

    private function onHotAreaDown(param1:MouseEvent):void {
        var _loc2_:int = 0;
        if (this._dragIndex == this._dragMcVec.length - 1) {
            this._isDrawing = true;
            this._hotArea.graphics.lineStyle(10, 16711680);
            this._hotArea.graphics.moveTo(param1.localX, param1.localY);
            this._matchResultArr = [];
            _loc2_ = 0;
            while (_loc2_ < 9) {
                this._matchResultArr.push(false);
                _loc2_++;
            }
        }
    }

    private function onHotAreaUp(param1:MouseEvent):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (this._isDrawing) {
            this._isDrawing = false;
            this._hotArea.graphics.clear();
            this._dragMc.stopDrag();
            this.updateDragMc();
            DisplayObjectUtil.disableSprite(this._hotArea);
            _loc2_ = 0;
            _loc3_ = 0;
            while (_loc3_ < this._matchResultArr.length) {
                if (this._matchResultArr[_loc3_]) {
                    _loc2_++;
                }
                _loc3_++;
            }
            if (_loc2_ >= 7) {
                this.closeCook(true);
            }
        }
    }

    private function onHotAreaClick(param1:MouseEvent):void {
        if (this._dragIndex <= this._dragMcVec.length - 1 && this._interactRect.intersects(this._dragMc.getBounds(this._dragMc.stage))) {
            DisplayObjectUtil.disableSprite(this._hotArea);
            this._dragTimer.start();
            this._dragMc.stopDrag();
            this._dragMc.visible = false;
            this._stopHotAreaOut = true;
        }
    }

    private function onTimer(param1:TimerEvent):void {
        var evt:TimerEvent = param1;
        this._dragTimer.stop();
        this._dragMc.x = this._dragPosVec[this._dragIndex].x;
        this._dragMc.y = this._dragPosVec[this._dragIndex].y;
        this._dragMc.visible = true;
        MovieClipUtil.getChildList(this._dragMc, 2, [0], function (param1:Vector.<DisplayObject>):void {
            var children:Vector.<DisplayObject> = param1;
            var mc:MovieClip = children[0] as MovieClip;
            MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                if (_dragIndex <= 1) {
                    _bottle.gotoAndStop(_dragIndex + 2);
                } else if (_dragIndex == _dragMcVec.length - 2) {
                    _xuanzhuanMc.visible = true;
                }
                ++_dragIndex;
                if (_dragIndex == _dragMcVec.length) {
                    closeCook(true);
                } else {
                    _dragMc.visible = false;
                    updateDragMc();
                }
            });
        });
    }

    private function closeCook(param1:Boolean):void {
        var isSuccess:Boolean = param1;
        this._dragTimer.removeEventListener(TimerEvent.TIMER, this.onTimer);
        this._dragTimer.stop();
        if (this._hotArea != null) {
            this._hotArea.removeEventListener(MouseEvent.MOUSE_OUT, this.onHotAreaOut);
            this._hotArea.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHotAreaDown);
            this._hotArea.removeEventListener(MouseEvent.MOUSE_UP, this.onHotAreaUp);
            this._hotArea.removeEventListener(MouseEvent.MOUSE_MOVE, this.onHotAreaMove);
            this._hotArea.removeEventListener(MouseEvent.CLICK, this.onHotAreaClick);
        }
        if (this._dragMc != null) {
            this._dragMc.removeEventListener(MouseEvent.ROLL_OVER, this.onDragMcOver);
            this._dragMc.removeEventListener(MouseEvent.ROLL_OUT, this.onDragMcOut);
            this._dragMc.removeEventListener(MouseEvent.CLICK, this.onDragMcClick);
        }
        DisplayObjectUtil.removeFromParent(this._cookContent);
        LayerManager.resetOperation();
        if (isSuccess) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestAnimation("9/fullScreen_1"), function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep5);
                QuestManager.completeStep(_quest.id, 5);
            });
        }
    }

    private function onCompleteStep5(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep5);
            this.processStep6();
        }
    }

    private function processStep6():void {
        _processor.showMouseHintAt(90, 290);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep5);
    }
}
}
