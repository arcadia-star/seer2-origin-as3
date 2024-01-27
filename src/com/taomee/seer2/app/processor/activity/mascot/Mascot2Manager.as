package com.taomee.seer2.app.processor.activity.mascot {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.Proclaim;
import com.taomee.seer2.core.utils.DateUtil;

import flash.utils.IDataInput;

public class Mascot2Manager {

    private static var _instance:Mascot2Manager;


    private var _currActor:Mascot2Actor;

    private var _bloodCount:int;

    public function Mascot2Manager() {
        super();
    }

    public static function get Instance():Mascot2Manager {
        if (!_instance) {
            _instance = new Mascot2Manager();
        }
        return _instance;
    }

    public function init():void {
        if (!DateUtil.isInDayAndHourScope(14, 20, 13, 15, 0, 0)) {
            return;
        }
        Connection.addCommandListener(CommandSet.NOT_1070, this.not1070);
        this._currActor = new Mascot2Actor();
        Mascot2Animation.startLoader(function ():void {
            setup();
        });
    }

    private function not1070(param1:MessageEvent):void {
        var _loc8_:uint = 0;
        var _loc9_:uint = 0;
        var _loc2_:IDataInput = param1.message.getRawData();
        if (0 == _loc2_.bytesAvailable) {
            return;
        }
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        var _loc5_:String = String(_loc2_.readUTFBytes(16));
        var _loc6_:uint = uint(_loc2_.readUnsignedInt());
        var _loc7_:uint = 0;
        while (_loc7_ < _loc6_) {
            _loc8_ = uint(_loc2_.readUnsignedInt());
            _loc9_ = uint(_loc2_.readUnsignedInt());
            if (_loc8_ == 1) {
                this._bloodCount = _loc9_;
                this._currActor.info.blood = this._bloodCount;
            }
            _loc7_++;
        }
        if (_loc3_ == 120) {
            this.updateBlood();
        } else if (_loc3_ == 118) {
            this.updateEnd();
        } else if (_loc3_ == 119) {
            this.checkEnd();
        } else if (_loc3_ == 117) {
            this.setup();
        }
    }

    private function checkEnd():void {
        if (this._bloodCount != 0) {
            this.updateStart();
        } else {
            this.end();
        }
    }

    private function end():void {
        this.dispose();
    }

    private function updateStart():void {
        this._currActor.setActor(Mascot2Animation.getMC("actor0"), SceneManager.active.mapModel);
    }

    public function updateEnd():void {
        ActiveCountManager.requestActiveCount(205955, function (param1:int, param2:int):void {
            if (param2 > 0) {
                Proclaim.addText("吉祥物已经被对手打爆，教官室出现礼包！");
                _currActor.setComplete(Mascot2Animation.getMC("actorComplete"), SceneManager.active.mapModel);
            }
        });
    }

    private function updateBlood():void {
        this._currActor.setBlood(this._bloodCount, SceneManager.active.mapModel);
    }

    public function setup():void {
        this._currActor.getTeamStatus(function ():void {
            if (_currActor.info.status == 1) {
                updateStart();
            } else if (_currActor.info.status == 2) {
                updateEnd();
            }
        });
    }

    public function dispose():void {
        if (this._currActor) {
            this._currActor.dispose();
        }
        Connection.removeCommandListener(CommandSet.NOT_1070, this.not1070);
    }
}
}
