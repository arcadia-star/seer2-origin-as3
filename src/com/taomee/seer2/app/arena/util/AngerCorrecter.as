package com.taomee.seer2.app.arena.util {
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.cmd.ArenaResourceLoadCMD;
import com.taomee.seer2.app.arena.data.FighterBuffInfo;

import seer2.next.fight.ui.data.BuffData;

import seer2.next.fight.ui.data.PetData;

public class AngerCorrecter {

    private static var thisAngerCorrecter:AngerCorrecter = new AngerCorrecter();


    private var myFighter:Fighter;

    private var hostileFighter:Fighter;

    private var myBuffInfoVec:Vector.<FighterBuffInfo>;

    private var hostileBuffInfoVec:Vector.<FighterBuffInfo>;

    private var myAnger:uint;

    private var hostileAnger:uint;

    private var sumOfTrait:int = 0;

    private var myAngerBuffArr:Array;

    private var hostileAngerBuffArr:Array;

    public function AngerCorrecter() {
        super();
    }

    public static function getInstance():AngerCorrecter {
        return thisAngerCorrecter;
    }

    public static function angerFix(pet:PetData, enemy:PetData, leftMonster:int, rightMonster:int):void {
        var fns:Array = [];
        fns = fns.concat(angerFix0(pet, enemy, leftMonster));
        fns = fns.concat(angerFix0(enemy, pet, rightMonster));
        fns.sort(function (a:Object, b:Object):int {
            return a[1] - b[1];
        });
        for (var i:int = 0; i < fns.length; i++) {
            fns[i][0]();
        }
    }

    private static function angerFix0(pet:PetData, enemy:PetData, leftMonster:int):Array {
        var fns:Array = [];

        function push(f:Function, order:int):void {
            fns.push([f, order]);
        }

        var args:Array = [0, 0, 0, 0, 0];
        for each(var buff:BuffData in pet.buffs) {
            if (buff.id == 30006) {
                args[0] = buff.count;
                push(function ():void {
                    enemy.anger = Math.max(enemy.anger - (args[0] * 2 + 3), 0);
                }, 1);
            } else if (buff.id == 11129) {
                args[1] = buff.count;
                push(function ():void {
                    pet.anger = Math.min(pet.anger + args[1] * 2 + 3, 100);
                }, 2);
            } else if (buff.id == 11891) {
                push(function ():void {
                    pet.anger = 50;
                }, 3);
            } else if (buff.id == 11900) {
                push(function ():void {
                    pet.anger = Math.min(pet.anger + (Math.min(Math.abs(pet.atk), 2)
                            + Math.min(Math.abs(pet.def), 2)
                            + Math.min(Math.abs(pet.spa), 2)
                            + Math.min(Math.abs(pet.spd), 2)
                            + Math.min(Math.abs(pet.spe), 2)
                            + Math.min(Math.abs(enemy.atk), 2)
                            + Math.min(Math.abs(enemy.def), 2)
                            + Math.min(Math.abs(enemy.spa), 2)
                            + Math.min(Math.abs(enemy.spd), 2)
                            + Math.min(Math.abs(enemy.spe), 2)
                    ) * 5, 100);
                }, 4);
            }
        }
        push(function ():void {
            pet.anger = Math.min(pet.anger + 15, 100);
        }, 5);
        if (leftMonster == 2542) {
            push(function ():void {
                if (pet.anger < 50) {
                    pet.anger = Math.min(pet.anger + 20, 100);
                } else if (pet.anger >= 50) {
                    pet.anger = Math.max(pet.anger - 15, 0);
                }
            }, 6);
        }
        return fns;
    }

    public function angerCalulater(param1:Fighter, param2:Fighter):void {
        myAngerBuffArr = [0, 0, 0, 0, 0];
        hostileAngerBuffArr = [0, 0, 0, 0, 0];
        this.myFighter = param1;
        this.hostileFighter = param2;
        myAnger = uint(myFighter.fighterInfo.fightAnger);
        hostileAnger = uint(hostileFighter.fighterInfo.fightAnger);
        if (hostileFighter.fighterInfo.fightBuffInfoVec.length == 0) {
            myAnger += 15;
            hostileAnger += 15;
        } else {
            inputBuffData();
            startCalulater();
        }
        this.myFighter.updateAnger(myAnger);
        this.hostileFighter.updateAnger(hostileAnger);
        myFighter = null;
        hostileFighter = null;
        myAngerBuffArr = null;
        hostileAngerBuffArr = null;
        this.myBuffInfoVec = null;
        this.hostileBuffInfoVec = null;
    }

    private function startCalulater():void {
        if (ArenaResourceLoadCMD.theSide == 1) {
            myCalulater();
            hostileFighterCalulater();
            myAnger += 15;
            if (myAngerBuffArr[4] != 0) {
                tianXuan(true);
            }
            hostileAnger += 15;
            if (hostileAngerBuffArr[4] != 0) {
                tianXuan(false);
            }
        } else {
            hostileFighterCalulater();
            myCalulater();
            hostileAnger += 15;
            if (hostileAngerBuffArr[4] != 0) {
                tianXuan(false);
            }
            myAnger += 15;
            if (myAngerBuffArr[4] != 0) {
                tianXuan(true);
            }
        }
    }

    private function myCalulater():void {
        if (myAngerBuffArr[0] != 0 && !this.hostileFighter.isDead()) {
            reduceAngerStar(true, myAngerBuffArr[0]);
        }
        if (myAngerBuffArr[1] != 0) {
            increaseAngerStar(true, myAngerBuffArr[1]);
        }
        if (myAngerBuffArr[2] != 0) {
            thunderSea(true);
        }
        if (myAngerBuffArr[3] != 0) {
            ImmerseRain(true);
        }
    }

    private function hostileFighterCalulater():void {
        if (hostileAngerBuffArr[0] != 0 && !this.myFighter.isDead()) {
            reduceAngerStar(false, hostileAngerBuffArr[0]);
        }
        if (hostileAngerBuffArr[1] != 0) {
            increaseAngerStar(false, hostileAngerBuffArr[1]);
        }
        if (hostileAngerBuffArr[2] != 0) {
            thunderSea(false);
        }
        if (hostileAngerBuffArr[3] != 0) {
            ImmerseRain(false);
        }
    }

    private function sumTrait(side:Boolean):void {
        sumOfTrait = 0;
        if (!(myFighter.isDead() || hostileFighter.isDead())) {
            if (side && this.hostileFighter.fighterTurnResultInfo != null) {
                hostileFighter.fighterTurnResultInfo.changedAtk = hostileFighter.fighterTurnResultInfo.changedAtk > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedAtk;
                hostileFighter.fighterTurnResultInfo.changedDefence = hostileFighter.fighterTurnResultInfo.changedDefence > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedDefence;
                hostileFighter.fighterTurnResultInfo.changedSpecialAtk = hostileFighter.fighterTurnResultInfo.changedSpecialAtk > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedSpecialAtk;
                hostileFighter.fighterTurnResultInfo.changedSpecialDefence = hostileFighter.fighterTurnResultInfo.changedSpecialDefence > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedSpecialDefence;
                hostileFighter.fighterTurnResultInfo.changedSpeed = hostileFighter.fighterTurnResultInfo.changedSpeed > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedSpeed;
            } else if (this.myFighter.fighterTurnResultInfo != null) {
                myFighter.fighterTurnResultInfo.changedAtk = myFighter.fighterTurnResultInfo.changedAtk > 2 ? 2 : myFighter.fighterTurnResultInfo.changedAtk;
                myFighter.fighterTurnResultInfo.changedDefence = myFighter.fighterTurnResultInfo.changedDefence > 2 ? 2 : myFighter.fighterTurnResultInfo.changedDefence;
                myFighter.fighterTurnResultInfo.changedSpecialAtk = myFighter.fighterTurnResultInfo.changedSpecialAtk > 2 ? 2 : myFighter.fighterTurnResultInfo.changedSpecialAtk;
                myFighter.fighterTurnResultInfo.changedSpecialDefence = myFighter.fighterTurnResultInfo.changedSpecialDefence > 2 ? 2 : myFighter.fighterTurnResultInfo.changedSpecialDefence;
                myFighter.fighterTurnResultInfo.changedSpeed = myFighter.fighterTurnResultInfo.changedSpeed > 2 ? 2 : myFighter.fighterTurnResultInfo.changedSpeed;
            }
            if (this.hostileFighter.fighterTurnResultInfo != null) {
                this.sumOfTrait += this.hostileFighter.fighterTurnResultInfo.sum();
            }
            if (this.myFighter.fighterTurnResultInfo != null) {
                this.sumOfTrait += this.myFighter.fighterTurnResultInfo.sum();
            }
        }
    }

    private function inputBuffData():void {
        this.myBuffInfoVec = myFighter.fighterInfo.fightBuffInfoVec;
        this.hostileBuffInfoVec = hostileFighter.fighterInfo.fightBuffInfoVec;
        for each(var buff:FighterBuffInfo in myBuffInfoVec) {
            if (buff.buffId == 30006) {
                myAngerBuffArr[0] = buff.dummy2;
            } else if (buff.buffId == 11129) {
                myAngerBuffArr[1] = buff.dummy2;
            } else if (buff.buffId == 11891) {
                myAngerBuffArr[2] = 1;
            } else if (buff.buffId == 11900) {
                this.sumTrait(true);
                myAngerBuffArr[3] = 1;
            }
        }
        if (myFighter.fighterInfo.resourceId == 2542) {
            myAngerBuffArr[4] = 1;
        }
        for each(buff in hostileBuffInfoVec) {
            if (buff.buffId == 30006) {
                hostileAngerBuffArr[0] = buff.dummy2;
            } else if (buff.buffId == 11129) {
                hostileAngerBuffArr[1] = buff.dummy2;
            } else if (buff.buffId == 11891) {
                hostileAngerBuffArr[2] = 1;
            } else if (buff.buffId == 11900) {
                this.sumTrait(false);
                hostileAngerBuffArr[3] = 1;
            }
        }
        if (hostileFighter.fighterInfo.resourceId == 2542) {
            hostileAngerBuffArr[4] = 1;
        }
    }

    private function reduceAngerStar(side:Boolean, level:int):void {
        if (side) {
            hostileAnger = hostileAnger < level * 2 + 3 ? 0 : hostileAnger - (level * 2 + 3);
        } else {
            myAnger = myAnger < level * 2 + 3 ? 0 : myAnger - (level * 2 + 3);
        }
    }

    private function increaseAngerStar(side:Boolean, level:int):void {
        if (side) {
            myAnger += level * 2 + 3;
        } else {
            hostileAnger += level * 2 + 3;
        }
    }

    private function thunderSea(side:Boolean):void {
        if (side) {
            myAnger = 50;
        } else {
            hostileAnger = 50;
        }
    }

    private function ImmerseRain(side:Boolean):void {
        if (side) {
            myAnger += sumOfTrait * 5;
        } else {
            hostileAnger += sumOfTrait * 5;
        }
    }

    private function tianXuan(side:Boolean):void {
        if (side) {
            if (myAnger < 50) {
                myAnger += 20;
            } else if (myAnger >= 50) {
                myAnger -= 15;
            }
        } else if (hostileAnger < 50) {
            hostileAnger += 20;
        } else if (hostileAnger >= 50) {
            hostileAnger -= 15;
        }
    }
}
}
