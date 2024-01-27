package com.taomee.seer2.app.processor.quest.handler.branch.quest10125 {
import com.taomee.seer2.app.entity.Mineport;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_46;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10125_Mine extends QuestMapHandler {


    private var yellowNum:int;

    protected var blueNum:int;

    private var redNum:int;

    private var yData:XML;

    private var bData:XML;

    private var rData:XML;

    public var mineId:int;

    private var minePort:Mineport;

    private var num:int;

    public function QuestMapHandler_10125_Mine(param1:QuestProcessor) {
        this.yData = <mineport id="2" resId="2" name="黄色矿脉" pos="820,270" actorPos="800,270" limit="3" aniPos="0,0"
                               serverConfigId="2"/>;
        this.bData = <mineport id="3" resId="1" name="蓝色矿脉" pos="550,220" actorPos="398,400" limit="3"
                               serverConfigId="4"/>;
        this.rData = <mineport id="2" resId="3" name="红色矿脉" pos="710,415" actorPos="135,260" limit="3"
                               serverConfigId="1"/>;
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            ServerBufferManager.getServerBuffer(ServerBufferType.NEWPLAYER_BUFF, this.getBuffer);
            MonsterManager.hideAllMonster();
            this.num = 0;
        }
    }

    private function getBuffer(param1:ServerBuffer):void {
        var _loc2_:XML = null;
        this.yellowNum = param1.readDataAtPostion(ServerBufferPosition_46.YELLOW_MINE_NUM);
        this.blueNum = param1.readDataAtPostion(ServerBufferPosition_46.BLUE_MINE_NUM);
        this.redNum = param1.readDataAtPostion(ServerBufferPosition_46.RED_MINE_NUM);
        if (this.mineId == 400001) {
            _loc2_ = this.yData;
            this.num = this.yellowNum;
        }
        if (this.mineId == 400004) {
            _loc2_ = this.bData;
            this.num = this.blueNum;
        }
        if (this.mineId == 400002) {
            _loc2_ = this.rData;
            this.num = this.redNum;
        }
        if (this.num < 2) {
            this.createdMinePort(_loc2_);
        }
    }

    private function alertTo220():void {
        if (this.yellowNum + this.blueNum + this.redNum > 5) {
            AlertManager.showAlert("矿石采集得差不多了，现在返回幽静浅滩给阿宝吧。", function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onSetp);
                QuestManager.completeStep(10125, 3);
            });
        } else if (this.num > 1) {
            ModuleManager.toggleModule(URLUtil.getAppModule("ABaoMinePanel"));
        }
    }

    private function onSetp(param1:QuestEvent):void {
        if (param1.questId == 10125 && param1.stepId == 3) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onSetp);
            SceneManager.changeScene(SceneType.LOBBY, 220);
        }
    }

    private function createdMinePort(param1:XML):void {
        this.minePort = new Mineport();
        this.minePort.setData(param1);
        AnimateElementManager.addElement(this.minePort);
        this.minePort.addEventListener(MouseEvent.CLICK, this.toMine, false, 1000);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this.minePort) {
            this.minePort.removeEventListener(MouseEvent.CLICK, this.toMine);
        }
        MonsterManager.showAllMonster();
    }

    private function toMine(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        var _mineAnimation:MovieClip = UIManager.getMovieClip("UI_mineAnimation");
        var port:Mineport = event.target as Mineport;
        port.addChild(_mineAnimation);
        this.minePort.mouseEnabled = false;
        MovieClipUtil.playMc(_mineAnimation, 1, _mineAnimation.totalFrames, function ():void {
            if (mineId == 400001) {
                ++yellowNum;
                ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF, ServerBufferPosition_46.YELLOW_MINE_NUM, yellowNum);
                num = yellowNum;
            }
            if (mineId == 400004) {
                ++blueNum;
                ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF, ServerBufferPosition_46.BLUE_MINE_NUM, blueNum);
                num = blueNum;
            }
            if (mineId == 400002) {
                ++redNum;
                ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF, ServerBufferPosition_46.RED_MINE_NUM, redNum);
                num = redNum;
            }
            if (num > 1) {
                DisplayObjectUtil.removeFromParent(minePort);
            }
            AlertManager.showItemGainedAlert(mineId, 1, function ():void {
                minePort.mouseEnabled = true;
                alertTo220();
            });
        });
        event.stopPropagation();
        event.stopImmediatePropagation();
    }
}
}
