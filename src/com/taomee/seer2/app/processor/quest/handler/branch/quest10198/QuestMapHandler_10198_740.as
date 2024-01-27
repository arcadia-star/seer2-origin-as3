package com.taomee.seer2.app.processor.quest.handler.branch.quest10198 {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class QuestMapHandler_10198_740 extends QuestMapHandler {


    private var hitTestArea:Sprite;

    private const LIMIT_ID:int = 202990;

    public function QuestMapHandler_10198_740(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(10198, 1) == true && QuestManager.isStepComplete(10198, 2) == false) {
            if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 517) {
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    AlertManager.showAlert("成功找到发光物，前往下一个地图继续寻找吧！", function ():void {
                        ModuleManager.toggleModule(URLUtil.getAppModule("YiBeastPanel"), "", "1");
                    });
                } else {
                    AlertManager.showAlert("线索中断，被精灵抢走，你要从头开始寻找了", function ():void {
                        ModuleManager.toggleModule(URLUtil.getAppModule("YiBeastPanel"), "", "1");
                    });
                }
                return;
            }
            this.hitTestArea = _map.content["hitTestRect"];
            this.hitTestArea.buttonMode = true;
            ActiveCountManager.requestActiveCount(this.LIMIT_ID, this.getData);
        }
    }

    private function getData(param1:uint, param2:uint):void {
        if (param1 == this.LIMIT_ID && param2 == 0) {
            this.hitTestArea.addEventListener(MouseEvent.CLICK, this.onClick);
        }
    }

    private function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var a:int = Math.random() * 100 < 80 ? 1 : 2;
        if (a == 1) {
            FightManager.startFightWithWild(517);
        } else if (a == 2) {
            SwapManager.swapItem(1661);
            AlertManager.showAlert("成功找到发光物，前往下一个地图继续寻找吧！", function ():void {
                ModuleManager.toggleModule(URLUtil.getAppModule("YiBeastPanel"), "", "1");
            });
        }
    }

    override public function processMapDispose():void {
        if (this.hitTestArea) {
            this.hitTestArea.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        super.processMapDispose();
    }
}
}
