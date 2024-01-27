package com.taomee.seer2.app.processor.quest.handler.activity.quest30050 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.ui.Mouse;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30050_141 extends QuestMapHandler {


    private var _npc3:MovieClip;

    private var _gameMC:MovieClip;

    private var _mcList:Vector.<MovieClip>;

    private var _mouseMC:MovieClip;

    private var _mouseTipList:Vector.<MovieClip>;

    private var _currIndex:int;

    private var _alert:MovieClip;

    private var _switchList:Vector.<MovieClip>;

    private var _setTimeout:uint;

    public function QuestMapHandler_30050_141(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(30050, 1) == true && QuestManager.isStepComplete(30050, 2) == false) {
            this.startQuest2();
        }
    }

    private function startQuest2():void {
        Quest30050Content.closeMapPro();
        ActorManager.getActor().startTransform(16);
        _processor.showMouseHintAt(317, 247);
        this.openNpc();
    }

    private function openNpc():void {
        this._npc3 = _processor.resLib.getMovieClip("npc3");
        _map.content.addChild(this._npc3);
        this._npc3.buttonMode = true;
        this._npc3.addEventListener(MouseEvent.CLICK, this.onNpc);
    }

    private function onNpc(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        _processor.hideMouseClickHint();
        this._npc3.removeEventListener(MouseEvent.CLICK, this.onNpc);
        NpcDialog.show(626, "晨璨", [[0, "小胖子，怎么样？和我一起做游戏好玩吗？~"]], ["哈哈哈哈~"], [function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30050_3"), function ():void {
                _map.content["ligthFlowerLeft"].addEventListener(MouseEvent.CLICK, onLight);
                _processor.showMouseHintAt(844, 331);
            }, true, false, 2);
        }]);
    }

    private function onLight(param1:MouseEvent):void {
        _map.content["ligthFlowerLeft"].removeEventListener(MouseEvent.CLICK, this.onLight);
        this.showGame();
    }

    private function showGame():void {
        this._gameMC = _processor.resLib.getMovieClip("gameMC");
        LayerManager.topLayer.addChild(this._gameMC);
        this._mcList = Vector.<MovieClip>([]);
        this._mouseTipList = Vector.<MovieClip>([]);
        this._mouseMC = this._gameMC["mouseMC"];
        this._mouseMC.mouseChildren = true;
        this._mouseMC.mouseEnabled = true;
        var _loc1_:int = 0;
        while (_loc1_ < 8) {
            if (_loc1_ < 7) {
                this._mcList.push(this._gameMC["mc" + _loc1_]);
                this._mouseTipList.push(this._gameMC["tip" + _loc1_]);
            } else {
                this._mouseTipList.push(this._gameMC["tip" + _loc1_]);
            }
            _loc1_++;
        }
        this._mouseMC.buttonMode = true;
        this.hideAllTip();
        this._mouseTipList[0].visible = true;
        this._mouseMC.addEventListener(MouseEvent.CLICK, this.onMouse);
    }

    private function hideAllTip():void {
        var _loc1_:MovieClip = null;
        for each(_loc1_ in this._mouseTipList) {
            _loc1_.visible = false;
        }
    }

    private function onMouse(param1:MouseEvent):void {
        this._mouseMC.removeEventListener(MouseEvent.CLICK, this.onMouse);
        this._mouseMC.addEventListener(MouseEvent.CLICK, this.onHit);
        this._gameMC.addEventListener(MouseEvent.MOUSE_MOVE, this.onMove);
        this.openIndex(1);
        Mouse.hide();
    }

    private function openIndex(param1:uint):void {
        this._currIndex = param1;
        this.hideAllTip();
        this._mouseTipList[param1].visible = true;
    }

    private function onHit(param1:MouseEvent):void {
        if (this._mouseMC.hitTestObject(this._mcList[this._currIndex - 1])) {
            DisplayUtil.removeForParent(this._mcList[this._currIndex - 1]);
            if (this._currIndex == 7) {
                this.win();
            } else {
                this.openIndex(this._currIndex + 1);
            }
        }
    }

    private function win():void {
        this._gameMC.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMove);
        Mouse.show();
        DisplayUtil.removeForParent(this._gameMC);
        this.showAlert();
    }

    private function showAlert():void {
        this._alert = _processor.resLib.getMovieClip("alert30050");
        LayerManager.topLayer.addChild(this._alert);
        DisplayUtil.align(this._alert, 4, LayerManager.rootRect);
        this._switchList = Vector.<MovieClip>([]);
        var _loc1_:int = 0;
        while (_loc1_ < 2) {
            this._switchList.push(this._alert["switch" + _loc1_]);
            this._switchList[_loc1_].gotoAndStop(1);
            this._switchList[_loc1_].addEventListener(MouseEvent.CLICK, this.onSwitch);
            _loc1_++;
        }
    }

    private function onSwitch(param1:MouseEvent):void {
        var index:int = 0;
        var sw:MovieClip = null;
        var event:MouseEvent = param1;
        index = this._switchList.indexOf(event.currentTarget as MovieClip);
        this._switchList[index].gotoAndStop(2);
        for each(sw in this._switchList) {
            sw.removeEventListener(MouseEvent.CLICK, this.onSwitch);
        }
        this._setTimeout = setTimeout(function ():void {
            DisplayUtil.removeForParent(_alert);
            if (index == 0) {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "这只是晨璨四年前的过去，她已经意识到了自己的错误，但是这些错误不至于让她变成现在这样，于是……"]], ["回到现实"], [function ():void {
                    completeQuest30050();
                }]);
            } else {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "即使你已经原谅了她，也挽回不了她内心的内疚，但是她的内疚也不至于让她变成现在这样，于是……"]], ["回到现实"], [function ():void {
                    completeQuest30050();
                }]);
            }
        }, 1500);
    }

    private function completeQuest30050():void {
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        QuestManager.completeStep(30050, 2);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        this.disposeAll();
    }

    private function disposeAll():void {
        clearTimeout(this._setTimeout);
        DisplayUtil.removeForParent(this._alert);
        Quest30050Content.openMapPro();
        Mouse.show();
        DisplayUtil.removeForParent(this._gameMC);
        DisplayUtil.removeForParent(this._npc3);
        ActorManager.getActor().stopTransform();
    }

    private function onMove(param1:MouseEvent):void {
        this._mouseMC.x = this._gameMC.mouseX;
        this._mouseMC.y = this._gameMC.mouseY;
    }

    override public function processMapDispose():void {
        this.disposeAll();
        super.processMapDispose();
    }
}
}
