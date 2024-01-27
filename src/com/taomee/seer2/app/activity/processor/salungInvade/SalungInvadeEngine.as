package com.taomee.seer2.app.activity.processor.salungInvade {
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DateUtil;

import flash.display.Sprite;

public class SalungInvadeEngine {

    private static var _instance:SalungInvadeEngine;

    private static const MAP_ID_VEC:Vector.<uint> = Vector.<uint>([141, 110, 180, 201, 240, 261]);

    private static const MAP_TASK:Object = {
        "m_141": [0, 3, 4, 5],
        "m_110": [0, 3, 4, 5],
        "m_180": [1, 3, 4, 5],
        "m_201": [1, 3, 4, 5],
        "m_240": [2, 3, 4, 5],
        "m_261": [2, 3, 4, 5]
    };


    private var _randomMapName:String;

    private var _mapId:uint;

    public function SalungInvadeEngine(param1:Singleton) {
        super();
    }

    public static function getInstance():SalungInvadeEngine {
        return !!_instance ? _instance : new SalungInvadeEngine(new Singleton());
    }

    public function setup():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.mapInitComplete);
    }

    private function mapInitComplete(param1:SceneEvent):void {
        this._mapId = SceneManager.active.mapID;
        if (-1 != MAP_ID_VEC.indexOf(this._mapId)) {
            this._randomMapName = "m_" + this._mapId;
            this.prepareGame();
        }
    }

    private function prepareGame():void {
        var _loc2_:Sprite = null;
        if (this.isHide || DateUtil.isInHourScope(12, 15, 0, 0) == false) {
            return;
        }
        var _loc1_:uint = this.getRandom();
        _loc1_ = uint(MAP_TASK[this._randomMapName][_loc1_]);
        if (_loc1_ == 0) {
            _loc2_ = new SalungShootEngine(this._mapId);
        } else if (_loc1_ == 1) {
            _loc2_ = new SalungHostageTarget(this._mapId);
        } else if (_loc1_ == 2) {
            _loc2_ = new SalungBoxing(this._mapId);
        } else if (_loc1_ == 3) {
            _loc2_ = new CloudSoldierController(this._mapId);
        } else if (_loc1_ == 4) {
            _loc2_ = new KaisaFight(this._mapId);
        } else if (_loc1_ == 5) {
            _loc2_ = new DoomBoltSoldier(this._mapId);
        }
        LayerManager.topLayer.addChild(_loc2_);
    }

    private function get isHide():Boolean {
        var _loc1_:uint = Math.random() * 100000 / 10;
        return _loc1_ < 5;
    }

    private function getRandom():uint {
        return Math.random() * 10000000 % 4;
    }
}
}

class Singleton {


    public function Singleton() {
        super();
    }
}
