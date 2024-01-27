package com.taomee.seer2.app.arena.controller {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.data.FighterChangeInfo;
import com.taomee.seer2.app.arena.data.FighterTeam;
import com.taomee.seer2.app.arena.util.FightPostion;
import com.taomee.seer2.app.arena.util.FightSide;

public class BaseModeChange implements IFighterChange {


    protected var _scene:ArenaScene;

    protected var _isRightFighterChanged:Boolean;

    protected var _changeInfos:Vector.<FighterChangeInfo>;

    public function BaseModeChange(param1:ArenaScene) {
        super();
        this._scene = param1;
    }

    public function dispose():void {
        this._scene = null;
        if (this._changeInfos != null) {
            this._changeInfos.splice(0, this._changeInfos.length);
        }
    }

    public function changeFighter(param1:uint, param2:uint, param3:uint, param4:uint = 1):void {
        var _loc6_:Fighter = null;
        var _loc5_:Boolean;
        if ((_loc5_ = this.leftTeam.containsFighter(param1, param2)) == true) {
            if ((_loc6_ = this.leftTeam.getFighter(param1, param2)) == null) {
                _loc6_ = this.leftTeam.getChangeFighter(param1, param2);
            }
            if (param4 == FightPostion.MAIN && this.leftMainFighter.id != param2) {
                this.changeLeftMainFighter(_loc6_, param3);
            } else if (param4 == FightPostion.SUB) {
                if (this.leftSubFighter == null || this.leftSubFighter && this.leftSubFighter.id != param2) {
                    this.changeLeftSubFighter(_loc6_, param3);
                }
            }
        } else if (this.rightTeam.getFighter(param1, param2) != null || this.rightTeam.getChangeFighter(param1, param2) != null) {
            if (this._scene.arenaData.isDoubleMode) {
                if (param4 == FightPostion.MAIN && this.rightMainFighter.id != param2) {
                    this.saveRightFighter(param1, param2, param3, param4);
                } else if (param4 == FightPostion.SUB) {
                    if (this.rightSubFighter == null || this.rightSubFighter && this.rightSubFighter.id != param2) {
                        this.saveRightFighter(param1, param2, param3, param4);
                    }
                }
            } else if (param4 == FightPostion.MAIN && this.rightMainFighter.id != param2) {
                this.saveRightFighter(param1, param2, param3, param4);
            } else if (param4 == FightPostion.SUB && (this.rightSubFighter && this.rightSubFighter.id != param2)) {
                this.saveRightFighter(param1, param2, param3, param4);
            }
        }
    }

    private function saveRightFighter(param1:uint, param2:uint, param3:uint, param4:uint = 1):void {
        if (this._changeInfos == null) {
            this._changeInfos = new Vector.<FighterChangeInfo>();
        }
        var _loc5_:Fighter;
        if ((_loc5_ = this.rightTeam.getFighter(param1, param2)) == null) {
            _loc5_ = this.rightTeam.getChangeFighter(param1, param2);
        }
        _loc5_.fighterInfo.fightAnger = param3;
        this._isRightFighterChanged = true;
        this._changeInfos.push(new FighterChangeInfo(param4, _loc5_));
    }

    public function changeLeftMainFighter(param1:Fighter, param2:uint):void {
    }

    public function changeLeftSubFighter(param1:Fighter, param2:uint):void {
    }

    public function checkRightFighterChanged():void {
        var onChangeComplete:Function;
        var changeInfo:FighterChangeInfo = null;
        var _newRightFighter:Fighter = null;
        var _newPosition:uint = 0;
        if (this._isRightFighterChanged == true) {
            onChangeComplete = function ():void {
                arenaUIController.updateStatusPanelInfo();
                arenaUIController.updateOppositeFighter();
                _newRightFighter = null;
                _newPosition = 0;
                arenaUIController.updateStatusPanel();
                _scene.sortAllFighters();
                if (_changeInfos.length > 0) {
                    checkRightFighterChanged();
                } else {
                    _isRightFighterChanged = false;
                }
            };
            changeInfo = this._changeInfos.pop();
            _newRightFighter = changeInfo.newFighter;
            _newPosition = changeInfo.newPosition;
            if (_newRightFighter.fighterInfo.position == FightPostion.INACTIVE) {
                if (_newPosition == FightPostion.MAIN) {
                    this.rightMainFighter.disappear(FightSide.RIGHT);
                    this.rightTeam.replaceFighterPositionWithActive(FightPostion.MAIN, _newRightFighter);
                    _newRightFighter.updatePosition();
                    this._scene.mapModel.content.addChild(this.rightMainFighter);
                } else if (_newPosition == FightPostion.SUB) {
                    this.rightSubFighter.disappear(FightSide.RIGHT);
                    this.rightTeam.replaceFighterPositionWithActive(FightPostion.SUB, _newRightFighter);
                    _newRightFighter.updatePosition();
                    this._scene.mapModel.content.addChild(this.rightSubFighter);
                }
                onChangeComplete();
            } else {
                this.rightTeam.changeMainSubPosition(onChangeComplete);
            }
        }
    }

    protected function hasDeadFighter():Boolean {
        var _loc1_:Boolean = false;
        if (this.leftMainFighter.fighterInfo.hp <= 0) {
            _loc1_ = true;
        }
        if (this.leftSubFighter != null && this.leftSubFighter.fighterInfo.hp <= 0) {
            _loc1_ = true;
        }
        if (this.rightMainFighter.fighterInfo.hp <= 0) {
            _loc1_ = true;
        }
        if (this.rightSubFighter != null && this.rightSubFighter.fighterInfo.hp <= 0) {
            _loc1_ = true;
        }
        return _loc1_;
    }

    protected function get fightController():IFightController {
        if (this._scene) {
            return this._scene.fightController;
        }
        return null;
    }

    protected function get arenaUIController():IArenaUIController {
        return this._scene.arenaUIController;
    }

    protected function get leftTeam():FighterTeam {
        return this._scene.leftTeam;
    }

    protected function get rightTeam():FighterTeam {
        return this._scene.rightTeam;
    }

    protected function get rightMainFighter():Fighter {
        return this.rightTeam.mainFighter;
    }

    protected function get leftMainFighter():Fighter {
        return this.leftTeam.mainFighter;
    }

    protected function get rightSubFighter():Fighter {
        return this.rightTeam.subFighter;
    }

    protected function get leftSubFighter():Fighter {
        return this.leftTeam.subFighter;
    }
}
}
