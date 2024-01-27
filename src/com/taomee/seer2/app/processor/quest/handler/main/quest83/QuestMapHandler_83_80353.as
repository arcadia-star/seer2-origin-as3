package com.taomee.seer2.app.processor.quest.handler.main.quest83 {
import com.taomee.seer2.app.guide.info.GudieDirectionType;
import com.taomee.seer2.app.guide.manager.GuideManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.newGuidStatistics.NewGuidStatisManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.map.ResContentLibrary;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_83_80353 extends QuestMapHandler {


    private var _mc5:MovieClip;

    public function QuestMapHandler_83_80353(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 5)) {
            this._mc5 = _processor.resLib.getMovieClip("mc5");
            LayerManager.topLayer.addChild(this._mc5);
            ResContentLibrary.setInitYValue(this._mc5);
            ResContentLibrary.updateRes();
            LayerManager.resetOperation();
            _map.content["shopBtn"].addEventListener(MouseEvent.CLICK, this.onShop);
            ModuleManager.addEventListener("BusinessPanel", ModuleEvent.SET_UP, this.onShowBusiness);
            ModuleManager.addEventListener("BusinessPanel", ModuleEvent.DISPOSE, this.onDisposeBusiness);
            StatisticsManager.newSendNovice("新手引导tyler版", "2014上半年版新手引导tyler版", "进入捕捉试炼2");
        }
    }

    private function onShop(param1:MouseEvent):void {
        var _loc2_:Object = new Object();
        _loc2_.shopType = 1;
        ModuleManager.showModule(URLUtil.getAppModule("BusinessPanel"), "", _loc2_);
        NewGuidStatisManager.statisHandle(26);
    }

    private function onShowBusiness(param1:ModuleEvent):void {
        DisplayUtil.removeForParent(this._mc5);
        var _loc2_:Rectangle = new Rectangle(0, 0, 65, 65);
        GuideManager.instance.addTarget(_loc2_, 12);
        GuideManager.instance.addGuide2Target(_loc2_, 0, 12, new Point(584, 243), false, false, GudieDirectionType.CONTENT, false, true);
        GuideManager.instance.startGuide(12);
    }

    private function onDisposeBusiness(param1:ModuleEvent):void {
        GuideManager.instance.pause();
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        QuestManager.completeStep(_quest.id, 5);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        ModuleManager.removeEventListener("BusinessPanel", ModuleEvent.SET_UP, this.onShowBusiness);
        ModuleManager.removeEventListener("BusinessPanel", ModuleEvent.DISPOSE, this.onDisposeBusiness);
        var _loc2_:Object = new Object();
        _loc2_.index = 3;
        ModuleManager.showModule(URLUtil.getAppModule("GudieFightCompletePanel"), "", _loc2_);
        StatisticsManager.newSendNovice("新手引导tyler版", "2014上半年版新手引导tyler版", "完成捕捉试炼2");
    }

    override public function processMapDispose():void {
        ModuleManager.removeEventListener("BusinessPanel", ModuleEvent.SET_UP, this.onShowBusiness);
        ModuleManager.removeEventListener("BusinessPanel", ModuleEvent.DISPOSE, this.onDisposeBusiness);
        super.processMapDispose();
        ResContentLibrary.clearInitYValue(this._mc5);
        DisplayUtil.removeForParent(this._mc5);
    }
}
}
