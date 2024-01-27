package com.taomee.seer2.app.activity.processor.salungInvade {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class KaisaFight extends SalungSoldierBase {

    private static const FIGHT_INDEX:uint = 150;


    public function KaisaFight(param1:uint) {
        super(param1);
        loadRes("SalungKaisa");
    }

    override protected function initUI():void {
        _mc = new (_info.domain.getDefinition("KaisaMc"))();
        _mc.x = MAP_OOSITION["m_" + _mapId][0];
        _mc.y = MAP_OOSITION["m_" + _mapId][1];
        LayerManager.uiLayer.addChild(_mc);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.endGame);
        _mc.addEventListener(MouseEvent.CLICK, this.fightWidthKaisa);
    }

    private function fightWidthKaisa(param1:MouseEvent):void {
        _mc.removeEventListener(MouseEvent.CLICK, this.fightWidthKaisa);
        DisplayUtil.removeForParent(this);
        DisplayUtil.removeForParent(_mc);
        FightManager.startFightWithWild(FIGHT_INDEX);
        _mc = null;
    }

    private function endGame(param1:SceneEvent):void {
        var _loc2_:int = int(FightManager.currentFightRecord.initData.positionIndex);
        if (FIGHT_INDEX == _loc2_) {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                getAward();
            }
        }
        DisplayUtil.removeForParent(this);
        DisplayUtil.removeForParent(_mc);
    }
}
}
