package com.taomee.seer2.app.activity.processor.salungInvade {
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class CloudSoldierController extends SalungSoldierBase {


    public function CloudSoldierController(param1:uint) {
        super(param1);
        loadRes("SalungCloudSoldier");
    }

    override protected function initUI():void {
        _mc = new (_info.domain.getDefinition("cloudSoldierMc"))();
        _mc.x = MAP_OOSITION["m_" + _mapId][0];
        _mc.y = MAP_OOSITION["m_" + _mapId][1];
        LayerManager.uiLayer.addChild(_mc);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.removeMc);
        this.playMc(1);
        _mc.addEventListener(MouseEvent.CLICK, this.clickHandler);
    }

    private function clickHandler(param1:MouseEvent):void {
        this.playMc(2);
    }

    private function removeMc(param1:SceneEvent):void {
        this.dispose();
    }

    override public function dispose():void {
        getAward();
        DisplayUtil.removeForParent(this);
        _mc.removeEventListener(MouseEvent.CLICK, this.clickHandler);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.removeMc);
        DisplayUtil.removeForParent(_mc);
        _mc = null;
    }

    private function playMc(param1:uint):void {
        var mcIndex:uint = param1;
        var i:int = 1;
        while (i <= 2) {
            _mc["mc" + i].visible = false;
            _mc["mc" + i].stop();
            i++;
        }
        _mc["mc" + mcIndex].visible = true;
        _mc["mc" + mcIndex].gotoAndPlay(1);
        if (mcIndex == 2) {
            (_mc["mc" + mcIndex] as MovieClip).addFrameScript(_mc["mc" + mcIndex].totalFrames - 1, function ():void {
                dispose();
            });
        }
    }
}
}
