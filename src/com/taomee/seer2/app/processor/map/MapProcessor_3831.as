package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.manager.EventManager;

public class MapProcessor_3831 extends MapProcessor {


    public function MapProcessor_3831(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        StatisticsManager.newSendNovice("2014系统", "经验之门", "进入经验之门场景");
        (_map.content["door"] as MovieClip).buttonMode = true;
        (_map.content["door"] as MovieClip).addEventListener(MouseEvent.CLICK, this.onOpenDoor);
        (_map.content["goYaoSai"] as MovieClip).buttonMode = true;
        (_map.content["goYaoSai"] as MovieClip).addEventListener(MouseEvent.CLICK, this.onGoYaoSai);
        EventManager.addEventListener("GoExpDoor", this.onGoExpDoor);
        (_map.front["quest83"] as MovieClip).visible = false;
    }

    private function onGoYaoSai(param1:MouseEvent):void {
        ModuleManager.showAppModule("DoorMapPanel");
    }

    private function onOpenDoor(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        ActiveCountManager.requestActiveCount(205126, function (param1:int, param2:int):void {
            if (param2 > 0) {
                ModuleManager.showAppModule("AutoFightPanel");
            } else {
                ModuleManager.showAppModule("ExpDoorMainPanel");
            }
        });
    }

    private function onGoExpDoor(param1:Event):void {
        var evt:Event = param1;
        (_map.content["door"] as MovieClip).mouseEnabled = (_map.content["door"] as MovieClip).mouseChildren = false;
        MovieClipUtil.playMc(_map.content["door"] as MovieClip, 2, (_map.content["door"] as MovieClip).totalFrames, function ():void {
            (_map.content["door"] as MovieClip).mouseEnabled = (_map.content["door"] as MovieClip).mouseChildren = true;
            (_map.content["door"] as MovieClip).gotoAndStop((_map.content["door"] as MovieClip).totalFrames);
            SwapManager.swapItem(3422, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                StatisticsManager.newSendNovice("2014系统", "经验之门", "正常进入经验之门");
                SceneManager.changeScene(SceneType.COPY, 80342);
            });
        });
    }

    override public function dispose():void {
        (_map.content["door"] as MovieClip).removeEventListener(MouseEvent.CLICK, this.onOpenDoor);
        (_map.content["goYaoSai"] as MovieClip).removeEventListener(MouseEvent.CLICK, this.onGoYaoSai);
        EventManager.removeEventListener("GoExpDoor", this.onGoExpDoor);
        super.dispose();
    }
}
}
